import 'package:flutter/material.dart';
import 'package:mobile_project/provider/home_provider.dart';
import 'package:provider/provider.dart';

class AddServiceScreen extends StatelessWidget {
  AddServiceScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height*0.7,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.grey[300],
                  child: Image.asset('assets/images/man.png'),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Service Title',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _desc,
                maxLines: 8,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Service Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all( Color(0xff3ce1d9))
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    provider.addService(_title.text , _desc.text);
                  }
                },
                child: const Text('Save Service'),
              ),
            ],
          ),
        ),
    );
  }
}
