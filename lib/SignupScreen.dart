import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String showButton1 = "show";
  String showButton2 = "show";
  bool _passwordVisible1 = true;
  bool _passwordVisible2 = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool? IsLoggedIn;

  @override
  void initState() {
    _passwordVisible1 = false;
    _passwordVisible2 = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Column(
              children: [
                Text(
                  "Create an Account",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D0C38)),
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
                                fontSize: 17, color: Color(0xFF0D0C38)),
                          ),
                          SizedBox(height: 24),
                          Container(
                            // height: 55,
                            width: 321,
                            child: TextFormField(
                              controller: email,
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
                      SizedBox(height: 22),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 56),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Password:",
                              style: TextStyle(
                                  fontSize: 17, color: Color(0xFF0D0C38)),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible1 = !_passwordVisible1;
                                  _passwordVisible1
                                      ? showButton1 = "Hide"
                                      : showButton1 = "show";
                                });
                              },
                              child: Text(
                                showButton1,
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
                      SizedBox(height: 14),
                      Container(
                        // height: 55,
                        width: 321,
                        child: TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFF0F0F0),
                            hintText: "Enter your Password",
                          ),
                          obscureText: !_passwordVisible1,
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
                      SizedBox(height: 22),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 56),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Confirm Password:",
                              style: TextStyle(
                                  fontSize: 17, color: Color(0xFF0D0C38)),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisible2 = !_passwordVisible2;
                                  _passwordVisible2
                                      ? showButton2 = "Hide"
                                      : showButton2 = "show";
                                });
                              },
                              child: Text(
                                showButton2,
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
                      SizedBox(height: 14),
                      Container(
                        // height: 55,
                        width: 321,
                        child: TextFormField(
                          controller: confirmPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFF0F0F0),
                            hintText: "Confirm your Password",
                          ),
                          obscureText: !_passwordVisible2,
                          obscuringCharacter: "●",
                          style: TextStyle(fontSize: 16),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value != password.text) {
                              return "Not Match";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 34),
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
                          message: "Signup Successful",
                          contentType: ContentType.success,
                        ),
                      );
                      setState(() {
                        IsLoggedIn = true;
                      });
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    } else {
                      setState(() {
                        IsLoggedIn = false;
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
                    "Sign Up Now",
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
                SizedBox(height: 34),
                Text(
                  "Already have any account yet?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF433FFF),
                  ),
                ),
                SizedBox(height: 4),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Sign In Now",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF433FFF),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
