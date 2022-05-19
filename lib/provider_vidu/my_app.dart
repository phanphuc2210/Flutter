import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/provider_vidu/counter_page.dart';
import 'package:phuc_61cntt1/provider_vidu/my_provider.dart';
import 'package:provider/provider.dart';

class MyProviderApp extends StatelessWidget {
  const MyProviderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MaterialApp(home: CounterPage()),
    );
  }
}
