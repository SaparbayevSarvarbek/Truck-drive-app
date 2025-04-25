import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_driver/theme/my_dialog.dart';
import 'package:truck_driver/view_model/complaint_view_model.dart';

import '../models/user_database.dart';
import '../models/user_model.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final _formKey = GlobalKey();
  final TextEditingController _descriptionController = TextEditingController();
  String? selectCategoryAriza;
  int? selectCategoryId;
  int? driverId;
  List list = ['Йўл чиқимлари бўйича ариза', 'Қўшимча ариза'];

  @override
  void initState() {
    super.initState();
    _loadUserList();
  }

  Future<void> _loadUserList() async {
    final userMap = await UserDatabase.getUser();

    if (userMap != null) {
      final user = UserModel.fromJson(userMap);
      setState(() {
        driverId = user.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final uploadViewModel = Provider.of<ComplaintViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Аризалар'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Ариза тури",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
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
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.teal
                                    : Colors.blue,
                            width: 2,
                          ),
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
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      ),
                      value: list.contains(selectCategoryAriza)
                          ? selectCategoryAriza
                          : null,
                      isExpanded: true,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white // Dark modeda oq
                            : Colors.black, // Light modeda qora
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.teal // Dark modeda oq
                            : Colors.blue, // Light modeda qora
                      ),
                      items: list.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                      onChanged: (newItem) {
                        setState(() {
                          selectCategoryAriza = newItem!;
                          selectCategoryId = list.indexOf(newItem);
                        });
                      },
                      dropdownColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.black // Dark modeda qora
                              : Colors.white, // Light modeda oq
                    ),
                    SizedBox(height: 16),
                    Form(
                      key: _formKey,
                      child: Column(
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
                                  vertical: 16.0, horizontal: 12.0),
                            ),
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_descriptionController.text.isNotEmpty &&
                      selectCategoryAriza != null) {
                    uploadViewModel.changeLoadingState();

                    try {
                      String result = "";

                      if (selectCategoryId == 0) {
                        result = await context
                            .read<ComplaintViewModel>()
                            .addComplaint("asosiy", _descriptionController.text,
                                driverId ?? 1);
                      } else if (selectCategoryId == 1) {
                        result = await context
                            .read<ComplaintViewModel>()
                            .addComplaint("qoshimcha",
                                _descriptionController.text, driverId ?? 1);
                      }

                      uploadViewModel.changeLoadingState();

                      if (result == "200" || result == "201") {
                        setState(() {
                          selectCategoryAriza = null;
                          selectCategoryId = null;
                          _descriptionController.clear();
                        });

                        MyDialog.info('Ариза юборилди!');
                        Navigator.pop(context);
                      } else {
                        MyDialog.error('Ариза юборишда хатолик юз берди: $result');
                      }
                    } catch (e) {
                      uploadViewModel.changeLoadingState();
                      MyDialog.error("Хатолик: ${e.toString()}");
                    }
                  } else {
                    MyDialog.error('Маълумотлар тўлиқ киритинг');
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Юбориш",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
