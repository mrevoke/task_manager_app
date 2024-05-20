
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/Frontend/Util/routes.dart';
import '../../../../Essentials_App/depndency_injection.dart';
import '../../../../Core_Logic/models/auth_models/requests/login/login_request.dart';
import '../Login_blocs/auth_bloc/auth_bloc.dart';
import '../widgets/login_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AuthBloc authBloc;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    authBloc = instance<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 const Text(
                  'Task Manager',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 40),
                LoginField(
                  labelText: 'Username',
                  iconData: Icons.person,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter username.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                LoginField(
                  isPassword: true,
                  labelText: 'Password',
                  iconData: Icons.lock,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter password.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                BlocConsumer<AuthBloc, AuthState>(
                  bloc: authBloc,
                  listener: (context, state) {
                    state.mapOrNull(
                      success: (value) {
                        Fluttertoast.showToast(
                          msg: "Authenticated",
                          backgroundColor:
                              const Color.fromARGB(255, 183, 219, 227),
                        );
                        context.goNamed(RoutesNames.todosRoute);
                      },
                      error: (value) {
                        Fluttertoast.showToast(
                          msg: value.message,
                          backgroundColor: Colors.red,
                        );
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      orElse: () {
                        return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authBloc.add(
                                AuthEvent.login(
                                  request: LoginRequest(
                                    username: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 22),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
