import 'package:ecom/model/user.dart';
import 'package:ecom/utlity/utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              controller: _nameTextController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              controller: _emailTextController,
            ),
            FlatButton(
                onPressed: () {
                  final name = _nameTextController.text;
                  final email = _emailTextController.text;
                  final user = User(1, name, email);
                  Navigator.of(context).pop(user);
                },
                child: Text('Log In'))
          ],
        ),
      ),
    );
  }
}
