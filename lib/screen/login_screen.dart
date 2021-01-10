import 'dart:convert';

import 'package:ecom/model/login_result.dart';
import 'package:ecom/model/user.dart';
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

    _emailTextController.text = 'abc@rupp.edu.kh';
    _passwordTextController.text = '123456';

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
    if (password.length < 6) {
      showAlertDialog(
          'Invalid Input', 'Your password must be more than 5 characters.');
      return;
    }

    // Login with server
    setState(() {
      isProcessing = true;
    });
    login(email, password).then((loginResult) {
      if (loginResult.success) {
        Navigator.pop(context, loginResult.user);
      } else {
        setState(() {
          isProcessing = false;
        });
        showAlertDialog('Login Fail', loginResult.message);
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

  Future<LoginResult> login(String email, String password) async {
    print('Login: $email');
    try {
      final url = 'http://localhost/test/ruppmad-api/login.php';
      final body = {'email': email, 'password': password};
      final response = await post(url, body: body);
      if (response.statusCode != 200) {
        return LoginResult(false, 'Unexpected error.', null);
      }

      final responseJson = jsonDecode(response.body);
      return LoginResult.fromJson(responseJson);
    } catch (exception) {
      print('[login] Error: $exception');
      return LoginResult(false, exception.toString(), null);
    }
  }
}
