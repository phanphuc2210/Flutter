import 'package:flutter/material.dart';

class DevicePage extends StatefulWidget {
  Map<String, dynamic>? deviceData;
  DevicePage({Key? key, required this.deviceData}) : super(key: key);

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.deviceData!.keys.map(
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
                  '${widget.deviceData![property]}',
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
}
