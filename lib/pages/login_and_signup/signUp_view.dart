import 'package:flutter/material.dart';
import 'package:flutter_app/services/user_api_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../controller/simple_ui_controller.dart';
import '../../pages/login_and_signup/login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final userApiService = UserApiService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _selectedUserType =
      TextEditingController(text: '');
  final bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _signUp() async {
    
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _selectedUserType.dispose(); // Properly dispose the controller
    super.dispose();
  }

  final SimpleUIController simpleUIController = Get.put(SimpleUIController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 700) {
                return _buildLargeScreen(size, simpleUIController, theme);
              } else {
                return _buildSmallScreen(size, simpleUIController, theme);
              }
            },
          )),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            height: size.height,
            color: Colors.grey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.03),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'UNC',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 48,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' Career',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 48,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'Pathlink',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w700,
                              fontSize: 48,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ),
        SizedBox(width: size.width * 0.03),
        Expanded(
          flex: 5,
          child: _buildMainBody(size, simpleUIController, theme),
        ),
        SizedBox(width: size.width * 0.03),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildMainBody(size, simpleUIController, theme)],
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: size.width > 700
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          size.width > 700
              ? Container()
              : Container(
                  width: size.width,
                  color: Colors.grey,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.06),
                      Align(
                          alignment: Alignment.center,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'UNC',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 32,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Career',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 32,
                                    color: Colors.white,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Pathlink',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 32,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: size.height * 0.06),
                    ],
                  ),
                ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Sign Up',
              style: kLoginTitleStyle(size),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Create Account',
              style: kLoginSubtitleStyle(size),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// username
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Username',
                    ),

                    controller: _usernameController,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      // return null;
                      value == null || value.isEmpty ? 'Enter username' : null;
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// password
                  Obx(
                    () => TextFormField(
                      style: kTextFormFieldStyle(),
                      controller: _passwordController,
                      obscureText: simpleUIController.isObscure.value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_open),
                        suffixIcon: IconButton(
                          icon: Icon(
                            simpleUIController.isObscure.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            simpleUIController.isObscureActive();
                          },
                        ),
                        hintText: 'Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        value == null || value.isEmpty
                            ? 'Enter password'
                            : null;
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  DropdownButtonFormField<String>(
                    hint: Text('Sign Up As'),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.switch_account),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    items: [
                      'Student',
                      'Graduate',
                      'College Dean',
                      'Career Coach',
                      'Employer Partner',
                      'Career Center Director',
                    ]
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUserType.text = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select user type';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// SignUp Button
                  signUpButton(theme),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  /// Navigate To Login Screen
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ctx) => const LoginView()),
                      ).then((_) {
                        // Clear the form and reset after navigation
                        _usernameController.clear();
                        _passwordController.clear();
                        _selectedUserType.clear();
                        _formKey.currentState?.reset();

                        // Reset UI state
                        simpleUIController.isObscure.value = true;
                      });
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account?',
                        style: kHaveAnAccountStyle(size),
                        children: [
                          TextSpan(
                            text: " Login",
                            style: kLoginOrSignUpTextStyle(size),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SignUp Button
  Widget signUpButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      // height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _signUp,
        child: _isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
            )
            : const Text('Sign Up'),
      ),
    );
  }
}
