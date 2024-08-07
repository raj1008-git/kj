import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kata_jane/Functions/authFunctions.dart';
import 'package:kata_jane/Screens/AuthenticationScreen/login_screen.dart';
import 'package:kata_jane/main_scaffold.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  String _selectedCountryCode = '+1'; // Default country code
  File? _profileImage; // Variable to store the selected image
  bool isButtonPressed = false;

  final List<String> _countryCodes = ['+1', '+44', '+91', '+33', '+49', '+977'];

  final ImagePicker _picker = ImagePicker(); // Initialize image picker

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _register() {}

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
          'Register',
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
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[800],
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 50,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.white,
                  cursorHeight: 26,
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.person_outline_outlined),
                    filled: true,
                    fillColor: Colors.black12,
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    focusColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 16),
                    hintText: "Eg. Raj",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    labelText: "First Name",
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
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.white,
                  cursorHeight: 26,
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.person_outline_outlined),
                    filled: true,
                    fillColor: Colors.black12,
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    focusColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 16),
                    hintText: "Eg. Doe",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    labelText: "Last Name",
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
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
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
                    hintText: "Confirm Password",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    labelText: "Confirm Password",
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
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Divider(
                  color: Colors.pink,
                  thickness: 2, // Thickness of the divider
                  height: 20, // Space around the divider
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedCountryCode,
                  items: _countryCodes.map((code) {
                    return DropdownMenuItem<String>(
                      value: code,
                      child: Text(
                        code,
                        style: const TextStyle(
                            color: Colors.white), // Ensure text color is white
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCountryCode = value!;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    labelText: 'Country Code',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.pinkAccent, width: 1.0),
                    ),
                  ),
                  dropdownColor: Colors
                      .black, // Set the background color of the dropdown menu
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.white,
                  cursorHeight: 26,
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.phone_outlined),
                    filled: true,
                    fillColor: Colors.black12,
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    focusColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 16),
                    hintText: "Eg. 1234567890",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    labelText: "Phone Number",
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
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.white,
                  cursorHeight: 26,
                  controller: _addressController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.home_outlined),
                    filled: true,
                    fillColor: Colors.black12,
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    focusColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 16),
                    hintText: "Eg. 123 Main St, City",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    labelText: "Address",
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
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
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
                      const EdgeInsets.symmetric(horizontal: 140, vertical: 17),
                  color: Colors.pink,
                  onPressed: () {
                    setState(() {
                      isButtonPressed = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      authService
                          .register(
                              _emailController.text,
                              _passwordController.text,
                              _firstNameController.text,
                              _lastNameController.text,
                              _phoneNumberController.text,
                              _addressController.text,
                              _selectedCountryCode,
                              _profileImage,
                              null,
                              null // Pass the profile image
                              )
                          .then((_) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MainScaffold(selectedIndex: 0)),
                          (Route<dynamic> route) =>
                              false, // This condition removes all routes below
                        );
                      }).catchError((error) {
                        // Handle errors (e.g., show a snackbar or alert dialog)
                        print(error);
                      });
                    }
                  },
                  child: const Text(
                    "Register",
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
                        'Already have an account?',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: const Text(
                          'Login',
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
