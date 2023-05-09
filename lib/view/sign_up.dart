import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _companyNameController,
                  decoration: const InputDecoration(
                    labelText: 'Company Name',
                    hintText: 'Enter your company name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Company name is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _contactPersonNameController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Person Name',
                    hintText: 'Enter your name',
                  ),
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
                      .map((industry) =>
                      CheckboxListTile(
                        title: Text(industry),
                        value: _companyIndustry == industry,
                        onChanged: (value) {
                          setState(() {
                            _companyIndustry = value == true ? industry : '';
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
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm password is required';
                    } else if (value.length < 8) {
                      return 'Confirm password must be at least 8 characters';
                    } else if (value != _passwordController.text) {
                      return 'Confirm password must match password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Perform sign up operation here
                      print('Signup successful');
                    } else {
                      print('Signup failed');
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}