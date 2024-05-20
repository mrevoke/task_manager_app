import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager/Core_Logic/All_usecases/auth_usecases/profile_usecase.dart';
import 'package:task_manager/Core_Logic/All_usecases/auth_usecases/refresh_usecase.dart';
import 'package:task_manager/Core_Logic/All_usecases/task_usecases/get_todos_usescases.dart';
import 'package:task_manager/Frontend/Functions/Login/Login_blocs/profile_bloc/profile_bloc.dart';
import 'package:task_manager/Frontend/Functions/Loading_Screen/blocs/app_bloc/app_bloc.dart';
import 'package:task_manager/Frontend/Functions/Tasks/Tasks_blocs/add_update_bloc/addupdatetodo_bloc.dart';
import 'package:task_manager/Frontend/Functions/Tasks/Tasks_blocs/task_bloc/todo_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Backend/Connections/app_api.dart';
import '../Backend/Connections/dio.dart';
import '../Backend/Connections/dio_intercptr.dart';
import '../Backend/Connections/network_info.dart';
import '../Backend/repository/repository_implementer.dart';
import '../Core_Logic/repository/repository.dart';
import '../Core_Logic/All_usecases/auth_usecases/login_usecase.dart';
import '../Core_Logic/All_usecases/task_usecases/todos_usecases.dart';
import '../Frontend/Functions/Login/Login_blocs/auth_bloc/auth_bloc.dart';
import 'prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerFactory<SharedPreferences>(() => sharedPreferences);
  instance.registerFactory<AppPreferences>(() => AppPreferences(instance()));
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  instance.registerFactory<GeneralInterceptor>(() => GeneralInterceptor(
        appPreferences: instance<AppPreferences>(),
      ));
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementer(Connectivity()));
  instance.registerLazySingleton<Repository>(() => RepositoryImplementer(
      appServiceClient: instance(), networkInfo: instance()));
  instance.registerFactory<AppBloc>(
      () => AppBloc(appPreferences: instance<AppPreferences>()));
//Auth
//Usecases
  instance.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(repository: instance<Repository>()));
  instance.registerLazySingleton<RefreshUsecase>(
      () => RefreshUsecase(repository: instance<Repository>()));
  instance.registerLazySingleton<ProfileUsecase>(
      () => ProfileUsecase(repository: instance<Repository>()));
//Blocs
  instance.registerFactory<AuthBloc>(() => AuthBloc(
      loginUsecase: instance<LoginUsecase>(),
      refreshUsecase: instance<RefreshUsecase>()));
  instance.registerFactory<ProfileBloc>(
      () => ProfileBloc(profileUsecase: instance<ProfileUsecase>()));


//Todos

//Usecases
  instance.registerLazySingleton<GetTodosUsecase>(
      () => GetTodosUsecase(repository: instance<Repository>()));
  instance.registerLazySingleton<GetSingleTodoUsecase>(
      () => GetSingleTodoUsecase(repository: instance<Repository>()));
  instance.registerLazySingleton<GetRandomTodoUsecase>(
      () => GetRandomTodoUsecase(repository: instance<Repository>()));
  instance.registerLazySingleton<GetTodosByUserIdUsecase>(
      () => GetTodosByUserIdUsecase(repository: instance<Repository>()));

  instance.registerLazySingleton<DeleteTodoUsecase>(
      () => DeleteTodoUsecase(repository: instance<Repository>()));
  instance.registerLazySingleton<UpdateTodoUsecase>(
      () => UpdateTodoUsecase(repository: instance<Repository>()));
  instance.registerLazySingleton<AddTodoUsecase>(
      () => AddTodoUsecase(repository: instance<Repository>()));

//Blocs
  instance.registerFactory<TodoBloc>(() => TodoBloc(
        getTodosUsecase: instance<GetTodosUsecase>(),
        deleteTodoUsecase: instance<DeleteTodoUsecase>(),
      ));
  instance.registerFactory<AddupdatetodoBloc>(() => AddupdatetodoBloc(
        addTodoUsecase: instance<AddTodoUsecase>(),
        updateTodoUsecase: instance<UpdateTodoUsecase>(),
      ));
//
}
