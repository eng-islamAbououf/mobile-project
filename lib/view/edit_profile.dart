import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_project/componants/sign_up_form_field.dart';
import 'package:mobile_project/view/home_screen.dart';
import 'package:provider/provider.dart';

import '../Validators/sign_up_validator.dart';
import '../api.dart';
import '../model/company_model.dart';
import '../provider/edit_profile_provider.dart';

class EditProfileScreen extends StatelessWidget {
  void _pickImage(var source, var provider , var context) async {
    final picker = ImagePicker();
    try{
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        provider.setImage(File(pickedFile.path));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load image'),
          ),
        );
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load image'),
        ),
      );
    }

  }


  final List<String> _companyIndustryList = [
    'Industry1',
    'Industry2',
    'Industry3',
    'Industry4',
  ];
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var provider = Provider.of<EditProfileProvider>(context) ;
    provider.init();
    final _validator = AuthValidator();

    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Sign_Up_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.035,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    // Other AppBar properties, such as title or actions, can be added here
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: (){},
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 75,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: provider.companyModel.image != null ? FileImage(provider.companyModel.image!) : null,
                                child: provider.companyModel.image == null
                                    ? Image.asset('assets/images/man.png')
                                    : null,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (curContext) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            padding: const EdgeInsets.all(20.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.0),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Choose an option',
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 20.0),
                                                ListTile(
                                                  leading: const Icon(Icons.camera_alt),
                                                  title: const Text('Take a photo'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    _pickImage(ImageSource.camera, provider, context);
                                                  },
                                                ),
                                                const SizedBox(height: 10.0),
                                                const Divider(),
                                                const SizedBox(height: 10.0),
                                                ListTile(
                                                  leading: const Icon(Icons.image),
                                                  title: const Text('Choose from gallery'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    _pickImage(ImageSource.gallery, provider , context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );

                                  },
                                  child: const CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Color(0xff3ce1d9),
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: provider.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 16.0),
                                  SignUpFormField(
                                    controller: provider.nameController,
                                    validator: _validator.validateCompanyName,
                                    txt: 'Company Name',
                                  ),
                                  const SizedBox(height: 16.0),
                                  SignUpFormField(
                                    controller: provider.contactNameController,
                                    txt: 'Contact Name',
                                    validator: _validator.validateContactPersonName,
                                  ),
                                  const SizedBox(height: 16.0),
                                  Wrap(
                                    children: _companyIndustryList
                                        .map((industry) => CheckboxListTile(
                                      activeColor: const Color(0xff47CEC7),
                                      title: Text(industry),
                                      value: provider.companyModel.industry!.contains(industry),
                                      onChanged: (value) {
                                        provider.setIndustry(value, industry) ;
                                      },
                                    ))
                                        .toList(),
                                  ),
                                  const SizedBox(height: 16.0),
                                  SignUpFormField(
                                    controller: provider.phoneNumberController,
                                    txt: 'Phone Number',
                                    keyboardType: TextInputType.phone,
                                    validator: _validator.validateContactPersonPhoneNumber,
                                  ),
                                  const SizedBox(height: 16.0),
                                  SignUpFormField(
                                    controller: provider.emailController,
                                    txt: 'Email',
                                    keyboardType: TextInputType.emailAddress,
                                    validator: _validator.validateEmail,
                                  ),
                                  const SizedBox(height: 16.0),
                                  SignUpFormField(
                                    controller: provider.addressController,
                                    txt: 'Address',
                                    validator: _validator.validateAddress,
                                  ),
                                  const SizedBox(height: 16.0),
                                  Container(
                                    height: height*0.07,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15.0),
                                      color: const Color(0xb3ffffff),
                                    ),
                                    child: DropdownButtonFormField(
                                      value: provider.companyModel.size,
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'Micro',
                                          child: Text('Micro'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Small',
                                          child: Text('Small'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Mini',
                                          child: Text('Mini'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Large',
                                          child: Text('Large'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        provider.setSize(value);
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Company Size',
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        hintText: 'Company Size',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  SignUpFormField(
                                    obscureText: true,
                                    txt: 'Password',
                                    validator: _validator.validatePassword,
                                    controller: provider.password,
                                  ),
                                  const SizedBox(height: 16.0),
                                  SizedBox(
                                    height: 55,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (provider.formKey.currentState?.validate() ?? false) {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return const Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            },
                                          );
                                          await provider.saveChanges();
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff47CEC7)),
                                      ),
                                      child: const Text('Save Changes' ,

                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}