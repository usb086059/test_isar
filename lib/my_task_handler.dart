import 'dart:async';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_application_1/bluetooth_services.dart';

// The callback function should always be a top-level or static function.
@pragma('vm:entry-point')
void startCallback() {
  print(
      '************************************************************ StartCallback');
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

Stream<OnConnectionStateChangedEvent> get conectionStateTask =>
    FlutterBluePlus.events.onConnectionStateChanged;

class MyTaskHandler extends TaskHandler {
  Device dev = Device(
      tipo: 'tipo',
      mac: 'mac',
      nombre: 'nombre',
      conectado: false,
      relojAsignado: 0);
  bool reconnectEnabled = false;
  BluetoothServices bluetoothServices = BluetoothServices();
  StreamSubscription<OnConnectionStateChangedEvent>?
      subscriptionStateConectionTask;
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
  // Called when the task is started.
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    print('onStart(starter: ${starter.name})');
    subscriptionStateConectionTask?.cancel();
    subscriptionStateConectionTask = conectionStateTask.listen(
      (event) async {
        print(
            '****************** Un dispositivo cambio su StateConnection: ${event.connectionState}');
        subscriptionStateConectionTask?.cancel();
        Map<String, dynamic> data = {
          'command': 'getDevice',
          'deviceId': event.device.remoteId.toString()
        };
        FlutterForegroundTask.sendDataToMain(data);
        await Future.delayed(const Duration(seconds: 2));
        if (event.connectionState == BluetoothConnectionState.disconnected) {
          await bluetoothServices.caracteristicas(event.device, true);
          dev.conectado = false;
          data = {'command': 'editDevice', 'device': dev};
          FlutterForegroundTask.sendDataToMain(data);
          if (!event.device.isAutoConnectEnabled && reconnectEnabled) {
            await bluetoothServices.reConectar(event.device);
          }
          print('****************** Listen Disconnnected Realizado');
        }
        if (event.connectionState == BluetoothConnectionState.connected) {
          print('***********>>>>> Estoy en event.connected del taskHandler');
          reconnectEnabled = true;
          dev.conectado = true;
          data = {'command': 'editDevice', 'device': dev};
          FlutterForegroundTask.sendDataToMain(data);
          if (event.device.isAutoConnectEnabled) {
            bool characteristicExist = false;
            for (int i = 0; i < 5; i++) {
              if (bluetoothServices.getListCaracteristicas[i].remoteId ==
                  event.device.remoteId) {
                characteristicExist = true;
                i = 5;
              }
            }
            if (!characteristicExist && dev.relojAsignado == 0) {
              await bluetoothServices.descubrirServicios(event.device);
            }
          }
        }
      },
      onError: (error, stackTrace) {
        print('!!!! MinimalTaskHandler ERROR: $error\n$stackTrace');
      },
      onDone: () {
        print('!!!! MinimalTaskHandler: Listener onDone.');
      },
      cancelOnError: false,
    );
    _adapterStateSubscription =
        FlutterBluePlus.adapterState.listen((state) async {
      print('******************* Adapter State Changed (UI): $state');
      if (state == BluetoothAdapterState.on) {
        print('******************* Bluetooth is ON (UI)!');
        //Realiza acciones aquí si necesitas saber cuando se activa desde la UI
      }
    });
  }

  // Called based on the eventAction set in ForegroundTaskOptions.
  @override
  void onRepeatEvent(DateTime timestamp) {
    // Send data to main isolate.
    final Map<String, dynamic> data = {
      'command': 'fecha',
      'timestampMillis': timestamp.millisecondsSinceEpoch,
    };
    FlutterForegroundTask.sendDataToMain(data);
  }

  // Called when the task is destroyed.
  @override
  Future<void> onDestroy(DateTime timestamp) async {
    print('******************** onDestroy');
    subscriptionStateConectionTask?.cancel();
    _adapterStateSubscription?.cancel();
  }

  // Called when data is sent using `FlutterForegroundTask.sendDataToTask`.
  @override
  void onReceiveData(Object data) async {
    print('onReceiveData: $data');
    if (data is Map<String, dynamic>) {
      final String command = data['command'];
      switch (command) {
        case 'conectar':
          print(
              '**************** TaskHandler: Recibido comando para CONECTAR a dispositivo');
          final BluetoothDevice device = data['device'];

          // ¡Aquí es donde el TaskHandler inicia la conexión!
          try {
            print(
                '*********** TaskHandler: Iniciando conexión a ${device.remoteId}...');
            await device.connect();
            print(
                '*********** TaskHandler: device.connect() llamado para ${device.remoteId}');
            if (device.isConnected) {
              await bluetoothServices.descubrirServicios(device);
            }
            // No esperes eventos aquí; el listener global debería capturarlos
            // sendPort?.send({'connectionStatus': {'id': device.remoteId.str, 'status': 'connecting'}});
          } catch (e) {
            print(
                '*********** TaskHandler: FALLÓ la llamada a connect() para ${device.remoteId}: $e');
            //sendPort?.send({'deviceConnectionState': {'id': device.remoteId.str, 'state': BluetoothConnectionState.disconnected.toString(), 'error': e.toString()}});
          }
        case 'desconectar':
          final BluetoothDevice device = FlutterBluePlus.connectedDevices
              .firstWhere(
                  (element) => element.remoteId.toString() == data['deviceId']);
          await device.disconnect();
        /* case 'getBatteryAzul':
          final String bateryAzul =
              bluetoothServices.getBatteryLevelAzul(data['deviceId']);
          final Map<String, dynamic> datax = {
            'command': 'batteryLevelAzul',
            'batteryAzul': bateryAzul
          };
          FlutterForegroundTask.sendDataToMain(datax); */
        case 'deviceFoundInDatabase':
          dev = data['device'];
        case 'sendCommand':
          await bluetoothServices.sendCommand(data['packCommand']);
      }

      //if (command == 'conectar' && deviceId != null) {}
    } else {
      //ToDo: Avisar a la UI que el bluetooth esta apagado
    }
  }

  // Called when the notification button is pressed.
  @override
  void onNotificationButtonPressed(String id) {
    print('onNotificationButtonPressed: $id');
  }

  // Called when the notification itself is pressed.
  @override
  void onNotificationPressed() {
    print('onNotificationPressed');
  }

  // Called when the notification itself is dismissed.
  @override
  void onNotificationDismissed() {
    print('onNotificationDismissed');
  }
}
