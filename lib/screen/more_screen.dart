import 'package:ecom/provider/api_provider.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
          onPressed: testAuthorizedRequest,
          child: Text('Test Authorized Request')),
    );
  }

  void testAuthorizedRequest() {
    print('Load current user.');
    ApiProvider.instance.loadCurrentUser().then((value) {
      if (value == null) {
        print('Cannot load current user.');
      } else {
        print('Current user is ${value.name}');
      }
    });
  }
}
