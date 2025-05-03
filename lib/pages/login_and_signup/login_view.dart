import 'package:flutter/material.dart';
import 'package:flutter_app/pages/career_center_director_account/director_home_screen.dart';
import 'package:flutter_app/pages/wdt_account/wdt_home_screen.dart';
import 'package:flutter_app/pages/dean_account/dean_home_screen.dart';
import 'package:flutter_app/pages/employer_partners_account/partner_home_screen.dart';
import 'package:flutter_app/pages/graduates_account/graduate_home_screen.dart';
import 'package:flutter_app/pages/login_and_signup/signUp_view.dart';
import 'package:flutter_app/pages/students_account/student_home_screen.dart';
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
  final double screenWidth = 0;
  final userApiService = UserApiService();

  final TextEditingController _usernameController = TextEditingController();
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
          final graduateAccount =
              await userApiService.fetchGraduateAccount(username, password);
          if (graduateAccount != null) {
            // Navigate to Graduate Dashboard with graduate account details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomeScreenGraduate(graduateAccount: graduateAccount),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Graduate credentials.')),
            );
          }
        } else if (userType == 'Employer Partner') {
          final employerPartnerAccount = await userApiService
              .fetchIndustryPartnerAccount(username, password);
          if (employerPartnerAccount != null) {
            // Navigate to Employer Partner Dashboard with employer partner account details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreenPartner(
                    employerPartnerAccount: employerPartnerAccount),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Invalid Employer Partner credentials.')),
            );
          }
        } else if (userType == 'Student') {
          final studentAccount =
              await userApiService.fetchStudentAccount(username, password);
          if (studentAccount != null) {
            // Navigate to Student Dashboard with student account details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomeScreenStudent(studentAccount: studentAccount),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Student credentials.')),
            );
          }
        } else if (userType == 'College Dean') { 
          final collegeDeanAccount =
              await userApiService.fetchDeanAccount(username, password);
          if (collegeDeanAccount != null) {
            // Navigate to Dean Dashboard with dean account details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomeScreenDean(collegeDeanAccount: collegeDeanAccount),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Dean credentials.')),
            );
          }
        } else if (userType == 'Workforce Development Trainer') {
          final coachAccount =
              await userApiService.fetchCoachAccount(username, password);
          if (coachAccount != null) {
            // Navigate to Workforce Development Trainer Dashboard with Workforce Development Trainer account details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomeScreenCoach(coachAccount: coachAccount, screenWidth: screenWidth,),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Workforce Development Trainer credentials.')),
            );
          }
        } else if (userType == 'Career Center Director') {
          final directorAccount =
              await userApiService.fetchDirectorAccount(username, password);
          if (directorAccount != null) {
            // Navigate to Career Center Director Dashboard with director account details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomeScreenDirector(directorAccount: directorAccount),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid Director credentials.')),
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
    _passwordController.dispose();
    _selectedUserType.dispose();
    super.dispose();
  }

  final SimpleUIController simpleUIController = Get.put(SimpleUIController());

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
            if (constraints.maxWidth > 700) {
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
          child: _buildLoginForm(
            size,
            simpleUIController,
          ),
        ),
        SizedBox(width: size.width * 0.03),
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
            padding: const EdgeInsets.only(left: 16.0),
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
              'Welcome Back UNCean',
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
                        : null, // Ensure no null value
                    hint: Text('Log In As'),
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
                      'Workforce Development Trainer',
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
                        _selectedUserType.text =
                            value ?? ''; // Avoid null values
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

                  /// Login Button
                  loginButton(),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  /// Navigate To Login Screen
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpView()),
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
      child: ElevatedButton(
        onPressed: _isLoading ? null : _login,
        child: _isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
            )
            : const Text('Login'),
      ),
    );
  }
}
