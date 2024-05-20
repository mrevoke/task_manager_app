import 'package:go_router/go_router.dart';
import 'package:task_manager/Frontend/Functions/Tasks/views/Task_view.dart';
import '../Functions/Login/views/login_view.dart';
import '../Functions/Loading_Screen/load_view.dart';

class RoutesNames {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String todosRoute = '/todos';
}

class RoutesPaths {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String todosRoute = '/todos';
}

class AppRouter {
  static final router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: RoutesPaths.splashRoute,
      routes: [
        GoRoute(
          name: RoutesNames.splashRoute,
          path: RoutesPaths.splashRoute,
          builder: (context, state) => const SplashView(),
        ),
        GoRoute(
          name: RoutesNames.loginRoute,
          path: RoutesPaths.loginRoute,
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          name: RoutesNames.todosRoute,
          path: RoutesPaths.todosRoute,
          builder: (context, state) => const TodosView(),
        ),
      ]);
}
