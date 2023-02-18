import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_module/main.dart';
import 'package:world_module/main.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FlutterModule(),
    );
  }
}

class FlutterModule extends StatefulWidget {
  const FlutterModule({super.key});

  @override
  State<FlutterModule> createState() => _FlutterModuleState();
}

class _FlutterModuleState extends State<FlutterModule> {
  static const platform = MethodChannel("com.flutter.modules");

  String actualRoute = "/";

  @override
  void initState() {
    super.initState();
    _setupFlutterModules();
  }

  @override
  Widget build(BuildContext context) {
    switch (actualRoute) {
      case "/route1":
        return const HelloModule();
      case "/route2":
        return const WorldModule();
      default:
        return const Scaffold(
          body: Center(
            child: Text('Hello World'),
          ),
        );
    }
  }

  void _setupFlutterModules() async {
    platform.setMethodCallHandler(nativeMethodCallHandler);

    final Map configuration =
        await platform.invokeMethod("setupFlutterModules");

    debugPrint('FLUTTER >>>>>> $configuration');
  }

  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "changeRoute":
        debugPrint('FLUTTER >>>>>> ${methodCall.arguments}');
        final String route = methodCall.arguments;
        setState(() {
          actualRoute = route;
        });
        return;
      default:
        return;
    }
  }
}
