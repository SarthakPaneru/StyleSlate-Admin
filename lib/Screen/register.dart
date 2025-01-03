import 'package:flutter/material.dart';
import '../config/api_requests.dart';
import '/Screen/login.dart';
import '/Widgets/appbar.dart';
import '/Widgets/buttons.dart';
import '/Widgets/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final ApiRequests _apiRequests = ApiRequests();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();

    super.dispose();
  }

  Future<void> _register() async {
    String firstname = _firstNameController.text;
    String lastname = _lastNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmpassword = _confirmpasswordController.text;
    final bool isValid = EmailValidator.validate(_emailController.text.trim());

    if (firstname.isEmpty ||
        lastname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmpassword.isEmpty) {
      print('$email');

      _showSnackbar('Registration failed. Please check your credentials.');
      return;
    }
    if (password != confirmpassword) {
      // Show an error message if new password and confirm password don't match
      _showSnackbar('Registration failed. Please check your credentials.');
      return;
    }
    if (isValid == false) {
      print('$email');

      _showSnackbar('Registration failed. Please check your credentials.');
      return;
    }
    http.Response response = await _apiRequests.register(
        email, password, confirmpassword, firstname, lastname);
    print('status code: ${response.statusCode}');
    print('Payload: ${response.body}');
    if (response.statusCode == 201) {
      //sucessfully register
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const Login();
          },
        ),
      );
    } else {
      //handle login failure
      _showSnackbar('Registration failed. Please check your credentials.');
      print('Registration failed with code: ${response.statusCode}');
    }

    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmpasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: MyAppBar(
                title: 'Register New User',
                onpressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.all(2),
                        height: 150,
                        width: 150,
                        child: Image.asset('lib/assets/images/barberlogo.png'),
                      ),
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: PrimaryColors.primarybrown,
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _firstNameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          labelText: 'First Name',
                          icon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _lastNameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          labelText: 'Last Name',
                          icon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          labelText: 'email',
                          icon: const Icon(Icons.mail),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          labelText: 'Password',
                          icon: const Icon(Icons.lock),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _confirmpasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          labelText: 'Confirm Password',
                          icon: const Icon(Icons.lock),
                        ),
                      ),
                      const SizedBox(height: 15),
                      CustomButton(
                        label: 'Register',
                        icon: Icons.arrow_circle_right_sharp,
                        onpressed: _register,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const Login();
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(
                          "Already have an Account? LogIn Here",
                          style: TextStyle(
                            fontSize: 17,
                            color: PrimaryColors.primarybrown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  void _showSnackbar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
