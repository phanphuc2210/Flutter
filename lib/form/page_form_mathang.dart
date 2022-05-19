import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/form/form_model.dart';

class PageFormMatHang extends StatefulWidget {
  const PageFormMatHang({Key? key}) : super(key: key);

  @override
  State<PageFormMatHang> createState() => _PageFormMatHangState();
}

class _PageFormMatHangState extends State<PageFormMatHang> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtSoLuong = TextEditingController();
  MatHang mh = MatHang();
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Demo")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formState,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(children: [
            TextFormField(
              controller: txtName,
              onSaved: (newValue) => mh.name = newValue,
              validator: (value) => validateString(value),
              decoration: const InputDecoration(
                labelText: "Tên mặt hàng:",
              ),
            ),
            DropdownButtonFormField<String>(
              onChanged: (value) => dropdownValue = value,
              onSaved: (newValue) => mh.type = newValue,
              value: dropdownValue,
              validator: (value) => validateString(value),
              items: loaiMHs
                  .map((loaiMH) => DropdownMenuItem<String>(
                        child: Text(loaiMH),
                        value: loaiMH,
                      ))
                  .toList(),
              decoration: const InputDecoration(labelText: "Loại mặt hàng:"),
            ),
            TextFormField(
              controller: txtSoLuong,
              keyboardType: TextInputType.number,
              onSaved: (newValue) => mh.soluong = int.parse(newValue!),
              validator: (value) => validateSoLuong(value),
              decoration: const InputDecoration(
                labelText: "Số lượng:",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () => _save(context), child: const Text("Save")),
              ],
            )
          ]),
        ),
      ),
    );
  }

  _save(BuildContext context) {
    if (formState.currentState!.validate()) {
      formState.currentState!.save();
      _showDialog(context);
    }
  }

  validateString(String? value) {
    return value == null || value.isEmpty ? "Bạn chưa nhập dữ liệu" : null;
  }

  validateSoLuong(String? value) {
    if (value == null || value.isEmpty) {
      return "Bạn chưa nhập số lượng";
    } else {
      return int.parse(value) < 0 ? "Số lượng không được phép bé hơn 0" : null;
    }
  }

  void _showDialog(BuildContext context) {
    var dialog = AlertDialog(
      title: Text("Thông báo"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Bạn đã nhập mặt hàng:"),
          Text("Tên MH: ${mh.name}"),
          Text("Loại MH: ${mh.type}"),
          Text("Số lượng: ${mh.soluong}"),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: const Text("OK"))
      ],
    );

    showDialog(context: context, builder: (context) => dialog);
  }
}
