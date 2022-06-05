import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_mongo/data/user.dart';
import 'package:flutter_node_mongo/data/user_request.dart';
import 'package:flutter_node_mongo/service/auth/auth_service.dart';
import 'package:flutter_node_mongo/service/auth/auth_service_impl.dart';

import '../widgets/custom_text_fields.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthServiceImpl();
  login() async {
    late BuildContext dialogContext;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          dialogContext = context;
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      final response = await authService.login(
        request: UserRequest(
          user: User(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ),
        ),
      );
      if (response.user == null) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response.message ?? "something went wrong")));
      }
      Navigator.pop(dialogContext);
      inspect(response);
    } on DioError catch (e) {
      Navigator.pop(dialogContext);
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(e.response?.data["message"] ?? "something went wrong")));
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "LOGIN",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                controller: emailController,
                hintText: "Email",
              ),
              CustomTextField(
                isPassword: true,
                controller: passwordController,
                hintText: "Password",
              ),
              ElevatedButton(onPressed: () => login(), child: Text("Login")),
              const Text("OR"),
              ElevatedButton(
                  onPressed: () => null, child: const Text("Sign up")),
            ],
          ),
        ),
      ),
    );
  }
}
