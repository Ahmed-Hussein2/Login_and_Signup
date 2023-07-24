import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:login_and_signup/SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String showButtonText = "show";
  bool _passwordVisible = true;
  bool? isLoggedIn;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Column(
              children: [
                Text(
                  "Sign In",
                  style: TextStyle(fontSize: 32, color: Color(0xFF0D0C38)),
                ),
                SizedBox(height: 48),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email Address:",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF0D0C38)),
                          ),
                          SizedBox(height: 14),
                          Container(
                            // height: 55,
                            width: 321,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color(0xFFF0F0F0),
                                hintText: "Enter your email address",
                              ),
                              style: TextStyle(fontSize: 16),
                              keyboardType: TextInputType.emailAddress,
                              validator: (email) {
                                if (email != null &&
                                    !EmailValidator.validate(email)) {
                                  return "Enter a valid email"; // Form is Not Valid
                                } else {
                                  return null; // Form is Valid
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 56),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Password:",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF0D0C38)),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                  _passwordVisible
                                      ? showButtonText = "Hide"
                                      : showButtonText = "show";
                                });
                              },
                              child: Text(
                                showButtonText,
                                style: TextStyle(
                                  color: Color(0xFF433FFF),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        // height: 55,
                        width: 321,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFF0F0F0),
                            hintText: "Enter your Password",
                          ),
                          obscureText: !_passwordVisible,
                          obscuringCharacter: "●",
                          style: TextStyle(fontSize: 16),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value != null && value.length < 6) {
                              return "Enter min 6 characters"; // Form is Not Valid
                            } else {
                              return null; // Form is Valid
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36),
                MaterialButton(
                  height: 52,
                  minWidth: 324,
                  onPressed: () {
                    final isValidForm = formKey.currentState!.validate();
                    if (isValidForm) {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          color: Color(0xFF0c7040),
                          title: "Well Done!",
                          message: "Login Successful",
                          contentType: ContentType.success,
                        ),
                      );
                      setState(() {
                        isLoggedIn = true;
                      });
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    } else {
                      setState(() {
                        isLoggedIn = false;
                      });
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: "On Snap!",
                          message: "Oops! Email or Password are wrong!",
                          contentType: ContentType.failure,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                  },
                  child: Text(
                    "Sign In Now",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  textColor: Colors.white,
                  color: Color(0xFF6A2EE8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.59)),
                ),
                SizedBox(height: 36),
                Text(
                  "Do not have any account yet?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF433FFF),
                  ),
                ),
                SizedBox(height: 4),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                  child: Text(
                    "Create Now",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF433FFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
