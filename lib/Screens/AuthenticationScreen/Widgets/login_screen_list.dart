import 'package:flutter/material.dart';

import '../Models/user_credential_model.dart';

List<UserCredentialModel> loginScreen = [
  UserCredentialModel(
      exampleInput: 'macof.rj@gmail.com',
      credentialType: 'Email',
      suffixIcon: Icons.email_outlined),
  UserCredentialModel(
      exampleInput: '!@#%&*',
      credentialType: 'Password',
      suffixIcon: Icons.password),
];
