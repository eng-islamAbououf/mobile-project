import 'package:flutter/material.dart';
import 'package:mobile_project/Controllers/sign_up_controller.dart';
import 'package:mobile_project/componants/sign_up_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final SignUpController _controller = SignUpController() ;

  // provider
  List<String> _selectedIndustries = [];
  String _companySize = 'Micro';
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
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Sign_Up_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.05,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            // Other AppBar properties, such as title or actions, can be added here
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Container(
              height: height*0.8,
              decoration: const BoxDecoration(
                color: Color(0x80ffffff),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25,),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text("Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SignUpFormField(
                                  txt: 'Company Name',
                                  controller: _controller.companyNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Company name is required';
                                    }
                                    return null;
                                  }
                                  ),
                              const SizedBox(height: 16.0),
                              SignUpFormField(
                                  txt: 'Contact Person Name',
                                  controller: _controller.contactPersonNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Contact person name is required';
                                    }
                                    return null;
                                  },
                              ),
                              const SizedBox(height: 16.0),
                              const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text('Company Industry',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Wrap(
                                children: _companyIndustryList
                                    .map((industry) => CheckboxListTile(
                                  title: Text(industry),
                                  value: _selectedIndustries.contains(industry),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true) {
                                        _selectedIndustries.add(industry);
                                      } else {
                                        _selectedIndustries.remove(industry);
                                      }
                                    });
                                  },
                                ))
                                    .toList(),
                              ),
                              SignUpFormField(
                                controller: _controller.contactPersonPhoneNumberController,
                                keyboardType: TextInputType.phone,
                                txt: 'Phone Number',
                                validator: (value) {
                                  final phoneRegex = RegExp(r'^\d{10}$');
                                  if (value == null || value.isEmpty) {
                                    return 'Phone number is required';
                                  } else if (!phoneRegex.hasMatch(value)) {
                                    return 'Phone number is not valid';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              SignUpFormField(
                                controller: _controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                txt: 'Email',
                                validator: (value) {
                                  final emailRegex =
                                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  } else if (!emailRegex.hasMatch(value)) {
                                    return 'Email is not valid';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              SignUpFormField(
                                controller: _controller.companyAddressController,
                                txt: 'Company Address',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Company address is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              const Text('Company Size',                                  style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                              const SizedBox(height: 10.0),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Color(0xb3ffffff),
                                ),
                                child: DropdownButtonFormField(
                                  value: _companySize,
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
                                    setState(() {
                                      _companySize = value.toString();
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                    hintText: 'Company Size',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              SignUpFormField(
                                txt: 'Password',
                                controller: _controller.passwordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  } else if (value.length < 8) {
                                    return 'Password must be at least 8 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              SignUpFormField(
                                txt: 'Confirm Password',
                                controller: _controller.confirmPasswordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Confirm password is required';
                                  } else if (value.length < 8) {
                                    return 'Confirm password must be at least 8 characters';
                                  } else if (value != _controller.passwordController.text) {
                                    return 'Confirm password must match password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              Container(
                                width: width*0.92,
                                height: height*0.06,
                                margin: EdgeInsets.only(
                                  left: width*0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xff47cec7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (_controller.formKey.currentState!.validate()) {
                                      _controller.formKey.currentState!.save();
                                      // Perform sign up operation here
                                      print('Signup successful');
                                    } else {
                                      print('Signup failed');
                                    }
                                  },
                                  child: const Text('Create Account',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  ),
                                ),
                              ),
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
      ]),
    ));
  }
}
