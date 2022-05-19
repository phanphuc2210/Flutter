import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({Key? key}) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final nameEditingController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hello My Friend")),
      drawer: Container(
        width: 200,
        color: Colors.white,
        child: Column(children: const [
          SizedBox(
            height: 50,
          ),
          TextButton(onPressed: null, child: Text("Menu1"))
        ]),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameEditingController,
                decoration: const InputDecoration(
                    hintText: "Nhập tên vào đây", labelText: "Tên:"),
                keyboardType: TextInputType.phone,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () => _showSnackBar(context),
                      child: const Text("Submit")),
                  SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Go back"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      title: const Text("Xác nhận"),
      content: Text(nameEditingController.text),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text("OK"))
      ],
    );
    showDialog(context: context, builder: (context) => dialog);
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Chao ban: ${nameEditingController.text}"),
      duration: Duration(seconds: 5),
    ));
  }
}
