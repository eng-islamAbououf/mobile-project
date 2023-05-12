import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_project/componants/sign_up_form_field.dart';
import 'package:provider/provider.dart';

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
    'Industry 1',
    'Industry 2',
    'Industry 3',
    'Industry 4',
  ];
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var provider = Provider.of<EditProfileProvider>(context) ;
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController(text: provider.companyModel.companyName);
    final _contactNameController = TextEditingController(text: provider.companyModel.contactPersonName);
    final _industryController = TextEditingController(text: provider.companyModel.industry![0]);
    final _phoneNumberController = TextEditingController(text: provider.companyModel.phoneNumber);
    final _emailController = TextEditingController(text: provider.companyModel.email);
    final _password = TextEditingController(text: provider.companyModel.password);
    final _addressController = TextEditingController(text: provider.companyModel.address);
    return SafeArea(
      child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Sign_Up_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.05,
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
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                          ? Icon(Icons.account_box_outlined, size: 50, color: Colors.grey[600])
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
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.add_a_photo,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            SignUpFormField(
                              controller: _nameController,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter your name';
                                }
                                return null;
                              }, txt: 'Company Name',
                            ),
                            const SizedBox(height: 16.0),
                            SignUpFormField(
                              controller: _contactNameController,
                              txt: 'Contact Name',
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter a contact name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            Wrap(
                              children: _companyIndustryList
                                  .map((industry) => CheckboxListTile(
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
                              controller: _phoneNumberController,
                              txt: 'Phone Number',
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter a phone number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            SignUpFormField(
                              controller: _emailController,
                              txt: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if
                                (value?.isEmpty ?? true) {
                                  return 'Please enter an email address';
                                }
                                if (!value!.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            SignUpFormField(
                              controller: _addressController,
                              txt: 'Address',
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter an address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            DropdownButtonFormField<String>(
                              value: provider.companyModel.size,
                              items: ['Micro', 'Small', 'Mini', 'Large']
                                  .map((size) =>
                                  DropdownMenuItem(value: size, child: Text(size)))
                                  .toList(),
                              onChanged: (value) => provider.setSize(value),
                              decoration: const InputDecoration(labelText: 'Size'),
                            ),
                            const SizedBox(height: 16.0),
                            SignUpFormField(
                              obscureText: true,
                              txt: 'Password',
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter a password';
                                }
                                if (value!.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                              controller: _password,
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              height: 55,
                              child: ElevatedButton(
                                onPressed: () {
                                  Api().createCompany(provider.companyModel);
                                  if (_formKey.currentState?.validate() ?? false) {
                                    // Save changes to user model
                                    // ...

                                    //CompanyModel('islam',
                                    //                                       'islam mohamed', '0101',
                                    //                                       'email',
                                    //                                       'elmmm',
                                    //                                       'Micro', 'password', ['industry'],provider.companyModel. )
                                  }
                                },
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
      ),
    );
  }
}