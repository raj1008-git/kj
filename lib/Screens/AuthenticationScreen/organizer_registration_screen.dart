import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kata_jane/Functions/authFunctions.dart';
import 'package:provider/provider.dart';

import 'organizer_login_screen.dart';

class OrganizerRegistrationScreen extends StatefulWidget {
  const OrganizerRegistrationScreen({super.key});

  @override
  State<OrganizerRegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends State<OrganizerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _organizationNameController = TextEditingController();
  final _panNumberController = TextEditingController(); // Add this line
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
    _organizationNameController.dispose();
    _panNumberController.dispose(); // Dispose of the new controller
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
                Text(
                  'Organizer',
                  style: TextStyle(color: Colors.pink, fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
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
                  controller: _organizationNameController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.business_outlined),
                    filled: true,
                    fillColor: Colors.black12,
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    focusColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 16),
                    hintText: "Eg. Event Organizers Inc.",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    labelText: "Organization Name",
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
                      return 'Please enter your organization name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.white,
                  cursorHeight: 26,
                  controller: _panNumberController, // Add this line
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.credit_card_outlined),
                    filled: true,
                    fillColor: Colors.black12,
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    focusColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 16),
                    hintText: "Eg. ABCDE1234F",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    labelText: "PAN Number",
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
                      return 'Please enter your PAN number';
                    }
                    return null;
                  },
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
                    hintText: "Eg. Sharma",
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
                    hintText: "Eg. raj.sharma@gmail.com",
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
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[\w-]+@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.white,
                  cursorHeight: 26,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.lock_outline),
                    filled: true,
                    fillColor: Colors.black12,
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    focusColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 16),
                    hintText: "********",
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        cursorColor: Colors.white,
                        cursorHeight: 26,
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.phone_outlined),
                          filled: true,
                          fillColor: Colors.black12,
                          floatingLabelStyle:
                              const TextStyle(color: Colors.white),
                          focusColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 26, vertical: 16),
                          hintText: "Eg. 1234567890",
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          labelText: "Phone Number",
                          labelStyle: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0),
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: _selectedCountryCode,
                      items: _countryCodes.map((String code) {
                        return DropdownMenuItem<String>(
                          value: code,
                          child: Text(code),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCountryCode = newValue!;
                        });
                      },
                      dropdownColor: Colors.black,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: Colors.white,
                  cursorHeight: 26,
                  controller: _addressController,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.location_on_outlined),
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
                const SizedBox(height: 20),
                isButtonPressed
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : SizedBox(
                        height: 1,
                      ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      authService
                          .registerAsOrganizer(
                              _emailController.text,
                              _passwordController.text,
                              _firstNameController.text,
                              _lastNameController.text,
                              _phoneNumberController.text,
                              _addressController.text,
                              _selectedCountryCode,
                              _profileImage,
                              _organizationNameController.text,
                              _panNumberController.text // Pass the PAN number
                              )
                          .then((_) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    OrganizerLoginScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                          (Route<dynamic> route) =>
                              false, // This removes all the previous routes
                        );
                      }).catchError((error) {
                        // Handle errors (e.g., show a snack bar or alert dialog)
                        print(error);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.pinkAccent, // Text color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 27, vertical: 16),
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Register'),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrganizerLoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Already have an account? Login',
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 16),
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
