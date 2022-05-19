import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:battery_info/battery_info_plugin.dart';

class CpuApp extends StatefulWidget {
  const CpuApp({Key? key}) : super(key: key);

  @override
  State<CpuApp> createState() => _CpuAppState();
}

class _CpuAppState extends State<CpuApp> {
  int index = 0;

  late Future<Map<String, dynamic>?> _deviceData;

  @override
  void initState() {
    super.initState();
    _deviceData = _getAndroidDeviceInfor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CPU-Z")),
      body: _buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const [
          //index = 0
          BottomNavigationBarItem(
              icon: Icon(
                Icons.info_outline,
                color: Colors.black,
              ),
              label: "SOC"),
          //index = 1
          BottomNavigationBarItem(
              icon: Icon(
                Icons.device_hub_outlined,
                color: Colors.black,
              ),
              label: "DEVICE"),
          //index = 2
          BottomNavigationBarItem(
              icon: Icon(
                Icons.system_security_update_good_outlined,
                color: Colors.black,
              ),
              label: "SYSTEM"),
          //index = 3
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.battery_full_outlined,
          //       color: Colors.black,
          //     ),
          // label: "SYSTEM"),
        ],
        // Có thể viết các câu lệnh chuyển trang trong onTap
        // ứng với các giá trị của value
        // value: Giá trị khi chạm vào các nút
        // Nếu chuyển trang thì không cần viết setState
        // Ứng dụng minh họa chỉ hiển thị trên một trang
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }

  Future<Map<String, dynamic>?> _getAndroidDeviceInfor() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo deviceInfoData = await deviceInfo.androidInfo;
    return <String, dynamic>{
      "manufacturer": deviceInfoData.manufacturer,
      'display': deviceInfoData.display,
      'hardware': deviceInfoData.hardware,
      'android.version': deviceInfoData.version.release,
      'system.features': deviceInfoData.systemFeatures,
    };
  }

  Widget _buildHome(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _deviceData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Loi xay ra");
          return const Text("Lỗi xảy ra");
        }
        return snapshot.hasData
            ? _buildBattery(
                context,
                snapshot.data!,
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget _buildSettings(BuildContext context) {
    return const Center(
      child: Text(
        "Setting page",
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  Widget _buildShoppingCart(BuildContext context) {
    return const Center(
      child: Text(
        "Shopping page",
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  Widget _buildBattery(BuildContext context, Map<String, dynamic>? deviceData) {
    return ListView(
      children: deviceData!.keys.map(
        (String property) {
          return Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                width: 150,
                child: Text(
                  property,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                child: Text(
                  '${deviceData[property]}',
                  style: const TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 107, 25, 214)),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
            ],
          );
        },
      ).toList(),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (index == 0) {
      return _buildHome(context);
    }
    if (index == 1) {
      return _buildSettings(context);
    } else {
      return _buildShoppingCart(context);
    }
  }
}
