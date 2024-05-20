import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/Frontend/Functions/Loading_Screen/blocs/app_bloc/app_bloc.dart';
import 'package:task_manager/Frontend/Functions/Login/Login_blocs/profile_bloc/profile_bloc.dart';
import 'package:task_manager/Frontend/Functions/Tasks/Tasks_blocs/task_bloc/todo_bloc.dart';
import 'package:task_manager/Frontend/Util/routes.dart';
import 'prefs.dart';
import 'depndency_injection.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<AppBloc>()),
        BlocProvider(
          create: (context) => instance<ProfileBloc>()
            ..add(
              const ProfileEvent.profile(),
            ),
          lazy: false,
        ),
        BlocProvider(
            create: (context) =>
                instance<TodoBloc>()..add(const TodoEvent.getTodos())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) => ThemeProvider(
          initTheme: ThemeData.light(),
          builder: (p0, theme) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Task',
            themeMode: ThemeMode.light,
            theme: theme,
            routerConfig: AppRouter.router,
          ),
        ),
      ),
    );
  }
}
