import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_google_services.dart';
import 'package:flutter_application_1/ble_services.dart';
import 'package:flutter_application_1/curve_services.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/firebase_services.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_application_1/my_task_handler.dart';
import 'package:flutter_application_1/navigation_bar_redes.dart';
import 'package:flutter_application_1/services.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  //StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
  @override
  void initState() {
    super.initState();
    /* _adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      print(
          '************************************* Adapter State Changed (UI): $state');
      if (state == BluetoothAdapterState.on) {
        print('************************************* Bluetooth is ON (UI)!');
        // Realiza acciones aquí si necesitas saber cuándo se activa desde la UI
      }
    }); */

    // Add a callback to receive data sent from the TaskHandler.
    FlutterForegroundTask.addTaskDataCallback(_onReceiveTaskData);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Request permissions and initialize the service.
      await _requestPermissions();
      _initService();
      await _startService();
      //await ref.read(bleProvider).bleTurnOn();
    });
  }

  // Se llama después de initState y cuando cambian las dependencias del widget.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(
        '********************************* MyHomePageState: didChangeDependencies');
    // Realizar acciones que dependen de InheritedWidgets o Providers.
    // Por ejemplo, leer un Provider por primera vez aquí si es necesario para la inicialización.
  }

  // Se llama cuando el widget se retira del árbol, pero podría volver a insertarse.
  @override
  void deactivate() {
    print(
        'MyHomePageState: deactivate - La aplicación va a segundo plano (posiblemente)');
    super.deactivate();
    // Realizar limpieza temporal o guardar el estado transitorio si es necesario.
  }

  @override
  void dispose() {
    //_adapterStateSubscription?.cancel();
    // Remove a callback to receive data sent from the TaskHandler.
    FlutterForegroundTask.removeTaskDataCallback(_onReceiveTaskData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    UserCredential? user;
/*     double anchoMin = MediaQuery.of(context).size.width * 0.35;
    double anchoMax = MediaQuery.of(context).size.width * 0.95;
    double altoMin = MediaQuery.of(context).size.height * 0.35;
    double altoMax = MediaQuery.of(context).size.height * 0.5; */
    List<Device> listDeviceConected = [];
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        print('************* didPop es $didPop **************');
        if (didPop) {
          //context.go('/'); //return;
        } else {
          print('************* didPop es $didPop **************');
          //context.go('/');
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Stack(
          children: [
            Container(
              decoration: BoxDecoration(gradient: fondoLoginScreenGradient()),
            ),
            ClipPath(
              clipper: LoginCurve(),
              child: Container(
                decoration: BoxDecoration(gradient: purpleGradientCurvas()),
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
              ),
            ),
            Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                      onPressed: () async {
                        await _startService();
                      },
                      icon: const Icon(Icons.ac_unit)),
                ),
                body: Container(
                  height: heightScreen,
                  width: widthScreen,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          Image.asset(
                            'assets/logoEnNegro1080.png',
                            scale: 3.5,
                          ),
                          const SizedBox(height: 100),
                          Container(
                            constraints: BoxConstraints(
                                maxHeight: heightScreen * 0.1,
                                minHeight: heightScreen * 0.1,
                                minWidth: widthScreen * 0.95,
                                maxWidth: widthScreen * 0.95),
                            child: Image.asset(
                              'assets/8.png',
                              //color: Colors.white,
                              scale: 20,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(
                                maxHeight: heightScreen * 0.14,
                                minHeight: heightScreen * 0.14,
                                minWidth: widthScreen * 0.95,
                                maxWidth: widthScreen * 0.95),
                            child: Image.asset(
                              'assets/10.png',
                              scale: 18,
                            ),
                          ),
                          const SizedBox(height: 90),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 5, bottom: 18),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage('assets/icons/icono9.png'))),
                            child: FilledButton.tonalIcon(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.transparent)),
                                onPressed: () async {
                                  print(
                                      '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Usuario es: ${FirebaseAuth.instance.currentUser}');
                                  print(
                                      '+++++++++++++++++++++++++++++++++++++++ Usuario es: ${user}');
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                            child: CircularProgressIndicator(
                                          color: const Color.fromARGB(
                                              255, 50, 102, 175),
                                          backgroundColor: Colors.purple[300],
                                        ));
                                      });
                                  if (FirebaseAuth.instance.currentUser ==
                                      null) {
                                    user = await signInWithGoogle();

                                    print(
                                        '************************************** Usuario es: $user');
                                    if (user?.user != null) {
                                      final List googleID = await getGoogleID();
                                      final String estaRegistrado =
                                          await googleID.firstWhere(
                                              (element) =>
                                                  element == user?.user!.uid,
                                              orElse: () => 'no existe');
                                      if (context.mounted) {
                                        context.pop();
                                        if (ref.read(primerArranqueProvider) ==
                                            false) {
                                          listDeviceConected = await ref
                                              .read(servicesProvider)
                                              .getAllDeviceConected();
                                          if (listDeviceConected.isNotEmpty) {
                                            for (var element
                                                in listDeviceConected) {
                                              element.conectado = false;
                                              element.relojAsignado = 0;
                                              await ref
                                                  .read(servicesProvider)
                                                  .editDevice(element);
                                            }
                                          }
                                        }
                                        if (estaRegistrado == user?.user!.uid) {
                                          ref
                                              .read(primerArranqueProvider
                                                  .notifier)
                                              .update((state) => true);
                                          if (ref.read(cerroSesion)) {
                                            context.pop();
                                          } else {
                                            context.push('/bluetooth');
                                          }
                                        } else {
                                          ref
                                              .read(primerArranqueProvider
                                                  .notifier)
                                              .update((state) => true);
                                          context.push('/register');
                                        }
                                      }
                                    } else {
                                      if (context.mounted) {
                                        showDialogAviso(
                                            context, heightScreen, widthScreen);
                                        print(
                                            '*********************************** Detecto nulo');
                                        await Future.delayed(
                                            const Duration(seconds: 3));
                                        if (context.mounted) {
                                          context.pop();
                                        }
                                      }
                                      if (context.mounted) {
                                        context.pop();
                                      }
                                    }
                                  } else {
                                    if (context.mounted) {
                                      context.pop();
                                      if (ref.read(primerArranqueProvider) ==
                                          false) {
                                        listDeviceConected = await ref
                                            .read(servicesProvider)
                                            .getAllDeviceConected();
                                        if (listDeviceConected.isNotEmpty) {
                                          for (var element
                                              in listDeviceConected) {
                                            element.conectado = false;
                                            element.relojAsignado = 0;
                                            await ref
                                                .read(servicesProvider)
                                                .editDevice(element);
                                          }
                                        }
                                      }
                                      ref
                                          .read(primerArranqueProvider.notifier)
                                          .update((state) => true);
                                      if (ref.read(cerroSesion)) {
                                        if (context.mounted) {
                                          context.pop();
                                        }
                                      } else {
                                        if (context.mounted) {
                                          context.push('/bluetooth');
                                        }
                                      }
                                    }
                                  }
                                },
                                icon: Image.asset('assets/logo-google-G.png',
                                    scale: 20),
                                label: const Text(
                                  'Inicie sesión con Google',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 50, 102, 175),
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: const NavigationBarRedes()),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showDialogAviso(
      BuildContext context, double heightScreen, double widthScreen) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Stack(children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    constraints: BoxConstraints(
                        maxHeight: heightScreen * 0.214,
                        maxWidth: widthScreen * 0.783),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    constraints: BoxConstraints(
                        maxHeight: heightScreen * 0.214,
                        maxWidth: widthScreen * 0.783),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(30),
                        gradient: gradientAlertDialog()),
                    child: Container(),
                  ),
                ),
              ),
              const AlertDialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                title: Text(
                  'Error de conexión',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      //fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                content: Text(
                  'Revise su conexión a internet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          );
        });
  }

  void _onReceiveTaskData(Object data) async {
    if (data is Map<String, dynamic>) {
      final String command = data['command'];
      switch (command) {
        case 'getDevice':
          final Device dev =
              await ref.read(servicesProvider).getDevice(data['deviceId']);
          Map<String, dynamic> dataToSend = {
            'command': 'deviceFoundInDatabase',
            'device': dev
          };
          FlutterForegroundTask.sendDataToTask(dataToSend);
        case 'getDeviceForScanResult':
          Device dev = Device(
              tipo: 'tipo',
              mac: 'mac',
              nombre: 'nombre',
              conectado: false,
              relojAsignado: 0);
          final List<Device> devicesInDatabase =
              await ref.read(servicesProvider).getAllDevice();
          if (devicesInDatabase.isNotEmpty) {
            dev = devicesInDatabase.firstWhere(
              (element) => element.mac == data['deviceId'],
              orElse: () => dev,
            );
          }
          Map<String, dynamic> dataToSend = {
            'command': 'deviceForScannedDevices',
            'device': dev
          };
          FlutterForegroundTask.sendDataToTask(dataToSend);
        case 'updateScannedDevices':
          ref.read(bleProvider).setScannedDevices(data['scannedDevices']);
        case 'editDevice':
          await ref.read(servicesProvider).editDevice(data['device']);
        case 'batteryLevel':
          ref.read(bleProvider).setBleServicesBatery(data['battery']);
          ref.read(bleProvider).setBleServicesBatteryAzul(data['batteryAzul']);
          ref
              .read(bleProvider)
              .setCaractericticasRemoteId(data['caracteristicasRemoteId']);
        case 'blutoothState':
          ref.read(bleProvider).setBluetoothState(data['state']);
        default:
          break;
      }
      final dynamic timestampMillis = data['timestampMillis'];
      if (timestampMillis != null) {
        final DateTime timestamp =
            DateTime.fromMillisecondsSinceEpoch(timestampMillis, isUtc: true);
        print('timestamp: ${timestamp.toString()}');
      }
    }
  }

  Future<void> _requestPermissions() async {
    // Android 13+, you need to allow notification permission to display foreground service notification.
    //
    // iOS: If you need notification, ask for permission.
    final NotificationPermission notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    if (Platform.isAndroid) {
      // Android 12+, there are restrictions on starting a foreground service.
      //
      // To restart the service on device reboot or unexpected problem, you need to allow below permission.
      if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
        // This function requires `android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` permission.
        await FlutterForegroundTask.requestIgnoreBatteryOptimization();
      }

      // Use this utility only if you provide services that require long-term survival,
      // such as exact alarm service, healthcare service, or Bluetooth communication.
      //
      // This utility requires the "android.permission.SCHEDULE_EXACT_ALARM" permission.
      // Using this permission may make app distribution difficult due to Google policy.
      /* if (!await FlutterForegroundTask.canScheduleExactAlarms) {
        // When you call this function, will be gone to the settings page.
        // So you need to explain to the user why set it.
        await FlutterForegroundTask.openAlarmsAndRemindersSettings();
      } */
    }
  }

  void _initService() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription:
            'This notification appears when the foreground service is running.',
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<ServiceRequestResult> _startService() async {
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      print(
          '************************************************************ StartServcie');
      return FlutterForegroundTask.startService(
        serviceId: 256,
        notificationTitle: 'Foreground Service is running',
        notificationText: 'Tap to return to the app',
        notificationIcon: null,
        notificationButtons: [
          const NotificationButton(id: 'btn_hello', text: 'hello'),
        ],
        notificationInitialRoute: '/',
        callback: startCallback,
      );
    }
  }
}
