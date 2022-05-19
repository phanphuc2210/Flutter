import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/SQlite/page_home_sqlite.dart';
import 'package:phuc_61cntt1/SQlite/provider_data.dart';
import 'package:provider/provider.dart';

class SQLiteApp extends StatefulWidget {
  const SQLiteApp({Key? key}) : super(key: key);

  @override
  State<SQLiteApp> createState() => _SQLiteAppState();
}

class _SQLiteAppState extends State<SQLiteApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        var databaseProvider = DatabaseProvider();
        databaseProvider.readUsers();
        return databaseProvider;
      },
      child: const MaterialApp(
        title: "SQLite Demo App",
        home: PageListUserSQLite(),
      ),
    );
  }
}
