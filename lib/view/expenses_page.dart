import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:truck_driver/models/expenses_data_model.dart';
import 'package:truck_driver/view_model/expenses_view_model.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _narxController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? foydalanuvchi;
  int? foydalanuvchiId = 1;
  String? kategoriyaXarajat;
  int? kategoriyaXarajatId;
  List<String> list = ["admin"];
  List<String> list1 = [
    "Йўл харажатлари",
    "Пост харажатлари",
    'Запрофка харажатлари',
    'Мой харажатлари'
  ];

  @override
  Widget build(BuildContext context) {
    final uploadViewModel = Provider.of<ExpensesViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Чиқимлар'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            children: [
              GestureDetector(
                  onTap: _pickImage,
                  child: _image == null
                      ? Card(
                          elevation: 5,
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    size: 30,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.teal
                                        : Colors.blue,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Расмни танланг"),
                                ]),
                          ),
                        )
                      : Column(
                          children: [
                            Card(
                              elevation: 5,
                              child: Container(
                                width: double.infinity,
                                height: 180,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1.5),
                                ),
                                child: Image.file(
                                  File(_image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Расм ўзгартириш учун ена бир марта босинг',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Харажатлар категорияси",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.teal
                            : Colors.blue,
                        width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.teal
                          : Colors.blue, // Dark va Light tema uchun ranglar
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.teal
                          : Colors.blue, // Focus qilinganda rang
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                ),
                value: list1.contains(kategoriyaXarajat)
                    ? kategoriyaXarajat
                    : null,
                isExpanded: true,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black, // Matn rangini tekshirish
                ),
                icon: Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.teal
                      : Colors.blue, // Icon rangini o'zgartirish
                ),
                items: list1.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black, // Item matni rangini o'zgartirish
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newItem) {
                  setState(() {
                    kategoriyaXarajat = newItem!;
                    kategoriyaXarajatId = list1.indexOf(newItem) + 1;
                  });
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    spacing: 18.0,
                    children: [
                      TextFormField(
                        controller: _narxController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                            labelText: 'Нарх',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.teal
                                      : Colors.blue,
                                  width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.teal
                                      : Colors.blue,
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.teal
                                      : Colors.blue,
                                  width: 2),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Нархни киритинг';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                            labelText: 'Изоҳ',
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.teal
                                      : Colors.blue,
                                  width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.teal
                                      : Colors.blue,
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.teal
                                      : Colors.blue,
                                  width: 2),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 10.0)),
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: 10,
                        maxLength: 200,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Изоҳ киритинг';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                 width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: uploadViewModel.isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              if (foydalanuvchi != null &&
                                  kategoriyaXarajat != null &&
                                  _image != null) {
                                ExpensesDataModel data = ExpensesDataModel(
                                    user: foydalanuvchiId ?? 1,
                                    expense: kategoriyaXarajatId ?? 1,
                                    price: _narxController.text,
                                    description: _descriptionController.text);

                              //  final data =context.read<ExpensesViewModel>().addExpenses(data, _image!);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Маълумотлар тўлиқ киритинг")),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("Маълумотлар тўлиқ киритинг")),
                              );
                            }
                          },
                    child: uploadViewModel.isLoading
                        ? CircularProgressIndicator()
                        : Text('Сақлаш')),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print("Hech qanday rasm tanlanmadi.");
    }
  }
}
