import 'package:bnews/const/style_custom.dart';
import 'package:bnews/provider/user_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userAuthProvider = Provider.of<UserAuthProvider>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back",
            style: MyStyle.textStyleBold(),
          ),
          const SizedBox(height: 30),
          const Text("Email"),
          const SizedBox(height: 10),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Password"),
          const SizedBox(height: 10),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          const Text("Forget Password?"),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              userAuthProvider.signIn(
                  _emailController.text, _passwordController.text, context);
            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.green,
              height: 55,
              width: double.infinity,
              child: Text(
                "Sign In",
                style: MyStyle.textStyleBold().copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account ?"),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ));
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
