import 'dart:async';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

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
      "timestampMillis": timestamp.millisecondsSinceEpoch,
    };
    FlutterForegroundTask.sendDataToMain(data);
  }

  // Called when the task is destroyed.
  @override
  Future<void> onDestroy(DateTime timestamp) async {
    print('onDestroy');
  }

  // Called when data is sent using `FlutterForegroundTask.sendDataToTask`.
  @override
  void onReceiveData(Object data) async {
    print('onReceiveData: $data');
    if (data is Map<String, dynamic>) {
      final String command = data['command'];
      final String deviceId = data['deviceId'];
      if (command == 'conectar' && deviceId != null) {
        print(
            '**************** TaskHandler: Recibido comando para CONECTAR a dispositivo');
        final device = BluetoothDevice.fromId(deviceId);

        // ¡Aquí es donde el TaskHandler inicia la conexión!
        try {
          print(
              '*********** TaskHandler: Iniciando conexión a ${device.remoteId}...');
          await device.connect(
              autoConnect: false); // Crucial: autoConnect: true para el fondo
          print(
              '*********** TaskHandler: device.connect() llamado para ${device.remoteId}');
          // No esperes eventos aquí; el listener global debería capturarlos
          // sendPort?.send({'connectionStatus': {'id': device.remoteId.str, 'status': 'connecting'}});
        } catch (e) {
          print(
              '*********** TaskHandler: FALLÓ la llamada a connect() para ${device.remoteId}: $e');
          //sendPort?.send({'deviceConnectionState': {'id': device.remoteId.str, 'state': BluetoothConnectionState.disconnected.toString(), 'error': e.toString()}});
        }
      }
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
