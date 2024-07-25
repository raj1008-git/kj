import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCredentialModel extends StatelessWidget {
  String credentialType;
  String exampleInput;
  IconData suffixIcon;

  UserCredentialModel(
      {super.key,
      required this.exampleInput,
      required this.credentialType,
      required this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 14,
          ),
          Text(
            credentialType,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            style: TextStyle(fontSize: 24),
            cursorHeight: 26,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 26, vertical: 16),
              focusColor: Colors.white,
              floatingLabelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.pinkAccent,
                    width: 1.0,
                    style: BorderStyle.solid),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: 'Eg:  ${exampleInput}',
              // border: OutlineInputBorder(),
              suffixIcon: Icon(suffixIcon),
              filled: true,
              fillColor: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }
}
