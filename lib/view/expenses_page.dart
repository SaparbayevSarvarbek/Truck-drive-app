import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:truck_driver/models/currency_model.dart';
import 'package:truck_driver/models/expense_category_model.dart';
import 'package:truck_driver/models/expenses_data_model.dart';
import 'package:truck_driver/models/user_database.dart';
import 'package:truck_driver/models/user_model.dart';
import 'package:truck_driver/services/api_services.dart';
import 'package:truck_driver/theme/my_dialog.dart';
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
  final TextEditingController _valyutaController = TextEditingController();
  List<CurrencyModel> valyutaList = [];
  CurrencyModel? selectedValyuta;
  List<ExpenseCategoryModel> chiqimlarKategoryList = [];
  ExpenseCategoryModel? selectedExpenseCategory;
  String? foydalanuvchi;
  int? foydalanuvchiId;
  List<String> list1 = [
    "Йўл харажатлари",
    "Пост харажатлари",
    'Запрофка харажатлари',
    'Мой харажатлари'
  ];

  @override
  void initState() {
    super.initState();
    _loadUserList();
    _loadCurrency();
    _loadCategory();
  }

  Future<void> _loadUserList() async {
    final userMap = await UserDatabase.getUser();
    if (userMap != null) {
      final user = UserModel.fromJson(userMap);
      setState(() {
        foydalanuvchiId = user.id;
      });
    }
  }

  Future<void> _loadCurrency() async {
    final data = await ApiService.fetchCurrencies();
    setState(() {
      valyutaList = data;
    });
  }

  Future<void> _loadCategory() async {
    final data = await ApiService.fetchExpenseTypes();
    setState(() {
      chiqimlarKategoryList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('foydalanuvchi id $foydalanuvchiId');
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
                  onTap: () => showImageSourcePicker(context),
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
              DropdownButtonFormField<ExpenseCategoryModel>(
                decoration: InputDecoration(
                  labelText: "Харажатлар категорияси",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.teal
                          : Colors.blue,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.teal
                          : Colors.blue,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.teal
                          : Colors.blue,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                ),
                value: selectedExpenseCategory,
                isExpanded: true,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                icon: Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.teal
                      : Colors.blue,
                ),
                items: chiqimlarKategoryList.map((expense) {
                  return DropdownMenuItem<ExpenseCategoryModel>(
                    value: expense,
                    child: Text(
                      expense.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (ExpenseCategoryModel? newValue) {
                  setState(() {
                    selectedExpenseCategory = newValue!;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
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
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<CurrencyModel>(
                    value: selectedValyuta,
                    isExpanded: true,
                    items: valyutaList.map((currency) {
                      return DropdownMenuItem<CurrencyModel>(
                        value: currency,
                        child: Text(
                          currency.currency,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Валюта',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.dark
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
                              : Colors.blue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 2,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.teal
                              : Colors.blue,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.teal
                          : Colors.blue,
                    ),
                    onChanged: (CurrencyModel? value) {
                      setState(() {
                        selectedValyuta = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Валютани танланг';
                      }
                      return null;
                    },
                  ),
                ),
              ]),
              SizedBox(
                height: 16.0,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    spacing: 18.0,
                    children: [
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
                      : () async {
                          print('$selectedExpenseCategory $_image');
                          if (_formKey.currentState!.validate()) {
                            if (selectedExpenseCategory != null && _image != null) {
                              ExpensesDataModel data = ExpensesDataModel(
                                user: foydalanuvchiId ?? 1,
                                expense: selectedExpenseCategory?.id ?? 1,
                                price: _narxController.text,
                                description: _descriptionController.text,
                                currency: selectedValyuta!.id,
                              );

                              uploadViewModel.changeLoadingState();

                              String result = await uploadViewModel.addExpenses(
                                  data, _image!);

                              uploadViewModel
                                  .changeLoadingState(); // loading = false

                              if (result == "200" || result == "201") {
                                _narxController.clear();
                                _descriptionController.clear();
                                setState(() {
                                  _image = null;
                                  selectedExpenseCategory = null;
                                  selectedExpenseCategory = null;
                                });
                                MyDialog.info('Чиқим муваффақиятли юборилди!');
                                Navigator.pop(context);
                              } else {
                                MyDialog.error(result);
                              }
                            } else {
                              MyDialog.error('Маълумотларни тўлиқ киритинг');
                            }
                          } else {
                            MyDialog.error('Маълумотларни тўлиқ киритинг');
                          }
                        },
                  child: uploadViewModel.isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Сақлаш'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showImageSourcePicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Галереядан танлаш'),
              onTap: () async {
                Navigator.of(context).pop();
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  _setImage(File(pickedFile.path));
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Камерадан олиш'),
              onTap: () async {
                Navigator.of(context).pop();
                final pickedFile =
                    await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  _setImage(File(pickedFile.path));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _setImage(File pickedFile) {
    setState(() {
      _image = pickedFile;
    });
  }
}
