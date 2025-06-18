import 'package:budget_tracker/authentication_screen/register.dart';
import 'package:budget_tracker/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen")),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: "Password"),
          ),
          const SizedBox(height: 20),
          authProvider.isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    authProvider.login(
                      emailController.text,
                      passwordController.text,
                    );
                  },
                  child: const Text("Login"),
                ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => const Register()));
            },
            child: Text("Don't have account register"),
          ),
        ],
      ),
    );
  }
}
