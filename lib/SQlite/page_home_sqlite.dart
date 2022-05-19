import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:phuc_61cntt1/SQlite/page_user_detail.dart';
import 'package:phuc_61cntt1/SQlite/provider_data.dart';
import 'package:phuc_61cntt1/SQlite/sqlite_data.dart';
import 'package:provider/provider.dart';

class PageListUserSQLite extends StatefulWidget {
  const PageListUserSQLite({Key? key}) : super(key: key);

  @override
  State<PageListUserSQLite> createState() => _PageListUserSQLiteState();
}

class _PageListUserSQLiteState extends State<PageListUserSQLite> {
  BuildContext? _dinalogContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite Demo"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageUserSQLiteDetail(xem: false),
                  )),
              icon: const Icon(Icons.add_circle_outline, color: Colors.white))
        ],
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, databaseProvider, child) {
          if (databaseProvider.users == null) {
            return const Center(
              child: Text("Chưa có dữ liệu!"),
            );
          } else {
            return ListView.separated(
                itemBuilder: (context, index) {
                  _dinalogContext = context;
                  User user = databaseProvider.users![index];
                  return Slidable(
                    child: ListTile(
                      leading: Text(
                        "${user.id}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        user.name!,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.indigo),
                      ),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Phone: ${user.phone}"),
                            Text("Email: ${user.email}"),
                          ]),
                    ),
                    endActionPane:
                        ActionPane(motion: const DrawerMotion(), children: [
                      SlidableAction(
                        onPressed: (context) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PageUserSQLiteDetail(xem: true, user: user),
                            )),
                        icon: Icons.details,
                        foregroundColor: Colors.green,
                        backgroundColor: Colors.green[50]!,
                      ),
                      SlidableAction(
                        onPressed: (context) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PageUserSQLiteDetail(xem: false, user: user),
                            )),
                        icon: Icons.edit,
                        foregroundColor: Colors.blue,
                        backgroundColor: Colors.blue[50]!,
                      ),
                      SlidableAction(
                        onPressed: (context) => _xoa(_dinalogContext, user),
                        icon: Icons.delete_forever,
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.red[50]!,
                      )
                    ]),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                    ),
                itemCount: databaseProvider.users!.length);
          }
        },
      ),
    );
  }

  Future<String?> showConfirmDialog(
      BuildContext context, String disMessage) async {
    AlertDialog dialog = AlertDialog(
      title: const Text("Xác nhận"),
      content: Text(disMessage),
      actions: [
        ElevatedButton(
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop("cancel"),
            child: const Text("Hủy")),
        ElevatedButton(
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pop("ok"),
            child: const Text("OK")),
      ],
    );
    String? res = await showDialog<String?>(
        barrierDismissible: false,
        context: context,
        builder: (context) => dialog);
    return res;
  }

  @override
  void dispose() {
    DatabaseProvider provider = context.read<DatabaseProvider>();
    provider.closeDatabase();
  }

  _xoa(BuildContext? dialogContext, User user) async {
    String? confirm =
        await showConfirmDialog(context, "Bạn muốn xóa ${user.name}");
    if (confirm == "ok") {
      DatabaseProvider provider = context.read<DatabaseProvider>();
      provider.deleteUser(user.id!);
    }
  }
}
