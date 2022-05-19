import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/cpu_z_version2/device_page.dart';
import "package:system_info/system_info.dart";

const int MEGABYTE = 1024 * 1024;

class MyCpuApp extends StatefulWidget {
  const MyCpuApp({Key? key}) : super(key: key);

  @override
  State<MyCpuApp> createState() => _MyCpuAppState();
}

class _MyCpuAppState extends State<MyCpuApp> {
  Map<String, dynamic>? _deviceData;
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.black,
                  bottom: const TabBar(tabs: [
                    Tab(
                      text: "SOC",
                    ),
                    Tab(
                      text: "DEVICE",
                    ),
                    Tab(
                      text: "SYSTEM",
                    )
                  ]),
                  title: const Text("CPU-Z")),
              body: TabBarView(
                children: [
                  Text("SOC"),
                  DevicePage(deviceData: _deviceData),
                  Text("SYSTEM"),
                ],
              ))),
    );
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var deviceData = _getAndroidDeviceInfor(await deviceInfo.androidInfo);

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _getAndroidDeviceInfor(
      AndroidDeviceInfo deviceInfoData) {
    return {
      'model': deviceInfoData.model,
      "manufacturer": deviceInfoData.manufacturer,
      'board': deviceInfoData.board,
      'hardware': deviceInfoData.hardware,
      'screenSize': MediaQuery.of(context).size,
      'display': deviceInfoData.display,
      'total RAM': "${SysInfo.getTotalPhysicalMemory() ~/ MEGABYTE} MB",
      'available RAM': "${SysInfo.getFreePhysicalMemory() ~/ MEGABYTE} MB",
    };
  }
}
