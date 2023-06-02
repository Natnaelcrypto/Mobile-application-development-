import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginErrorpage extends StatelessWidget {
  const LoginErrorpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Error"),
        backgroundColor: Color.fromRGBO(36, 130, 50, .6),
      ),
      body: Container(
        height: 1000,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              const Text("You don't have account"),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(8, 103, 136, .9)),
                child: const Text("Back"),
                onPressed: () {
                  context.go("/");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
