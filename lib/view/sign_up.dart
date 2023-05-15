import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_project/Controllers/sign_up_controller.dart';
import 'package:mobile_project/Validators/sign_up_validator.dart';
import 'package:mobile_project/componants/custom_app_bar.dart';
import 'package:mobile_project/componants/failure_dialog.dart';
import 'package:mobile_project/componants/sign_up_form_field.dart';
import 'package:mobile_project/provider/sign_up_provider.dart';
import 'package:mobile_project/view/edit_profile.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  SignUpController _controller = SignUpController();
  final _validator = AuthValidator();

  // provider
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

    var provider = Provider.of<SignUpProvider>(context);
    _controller = provider.controller;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Sign_Up_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        child : _ui(provider , height ,width, context),
        ));
  }

  _ui(SignUpProvider provider, double height,double width, BuildContext context){
    if(provider.loading) {
      return const Center(child: CircularProgressIndicator(),);
    }
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(height: height, title: ''),
          Column(
            children: [
              Container(
                height: height * 0.75,
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
                    const SizedBox(
                      height: 25,
                    ),
                    const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Scrollbar(
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
                                      controller:
                                      _controller.companyNameController,
                                      validator:
                                      _validator.validateCompanyName),
                                  const SizedBox(height: 16.0),
                                  SignUpFormField(
                                      txt: 'Contact Person Name',
                                      controller: _controller
                                          .contactPersonNameController,
                                      validator: _validator
                                          .validateContactPersonName),
                                  const SizedBox(height: 16.0),
                                  SignUpFormField(
                                      controller: _controller
                                          .contactPersonPhoneNumberController,
                                      keyboardType: TextInputType.phone,
                                      txt: 'Phone Number',
                                      validator: _validator
                                          .validateContactPersonPhoneNumber),
                                  const SizedBox(height: 16.0),

                                  SignUpFormField(
                                      controller: _controller.emailController,
                                      keyboardType:
                                      TextInputType.emailAddress,
                                      txt: 'Email',
                                      validator: _validator.validateEmail),
                                  const SizedBox(height: 16.0),
                                  SignUpFormField(
                                      controller: _controller
                                          .companyAddressController,
                                      txt: 'Company Address',
                                      validator: _validator.validateAddress),
                                  const SizedBox(height: 16.0),
                                  const Text(
                                    'Company Location',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  SizedBox(
                                    width: width * 0.9,
                                    height: height * 0.5,
                                    child: GoogleMap(
                                      initialCameraPosition:
                                      const CameraPosition(
                                        target: LatLng(37.77483, -122.41942),
                                        zoom: 16,
                                      ),
                                      markers: provider.markers,
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        if(!_controller.mapController.isCompleted) {
                                          _controller.mapController
                                            .complete(controller);
                                        }
                                      },
                                      onTap: (la) {
                                        provider.changeMarker(la);
                                      },
                                      onCameraMove: (po) {},
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'Company Industry',
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
                                      value: provider
                                          .selectedIndustries
                                          .contains(industry),
                                      onChanged: (value) {
                                        provider.setIndustry(
                                            value, industry);
                                      },
                                    ))
                                        .toList(),
                                  ),
                                  const Text(
                                    'Company Size',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15.0),
                                      color: const Color(0xb3ffffff),
                                    ),
                                    child: DropdownButtonFormField(
                                      value: provider.companySize,
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
                                        provider.setCompanySize(value);
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
                                      txt: 'Password',
                                      controller:
                                      _controller.passwordController,
                                      obscureText: true,
                                      validator: _validator.validatePassword),
                                  const SizedBox(height: 16.0),
                                  SignUpFormField(
                                      txt: 'Confirm Password',
                                      controller: _controller
                                          .confirmPasswordController,
                                      obscureText: true,
                                      validator: _controller
                                          .validateConfirmPassword),
                                  const SizedBox(height: 16.0),
                                  Container(
                                    width: width * 0.92,
                                    height: height * 0.06,
                                    margin: EdgeInsets.only(
                                      left: width * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff47cec7),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: MaterialButton(
                                      onPressed: () async {
                                        if (_controller.formKey.currentState!
                                            .validate()) {
                                          await provider.signUp();
                                          if(provider.token!=null){
                                            Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(builder: (context) =>
                                                  EditProfileScreen(model: provider.companyModel!,)
                                              )
                                            );
                                          }else {
                                            showDialog(context: context, builder: (_) =>
                                            FailureDialog(errorMsg: provider.errorMsg)
                                            );
                                          }
                                        } else {
                                        }
                                      },
                                      child: const Text(
                                        'Create Account',
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
