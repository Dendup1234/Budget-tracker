import 'package:budget_tracker/providers/auth_provider.dart';
import 'package:budget_tracker/styles/custom_button.dart';
import 'package:budget_tracker/styles/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 100, 18, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Register",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Mangsi',
                  fontSize: 48,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 70),
              FormBuilderTextField(
                name: "email",
                controller: emailController,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
                style: TextStyle(
                  // this changes the input text style
                  fontFamily: 'Mangsi',
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: "EMAIL ADDRESS",
                  labelStyle: TextStyle(
                    // this changes the "Email" label style
                    fontFamily: 'HK',
                    fontSize: 16,
                    color: Color.fromARGB(255, 108, 108, 108),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              FormBuilderTextField(
                obscureText: true,
                name: "password",
                controller: passwordController,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
                style: TextStyle(
                  // this changes the input text style
                  fontFamily: 'Mangsi',
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: "PASSWORD",
                  labelStyle: TextStyle(
                    // this changes the "Email" label style
                    fontFamily: 'HK',
                    fontSize: 16,
                    color: Color.fromARGB(255, 108, 108, 108),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FormBuilderTextField(
                obscureText: true,
                name: "confirm_password",
                controller: confirmController,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
                style: TextStyle(
                  // this changes the input text style
                  fontFamily: 'Mangsi',
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: "CONFIRM PASSWORD",
                  labelStyle: TextStyle(
                    // this changes the "Email" label style
                    fontFamily: 'HK',
                    fontSize: 16,
                    color: Color.fromARGB(255, 108, 108, 108),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              auth.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: "Register",
                      onTap: () async {
                        final result = await auth.register(
                          emailController.text.trim(),
                          passwordController.text,
                          confirmController.text,
                        );

                        if (result != null) {
                          // Show error
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(result)));
                        } else {
                          // Success: will auto-navigate because of Consumer in main.dart
                          Navigator.pop(
                            context,
                          ); // Optional if returning to login screen
                        }
                      },
                    ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "OR",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "HK",
                  color: const Color.fromARGB(255, 105, 105, 105),
                ),
              ),
              const SizedBox(height: 30),
              CustomIconButton(
                text: "Continue with Facebook",
                icon: Icons.facebook,
                onTap: () {},
                backgroundColor: const Color(0xFF1877F2),
                textColor: Colors.white,
                iconColor: Colors.white,
              ),
              const SizedBox(height: 30),
              CustomIconButton(
                text: "Continue with Google",
                icon: FontAwesomeIcons.google,
                onTap: () {},
                backgroundColor: const Color.fromARGB(255, 231, 231, 231),
                textColor: Colors.black,
                iconColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
