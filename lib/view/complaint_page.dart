import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_driver/view_model/complaint_view_model.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final _formKey = GlobalKey();
  final TextEditingController _descriptionController = TextEditingController();
  String? selectCategoryAriza;
  int? driverId;
  List list = ['Йўл чиқимлари бўйича ариза', 'Қўшимча ариза'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Аризалар'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.indigo, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.indigo, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.indigo, width: 2),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      ),
                      value: list.contains(selectCategoryAriza)
                          ? selectCategoryAriza
                          : null,
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      icon: Icon(Icons.arrow_drop_down_circle_outlined,
                          color: Colors.indigo),
                      items: list.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item, style: TextStyle(fontSize: 16)),
                        );
                      }).toList(),
                      onChanged: (newItem) {
                        setState(() {
                          selectCategoryAriza = newItem!;
                          driverId = list.indexOf(newItem) + 1;
                        });
                      },
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
                                borderSide:
                                    BorderSide(color: Colors.indigo, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.indigo, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.indigo, width: 2),
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
                onPressed: () {
                  if (_descriptionController.text.isNotEmpty &&
                      selectCategoryAriza != null) {
                    context.read<ComplaintViewModel>().addExpenses(
                        _descriptionController.text,
                        selectCategoryAriza!,
                        driverId ?? 1);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Маълумотлар тўлиқ киритинг')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
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
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
