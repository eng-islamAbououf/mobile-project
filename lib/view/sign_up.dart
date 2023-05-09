import 'package:flutter/material.dart';
import 'package:mobile_project/componants/sign_up_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyNameController = TextEditingController();
  final _contactPersonNameController = TextEditingController();
  final _contactPersonPhoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyAddressController = TextEditingController();
  final _companyLocationController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _companyIndustry = 'Industry 1';
  String _companySize = 'Micro';

  List<String> _companyIndustryList = [
    'Industry 1',
    'Industry 2',
    'Industry 3',
    'Industry 4',
  ];

  @override
  void dispose() {
    _companyNameController.dispose();
    _contactPersonNameController.dispose();
    _contactPersonPhoneNumberController.dispose();
    _emailController.dispose();
    _companyAddressController.dispose();
    _companyLocationController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
              height: height * 0.05,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0x80ffffff),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SignUpFormField(
                              txt: 'Company Name',
                              controller: _companyNameController,
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
                              controller: _contactPersonNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Contact person name is required';
                                }
                                return null;
                              },
                          ),
                          const SizedBox(height: 16.0),
                          const Text('Company Industry'),
                          Wrap(
                            children: _companyIndustryList
                                .map((industry) => CheckboxListTile(
                                      title: Text(industry),
                                      value: _companyIndustry == industry,
                                      onChanged: (value) {
                                        setState(() {
                                          _companyIndustry =
                                              value == true ? industry : '';
                                        });
                                      },
                                    ))
                                .toList(),
                          ),
                          TextFormField(
                            controller: _contactPersonPhoneNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              hintText: 'Enter your phone number',
                            ),
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
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your email address',
                            ),
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
                          TextFormField(
                            controller: _companyAddressController,
                            decoration: const InputDecoration(
                              labelText: 'Company Address',
                              hintText: 'Enter your company address',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Company address is required';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _companyLocationController,
                            decoration: const InputDecoration(
                              labelText: 'Company Location',
                              hintText: 'Enter your company location',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Company location is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          const Text('Company Size'),
                          // DropdownButtonFormField(
                          //   value: _companySize,
                          //   items: const [
                          //     DropdownMenuItem(
                          //       value: 'Micro',
                          //       child: Text('Micro'),
                          //     ),
                          //     DropdownMenuItem(
                          //       value: 'Small',
                          //       child: Text('Small'),
                          //     ),
                          //     DropdownMenuItem(
                          //       value: 'Mini',
                          //       child: Text('Mini'),
                          //     ),
                          //     DropdownMenuItem(
                          //       value: 'Large',
                          //       child: Text('Large'),
                          //     ),
                          //   ],
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _companySize = value.toString();
                          //     });
                          //   },
                          // ),
                          // TextFormField(
                          //   controller: _passwordController,
                          //   obscureText: true,
                          //   decoration: const InputDecoration(
                          //     labelText: 'Password',
                          //     hintText: 'Enter your password',
                          //   ),
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Password is required';
                          //     } else if (value.length < 8) {
                          //       return 'Password must be at least 8 characters';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // TextFormField(
                          //   controller: _confirmPasswordController,
                          //   obscureText: true,
                          //   decoration: const InputDecoration(
                          //     labelText: 'Confirm Password',
                          //     hintText: 'Re-enter your password',
                          //   ),
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Confirm password is required';
                          //     } else if (value.length < 8) {
                          //       return 'Confirm password must be at least 8 characters';
                          //     } else if (value != _passwordController.text) {
                          //       return 'Confirm password must match password';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // const SizedBox(height: 16.0),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     if (_formKey.currentState!.validate()) {
                          //       _formKey.currentState!.save();
                          //       // Perform sign up operation here
                          //       print('Signup successful');
                          //     } else {
                          //       print('Signup failed');
                          //     }
                          //   },
                          //   child: const Text('Sign Up'),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}


class _CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final radius = 25.0;
    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(0, size.height, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - radius);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}