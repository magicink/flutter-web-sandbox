import 'package:flutter/material.dart';

import 'Logout.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var navigationResult = await Navigator.push(context, new MaterialPageRoute(
              builder: (context) => Logout()
          ));
          if (navigationResult) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Success!'
                  ),
                )
            );
          }
        },
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ILikeThisAtThere',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'Login'
              )
            ],
          ),
        ),
      ),
    );
  }
}
