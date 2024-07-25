import 'package:flutter/material.dart';

import '../Models/user_credential_model.dart';

List<UserCredentialModel> registrationScreen = [
  UserCredentialModel(
    exampleInput: 'Raj',
    credentialType: 'First Name',
    suffixIcon: Icons.person_outline,
  ),
  UserCredentialModel(
      exampleInput: 'Singh',
      credentialType: 'Last Name',
      suffixIcon: Icons.person_outline),
  UserCredentialModel(
      exampleInput: 'macof.rj@gmail.com',
      credentialType: 'Email',
      suffixIcon: Icons.email_outlined),
  UserCredentialModel(
      exampleInput: '!@#%&*',
      credentialType: 'Password',
      suffixIcon: Icons.password),
  UserCredentialModel(
      exampleInput: '!@#%&*',
      credentialType: 'Confirm Password',
      suffixIcon: Icons.password),
];
