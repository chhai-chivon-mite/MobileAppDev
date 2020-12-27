import 'package:ecom/model/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<LoginScreen> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

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

                  // Save email in SharedPreference
                  saveEmailInSharedPreference(email);

                  final user = User(1, name, email);
                  Navigator.of(context).pop(user);
                },
                child: Text('Log In'))
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
}
