import 'package:flutter/material.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final _formKey=GlobalKey();
  final TextEditingController _descriptionController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Аризалар'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
                child: Column(
              children: [
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                      labelText: 'Изоҳ',
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
                          vertical: 50.0, horizontal: 10.0)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Изоҳ киритинг';
                    }
                    return null;
                  },
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
