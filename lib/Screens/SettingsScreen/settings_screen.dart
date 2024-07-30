import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kata_jane/Screens/AuthenticationScreen/login_screen.dart';
import 'package:kata_jane/Screens/AuthenticationScreen/organizer_registration_screen.dart';
import 'package:kata_jane/main_scaffold.dart';
import 'package:provider/provider.dart';

import '../../Functions/authFunctions.dart';
// Adjust the import path if necessary
import 'Models/helpandsupport.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<SettingsScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundImage: (_image == null)
                                    ? const NetworkImage(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMhxC4KjH1GAAvMmrUskYdxkLmQjqWpoza6w&s')
                                    : FileImage(File(_image!.path))
                                        as ImageProvider,
                              ),
                              Positioned(
                                bottom: -10,
                                right: 40,
                                child: GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.edit_outlined,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                size: 22,
                                Icons.person,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Zomato Boy ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                size: 22,
                                Icons.email,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'zomato.boy@gmail.com',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                size: 22,
                                Icons.call,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                '+977-9761544531',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          MaterialButton(
                            padding: const EdgeInsets.only(
                                top: 14, bottom: 14, left: 20, right: 40),
                            color: Colors.pink,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrganizerRegistrationScreen()),
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 14,
                                ),
                                Text(
                                  'Become an Organizer? Click here',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Help & Support',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: helpandsupport.length,
                          itemBuilder: (BuildContext context, int index) {
                            return helpandsupport[index];
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 130),
                    color: Colors.pink,
                    onPressed: () async {
                      if (authService.user == null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }),
                        );
                      } else {
                        await authService.logout(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MainScaffold(selectedIndex: 0),
                          ),
                        );
                      }
                    },
                    child: Text(
                      authService.user == null ? 'Login' : 'Logout',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
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
}
