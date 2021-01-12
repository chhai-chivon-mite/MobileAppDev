import 'dart:convert';

import 'package:ecom/model/login_result.dart';
import 'package:ecom/model/user.dart';
import 'package:ecom/provider/api_provider.dart';
import 'package:ecom/utlity/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  bool hidePassword = true;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();

    _emailTextController.text = 'admin@ited.com';
    _passwordTextController.text = 'admin';

    // Read email from shared preference
    final emailTask = readEmailFromSharedPreference();
    emailTask.then((email) {
      setState(() {
        _emailTextController.text = email;
      });
    });

    readEmailFromSharedPreference().then((email) {
      setState(() {
        _emailTextController.text = email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              controller: _emailTextController,
            ),
            TextField(
              obscureText: hidePassword,
              decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                      icon: Icon(hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: onPasswordVisibilityClick)),
              controller: _passwordTextController,
            ),
            isProcessing
                ? Utils.progressIndicator()
                : FlatButton(
                    onPressed: onLoginButtonClick, child: Text('Log In'))
          ],
        ),
      ),
    );
  }

  void saveEmailInSharedPreference(String email) {
    print('Prepare to save email');
    final sharedPreferenceTask = SharedPreferences.getInstance();
    sharedPreferenceTask.then((sharedPreference) {
      print('Save email: $email');
      sharedPreference.setString('email', email);
    });
  }

  Future<String> readEmailFromSharedPreference() async {
    final sharedPreference = await SharedPreferences.getInstance();
    final email = sharedPreference.getString('email');
    return email;
  }

  void onPasswordVisibilityClick() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void onLoginButtonClick() {
    final email = _emailTextController.text;
    final password = _passwordTextController.text;
    if (!validateEmail(email)) {
      showAlertDialog('Invalid Input', 'Please input a correct email address.');
      return;
    }
    if (password.length <= 4) {
      showAlertDialog(
          'Invalid Input', 'Your password must be more than 4 characters.');
      return;
    }

    // Login with server
    setState(() {
      isProcessing = true;
    });
    ApiProvider.instance.login(email, password).then((result) {
      if (result.success) {
        Navigator.pop(context, true);
      } else {
        setState(() {
          isProcessing = false;
        });
        showAlertDialog('Login Fail', result.message);
      }
    });
  }

  bool validateEmail(String email) {
    final pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'))
          ],
        );
      },
    );
  }
}
