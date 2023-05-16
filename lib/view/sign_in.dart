import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/Validators/sign_up_validator.dart';
import 'package:mobile_project/componants/failure_dialog.dart';
import 'package:mobile_project/componants/sign_up_form_field.dart';
import 'package:mobile_project/view/edit_profile.dart';
import 'package:mobile_project/view/home_screen.dart';
import 'package:mobile_project/view/sign_up.dart';
import 'package:provider/provider.dart';

import '../Controllers/sign_in_controller.dart';
import '../provider/sign_in_provider.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  var _controller = SignInController() ;
  final _validator = AuthValidator() ;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var provider = Provider.of<SignInProvider>(context) ;
    _controller = provider.controller;
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Sign_in_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        child : _ui(provider,height , width , context),
        ),
      );
  }
  _ui(SignInProvider provider,height ,width , context){
    if(provider.loading)return const Center(child: CircularProgressIndicator(),);

    return SafeArea(
      child: Stack(
        children: [
          Center(
            child: Image.asset("assets/images/login icon.png",
            ),
          ) ,
          Column(
            children: [
              SizedBox(height: height*0.37,),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0x66ffffff),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0)
                    ), // add a border radius of 20
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _controller.formKey,
                        child: Column(
                          children: [
                            SizedBox(height: height*0.04,),
                            Text(
                              'Welcome back!'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: height*0.04,),

                            SignUpFormField(
                              txt: 'Email', controller: _controller.emailController,
                              validator: _validator.validateEmail,
                            ),
                            SizedBox(height: height*0.02,),
                            SignUpFormField(
                              obscureText: true,
                              txt: 'Password', controller: _controller.passwordController,
                              validator: _validator.validatePassword,
                            ),
                            SizedBox(height: height*0.02,),
                            Container(
                              width: width,
                              height: height*0.07,
                              decoration: BoxDecoration(
                                color: const Color(0xff47cec7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MaterialButton(
                                onPressed: () async {
                                  if (_controller.formKey.currentState!
                                      .validate()) {

                                    await provider.signIn();
                                    if(provider.companyModel!=null){
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)
                                      => const HomeScreen()
                                      ));
                                    }else {
                                      showDialog(context: context, builder: (_) => FailureDialog(errorMsg: provider.errorMsg)) ;
                                    }
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height*0.02,),
                            Container(
                              height: height*0.07,
                              width: width,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Don't have an account? ",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Register',
                                        style: const TextStyle(
                                            decoration: TextDecoration.underline,
                                            color: Color(0xff47cec7)
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context) =>
                                                    SignupScreen()
                                                )
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



