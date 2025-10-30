import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firstNameController = TextEditingController();
final lastNameController = TextEditingController();
final usernameController = TextEditingController();
final mobileNumberController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final repeatPasswordController = TextEditingController();

final ValueNotifier<bool> passwordVisible = ValueNotifier<bool>(false);
final ValueNotifier<bool> confirmPasswordVisible = ValueNotifier<bool>(false);

void togglePasswordVisibility() {
  passwordVisible.value = !passwordVisible.value;
}

void toggleConfirmPasswordVisibility() {
  confirmPasswordVisible.value = !confirmPasswordVisible.value;
}

bool _hasValue(String input) => input.trim().isNotEmpty;
bool _isMatch(String a, String b) => a == b;
bool _isValidName(String name) =>
    RegExp(r'^[A-Za-z]+(?: [A-Za-z]+)*$').hasMatch(name);

bool _isValidPassword(String pass) {
  if (pass.length < 8) return false;

  bool hasUppercase = pass.contains(RegExp(r'[A-Z]'));
  bool hasLowercase = pass.contains(RegExp(r'[a-z]'));
  bool hasNumber = pass.contains(RegExp(r'[0-9]'));
  bool hasSymbol = pass.contains(RegExp(r'[\W_]'));

  return hasUppercase && hasLowercase && hasNumber && hasSymbol;
}

bool _isValidEmail(String email) =>
    RegExp(r'^[\w\.-]+@(gmail|yahoo)\.com$').hasMatch(email);
bool isValidMobileNumber(String value) => RegExp(r'^(\d{10})$').hasMatch(value);

bool areFieldsValid({
  required String firstName,
  required String lastName,
  required String username,
  required String mobileNumber,
  required String email,
  required String password,
  required String repeatPassword,
}) {
  return _isValidName(firstName) &&
      _isValidName(lastName) &&
      _hasValue(username) &&
      isValidMobileNumber(mobileNumber) &&
      _isValidEmail(email) &&
      _isValidPassword(password) &&
      _isMatch(password, repeatPassword);
}

bool isFormValid() {
  return areFieldsValid(
    firstName: firstNameController.text,
    lastName: lastNameController.text,
    username: usernameController.text,
    mobileNumber: mobileNumberController.text,
    email: emailController.text,
    password: passwordController.text,
    repeatPassword: repeatPasswordController.text,
  );
}

String? getMobileNumberError(String value) {
  if (value.isEmpty) return null;
  if (!isValidMobileNumber(value)) {
    return 'Enter valid PH number (09 or +639)';
  }
  return null;
}

String? getEmailError(String value) {
  if (value.trim().isEmpty) return null;
  if (!_isValidEmail(value)) {
    return 'Enter a valid email (e.g. name@gmail.com)';
  }
  return null;
}

String? getPasswordError(String value) {
  if (value.isEmpty) return null;

  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }

  bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
  bool hasLowercase = value.contains(RegExp(r'[a-z]'));
  bool hasNumber = value.contains(RegExp(r'[0-9]'));
  bool hasSymbol = value.contains(RegExp(r'[\W_]'));

  if (!hasUppercase || !hasLowercase || !hasNumber || !hasSymbol) {
    return "Must follow the requirements: at least 1 capital letter, small letter, number, and symbol '(Aa0.)'";
  }

  return null;
}

List<TextInputFormatter> mobileNumberInputFormatters() {
  return [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9\+]')),
    LengthLimitingTextInputFormatter(10),
  ];
}

void resetFormFields({required VoidCallback updateUI}) {
  firstNameController.clear();
  lastNameController.clear();
  usernameController.clear();
  mobileNumberController.clear();
  emailController.clear();
  passwordController.clear();
  repeatPasswordController.clear();
  updateUI();
}

//If yung email existed na
Future<String?> checkDuplicateUser({
  required String email,
  required String mobileNumber,
}) async {
  try {
    final emailQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('Email', isEqualTo: email.trim())
        .get();

    if (emailQuery.docs.isNotEmpty) {
      return 'Email already exists.';
    }

    final phoneQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('Mobile Number', isEqualTo: mobileNumber.trim())
        .get();

    if (phoneQuery.docs.isNotEmpty) {
      return 'Phone number already exists.';
    }

    return null;
  } catch (e) {
    return 'Error checking existing users: $e';
  }
}

Map<String, String?> validateAllFields() {
  final errors = <String, String?>{};

  if (!_hasValue(firstNameController.text)) {
    errors['firstName'] = 'First name is required';
  } else if (!_isValidName(firstNameController.text)) {
    errors['firstName'] = 'Invalid first name';
  }

  if (!_hasValue(lastNameController.text)) {
    errors['lastName'] = 'Last name is required';
  } else if (!_isValidName(lastNameController.text)) {
    errors['lastName'] = 'Invalid last name';
  }

  if (!_hasValue(usernameController.text)) {
    errors['username'] = 'Username is required';
  }

  if (!_hasValue(emailController.text)) {
    errors['email'] = 'Email is required';
  } else if (!_isValidEmail(emailController.text)) {
    errors['email'] = 'Enter a valid email (e.g. name@gmail.com)';
  }

  if (!_hasValue(mobileNumberController.text)) {
    errors['mobileNumber'] = 'Mobile number is required';
  } else if (!isValidMobileNumber(mobileNumberController.text)) {
    errors['mobileNumber'] = 'Must 9 digits input';
  }

  if (!_hasValue(passwordController.text)) {
    errors['password'] = 'Password is required';
  } else {
    final passwordError = getPasswordError(passwordController.text);
    if (passwordError != null) {
      errors['password'] = passwordError;
    }
  }

  if (!_hasValue(repeatPasswordController.text)) {
    errors['repeatPassword'] = 'Please repeat your password';
  } else if (!_isMatch(
    passwordController.text,
    repeatPasswordController.text,
  )) {
    errors['repeatPassword'] = 'Passwords do not match';
  }

  return errors;
}
