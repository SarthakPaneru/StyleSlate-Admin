import 'dart:convert';
import 'dart:core';

import 'package:barberside/Screen/mainscreen.dart';
import 'package:barberside/auth/barber.dart';
import 'package:barberside/config/api_requests.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/Screen/forgot_pwd.dart';
import '/Screen/register.dart';
import '/Widgets/colors.dart';
import '../auth/token.dart';
import '../config/api_service.dart';
import '../config/app_constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isEmailValid = true;
  bool isPasswordValid = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final ApiService _apiService = ApiService();
  final Token _token = Token();
  final ApiRequests _apiRequests = ApiRequests();
  final Barber _barber = Barber();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _validateEmail() {
    String email = _emailController.text.trim();
    setState(() {
      isEmailValid = EmailValidator.validate(email);
    });
  }

  void _validatePassword() {
    String password = _passwordController.text;
    setState(() {
      isPasswordValid = _validatePasswordStrength(password);
    });
  }

  bool _validatePasswordStrength(String password) {
    return password.isNotEmpty ||
        password.contains(RegExp(r'[A-Z]')) ||
        password.contains(RegExp(r'[0-9]')) ||
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar('Please enter both email and password.');
      return;
    }

    if (!isEmailValid || !isPasswordValid) {
      _showSnackbar('Please correct the errors in the form.');
      return;
    }

    final payload = {
      'email': email,
      'password': password,
      'userRole': 'BARBER'
    };
    final jsonPayload = jsonEncode(payload);

    try {
      http.Response response = await _apiService.post(
          '${ApiConstants.authEndpoint}/login', jsonPayload);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        String token = jsonResponse['accessToken'];

        await _token.storeBearerToken(token);

        http.Response response1 = await _apiRequests.getLoggedInBarber();
        Map<String, dynamic> jsonResponse1 = jsonDecode(response1.body);
        _barber.storeBarberDetails(jsonResponse1);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const MainScreen(),
          ),
        );
      } else {
        _showSnackbar('Login failed. Please check your credentials.');
      }
    } catch (e) {
      _showSnackbar('An error occurred. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: PrimaryColors.primarybrown,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: PrimaryColors.primarybrown),
      ),
      home: ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  PrimaryColors.primarybrown,
                  PrimaryColors.primarybrown.withOpacity(0.7),
                ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Hero(
                            tag: 'logo',
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'lib/assets/barber_logo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildTextField(
                            controller: _emailController,
                            hint: 'Email',
                            icon: Icons.email,
                            isPassword: false,
                            validator: _validateEmail,
                            isValid: isEmailValid,
                            focusNode: _emailFocusNode,
                            nextFocusNode: _passwordFocusNode,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            controller: _passwordController,
                            hint: 'Password',
                            icon: Icons.lock,
                            isPassword: true,
                            validator: _validatePassword,
                            isValid: isPasswordValid,
                            focusNode: _passwordFocusNode,
                            nextFocusNode: null,
                            onSubmitted: _login,
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: PrimaryColors.primarybrown,
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Forgetpassword()),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const Register()),
                              );
                            },
                            child: const Text(
                              "Don't have an Account? Register Here",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool isPassword,
    required Function() validator,
    required bool isValid,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
    Function()? onSubmitted,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: controller.text.isNotEmpty
              ? (isValid ? Colors.green : Colors.red)
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? passwordVisible : false,
        style: const TextStyle(color: Colors.white),
        focusNode: focusNode,
        textInputAction:
            nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
        onSubmitted: (_) {
          if (nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          } else if (onSubmitted != null) {
            onSubmitted();
          }
        },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          prefixIcon: Icon(icon, color: Colors.white),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onChanged: (_) {
          validator();
          setState(() {});
        },
      ),
    );
  }

  void _showSnackbar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.red.shade800,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
