import 'package:ecom/provider/api_provider.dart';
import 'package:ecom/screen/product_list_screen2.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlatButton(
            onPressed: testAuthorizedRequest,
            child: Text('Test Authorized Request')),
        FlatButton(
            onPressed: () {
              final route =
                  MaterialPageRoute(builder: (context) => ProductListScreen2());
              Navigator.push(context, route);
            },
            child: Text('Test Firestore')),
      ],
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
