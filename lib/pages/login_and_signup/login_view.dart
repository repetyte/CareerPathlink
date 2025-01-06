import 'package:flutter/material.dart';
import 'package:flutter_app/services/user_api_service.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../controller/simple_ui_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final userApiService = UserApiService();

  final TextEditingController _usernameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _selectedUserType =
      TextEditingController(text: '');
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final username = _usernameController.text;
      final password = _passwordController.text;
      final userType = _selectedUserType.text;

      try {
        if (userType == 'Graduate') {
          final graduate =
              await userApiService.fetchGraduateAccount(username, password);
          if (graduate != null) {
            // Navigate to Graduate Dashboard with graduate account details
            Navigator.pushReplacementNamed(
              context,
              '/rr_job_dashboard_user',
              arguments: graduate,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Graduate credentials.')),
            );
          }
        } else if (userType == 'Employer Partner') {
          final partner = await userApiService.fetchIndustryPartnerAccount(
              username, password);
          if (partner != null) {
            // Navigate to Employer Partner Dashboard with partner account details
            Navigator.pushReplacementNamed(
              context,
              '/emp_partners_dashboard',
              arguments: partner,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Invalid Employer Partner credentials.')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid user type selected.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    // emailController.dispose();
    _passwordController.dispose();
    _selectedUserType.dispose();
    super.dispose();
  }

  SimpleUIController simpleUIController = Get.put(SimpleUIController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SimpleUIController simpleUIController = Get.find<SimpleUIController>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return _buildLargeScreen(size, simpleUIController);
            } else {
              return _buildSmallScreen(size, simpleUIController);
            }
          },
        ),
      ),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: size.height,
            color: Colors.grey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
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
                ]),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: _buildLoginForm(
            size,
            simpleUIController,
          ),
        ),
        SizedBox(width: size.width * 0.06),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildLoginForm(
            size,
            simpleUIController,
          ),
        ],
      ),
    );
  }

  /// Main Body
  Widget _buildLoginForm(Size size, SimpleUIController simpleUIController) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: size.width > 600
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          size.width > 600
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
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Login',
              style: kLoginTitleStyle(size),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Welcome Back Catchy',
              style: kLoginSubtitleStyle(size),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
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
                      // if (value == null || value.isEmpty) {
                      //   return 'Please enter username';
                      // } else if (value.length < 4) {
                      //   return 'at least enter 4 characters';
                      // } else if (value.length > 13) {
                      //   return 'maximum character is 13';
                      // }
                      // return null;
                      value == null || value.isEmpty ? 'Enter username' : null;
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  // email
                  // TextFormField(
                  //   controller: emailController,
                  //   decoration: const InputDecoration(
                  //     prefixIcon: Icon(Icons.email_rounded),
                  //     hintText: 'gmail',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //     ),
                  //   ),
                  //   // The validator receives the text that the user has entered.
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter gmail';
                  //     } else if (!value.endsWith('@gmail.com')) {
                  //       return 'please enter valid gmail';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.02,
                  // ),

                  /// password
                  Obx(
                    () => TextFormField(
                      // style: kTextFormFieldStyle(),
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
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        // if (value == null || value.isEmpty) {
                        //   return 'Please enter some text';
                        // } else if (value.length < 7) {
                        //   return 'at least enter 6 characters';
                        // } else if (value.length > 13) {
                        //   return 'maximum character is 13';
                        // }
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

                  // login as
                  DropdownButtonFormField<String>(
                    value: _selectedUserType.text.isNotEmpty
                        ? _selectedUserType.text
                        : null,
                    hint: Text('Log In As'),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.switch_account),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    // items: [
                    //   'Student',
                    //   'Graduate',
                    //   'Coach',
                    //   'Employer Partner',
                    //   'Career Center Director'
                    // ]
                    items: [
                      'Graduate',
                      'Employer Partner',
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
                      // if (value == null || value.isEmpty) {
                      //   return 'Please enter user type';
                      // }
                      value == null || value.isEmpty
                          ? 'Select user type'
                          : null;
                      return null;
                    },
                  ),
                  // Text(
                  //   'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                  //   style: kLoginTermsAndPrivacyStyle(size),
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// Login Button
                  loginButton(),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  /// Navigate To Login Screen
                  GestureDetector(
                    onTap: () {
                      // Navigate back
                      Navigator.pop(context);

                      debugPrint('Sign up button tapped.');

                      // Reset form state
                      if (_formKey.currentState != null) {
                        _formKey.currentState!.reset();
                        debugPrint('Form successfully reset.');
                      } else {
                        debugPrint('FormState is null.');
                      }

                      // Clear input fields
                      _usernameController.clear();
                      // emailController.clear();
                      _passwordController.clear();
                      _selectedUserType.clear();
                      debugPrint('Text controllers cleared.');

                      // Reset obscure state
                      if (simpleUIController.isObscure != null) {
                        simpleUIController.isObscure.value = true;
                        debugPrint('Password visibility reset.');
                      } else {
                        debugPrint('SimpleUIController isObscure is null.');
                      }
                      debugPrint('Navigated back to the previous screen.');
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: kHaveAnAccountStyle(size),
                        children: [
                          TextSpan(
                            text: " Sign up",
                            style: kLoginOrSignUpTextStyle(
                              size,
                            ),
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

  // Login Button
  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      child:
          // _isLoading
          //     ? const Center(child: CircularProgressIndicator())
          //     : ElevatedButton(
          //         // onPressed: _signUp,
          //         onPressed: () {
          //           // Validate returns true if the form is valid, or false otherwise.
          //           _login();
          //         },
          //         child: const Text('Log In'),
          //       ),
          ElevatedButton(
        onPressed: _isLoading ? null : _login,
        child: _isLoading
            ? const CircularProgressIndicator()
            : const Text('Login'),
      ),
    );
  }
}
