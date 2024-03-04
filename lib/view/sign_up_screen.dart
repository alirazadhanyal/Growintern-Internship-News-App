import 'package:bnews/const/style_custom.dart';
import 'package:bnews/provider/user_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sign_in_screen.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserAuthProvider>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create Account",
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
          const SizedBox(height: 20),
          const Text("Confirm Password"),
          const SizedBox(height: 10),
          TextField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              if (_confirmPasswordController.text == _passwordController.text) {
                authProvider.signUp(
                    _emailController.text, _passwordController.text);
              } else {
                const ScaffoldMessenger(
                    child: SnackBar(content: Text("Password is mismatched")));
                debugPrint("Password is mismatched");
              }
            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.green,
              height: 55,
              width: double.infinity,
              child: Text(
                "Sign Up",
                style: MyStyle.textStyleBold().copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account ?"),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ));
                },
                child: const Text(
                  "Sign In",
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
