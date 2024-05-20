import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/Frontend/Functions/Loading_Screen/blocs/app_bloc/app_bloc.dart';

import '../../Util/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    context.read<AppBloc>().add(const AppEvent.logged());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: context.read<AppBloc>(),
        listener: (context, AppState state) {
          state.maybeMap(
            orElse: () {},
            auth: (value) {
              context.goNamed(RoutesNames.loginRoute);
            },
            home: (value) {
              Timer(const Duration(seconds: 1), () {
                context.goNamed(RoutesNames.todosRoute);
              });
            },
          );
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
