import 'package:budget_tracker/authentication_screen/register.dart';
import 'package:budget_tracker/providers/auth_provider.dart';
import 'package:budget_tracker/styles/custom_button.dart';
import 'package:budget_tracker/styles/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormBuilderState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 100, 18, 0),
          child: Column(
            children: [
              Text(
                "Sign in",
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
                style: const TextStyle(fontFamily: 'Mangsi', fontSize: 16),
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
                name: 'password',
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
                obscureText: true,
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
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              authProvider.isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      text: "Sign in",
                      onTap: () async {
                        if (_formKey.currentState!.saveAndValidate()) {
                          final errorMessage = await authProvider.login(
                            emailController.text,
                            passwordController.text,
                          );
                          // ignore: unnecessary_null_comparison
                          if (errorMessage != null) {
                            // Show error as a SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errorMessage),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                    ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Register()),
                  );
                },
                child: Text(
                  "Don't have account register",
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
