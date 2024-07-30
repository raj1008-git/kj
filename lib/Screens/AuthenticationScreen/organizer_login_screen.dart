import 'package:flutter/material.dart';
import 'package:kata_jane/Screens/AuthenticationScreen/organizer_registration_screen.dart';
import 'package:provider/provider.dart';

import '../../Functions/authFunctions.dart';
import '../OrganizerDashboard/organizer_dashboard.dart';

class OrganizerLoginScreen extends StatefulWidget {
  const OrganizerLoginScreen({super.key});

  @override
  State<OrganizerLoginScreen> createState() => _OrganizerLoginScreenState();
}

class _OrganizerLoginScreenState extends State<OrganizerLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isButtonPressed = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {}

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'Organizer Login',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  cursorColor: Colors.white,
                  cursorHeight: 26,
                  controller: _emailController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.email_outlined),
                    filled: true,
                    fillColor: Colors.black12,
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    focusColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 16),
                    hintText: "Eg. example@example.com",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    labelText: "Email",
                    labelStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.pinkAccent,
                          width: 1.0,
                          style: BorderStyle.solid),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.white,
                  cursorHeight: 26,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.lock_outline),
                    filled: true,
                    fillColor: Colors.black12,
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    focusColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 16),
                    hintText: "Password",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    labelText: "Password",
                    labelStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.pinkAccent,
                          width: 1.0,
                          style: BorderStyle.solid),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password too short';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                isButtonPressed
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : SizedBox(
                        height: 2,
                      ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 154, vertical: 17),
                  color: Colors.pink,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      authService
                          .loginAsOrganizer(
                        context,
                        _emailController.text,
                        _passwordController.text,
                      )
                          .catchError((error) {
                        print(error);
                      });
                    }
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardPage()),
                      (Route<dynamic> route) =>
                          false, // This condition removes all routes below
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const OrganizerRegistrationScreen();
                            }),
                          );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
