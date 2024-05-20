import 'package:dio/dio.dart';
import 'package:task_manager/Core_Logic/models/auth_models/requests/refresh_token/refresh_request.dart';
import 'package:task_manager/Core_Logic/models/auth_models/responses/profile_response/profile_response.dart';
import 'package:task_manager/Core_Logic/models/task_models/requests/create_request/create_request.dart';
import 'package:task_manager/Core_Logic/models/task_models/requests/pagination_request/pagination.dart';
import 'package:task_manager/Core_Logic/models/task_models/requests/update_request/update_request.dart';
import 'package:task_manager/Core_Logic/models/task_models/responses/todo_model.dart';
import 'package:task_manager/Frontend/Start/Start_view.dart';
import 'package:task_manager/fail_case_model/failure.dart';
// ignore: implementation_imports
import 'package:multiple_result/src/result.dart';

import '../../Core_Logic/models/auth_models/requests/login/login_request.dart';
import '../../Core_Logic/models/auth_models/responses/login_response/login_response.dart';
import '../../Core_Logic/repository/repository.dart';
import '../Connections/app_api.dart';
import '../Connections/network_info.dart';

class RepositoryImplementer extends Repository {
  final AppServiceClient appServiceClient;
  final NetworkInfo networkInfo;

  RepositoryImplementer(
      {required this.appServiceClient, required this.networkInfo});

//------------------Auth---------------------------
  @override
  Future<Result<LoginResponse, FailureModel>> login(
      LoginRequest loginRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await appServiceClient.login(loginRequest);
        if (response.response.statusCode == 200) {
          return Success(response.data);
        } else {
          return Error(FailureModel.fromJson(response.response.data));
        }
      } on DioException catch (e) {
        return Error(FailureModel.fromJson(e.response?.data ?? defaultError));
      }
    } else {
      return Error(FailureModel(message: AppStrings().noInternetError));
    }
  }

  @override
  Future<Result<ProfileResponse, FailureModel>> profile() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await appServiceClient.profile();
        if (response.response.statusCode == 200) {
          return Success(response.data);
        } else {
          return Error(FailureModel.fromJson(response.response.data));
        }
      } on DioException catch (e) {
        return Error(FailureModel.fromJson(e.response?.data ?? defaultError));
      }
    } else {
      return Error(FailureModel(message: AppStrings().noInternetError));
    }
  }

  @override
  Future<Result<LoginResponse, FailureModel>> refreshToken(
      RefreshRequest refreshRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await appServiceClient.refreshToken(refreshRequest);
        if (response.response.statusCode == 200) {
          return Success(response.data);
        } else {
          return Error(FailureModel.fromJson(response.response.data));
        }
      } on DioException catch (e) {
        return Error(FailureModel.fromJson(e.response?.data ?? defaultError));
      }
    } else {
      return Error(FailureModel(message: AppStrings().noInternetError));
    }
  }

//-------------------------------------
//--------------------Todos------------
  @override
  Future<Result<TodosModel, FailureModel>> todos(Pagination pagination) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await appServiceClient.todos(
            skip: pagination.skip, limit: pagination.limit);
        if (response.response.statusCode == 200) {
          return Success(response.data);
        } else {
          return Error(FailureModel.fromJson(response.response.data));
        }
      } on DioException catch (e) {
        return Error(FailureModel.fromJson(e.response?.data ?? defaultError));
      }
    } else {
      return Error(FailureModel(message: AppStrings().noInternetError));
    }
  }

  @override
  Future<Result<TodoModel, FailureModel>> randomTodo() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await appServiceClient.randomTodo();
        if (response.response.statusCode == 200) {
          return Success(response.data);
        } else {
          return Error(FailureModel.fromJson(response.response.data));
        }
      } on DioException catch (e) {
        return Error(FailureModel.fromJson(e.response?.data ?? defaultError));
      }
    } else {
      return Error(FailureModel(message: AppStrings().noInternetError));
    }
  }

  @override
  Future<Result<TodoModel, FailureModel>> singleTodo(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await appServiceClient.singleTodo(id: id);
        if (response.response.statusCode == 200) {
          return Success(response.data);
        } else {
          return Error(FailureModel.fromJson(response.response.data));
        }
      } on DioException catch (e) {
        return Error(FailureModel.fromJson(e.response?.data ?? defaultError));
      }
    } else {
      return Error(FailureModel(message: AppStrings().noInternetError));
    }
  }

  @override
  Future<Result<TodosModel, FailureModel>> todosByUserIdEndPoint(
      int userId, Pagination pagination) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await appServiceClient.todosByUserIdEndPoint(
            id: userId, skip: pagination.skip, limit: pagination.limit);
        if (response.response.statusCode == 200) {
          // Filter todos by currentUserId
          final filteredTodos = response.data.todos
              .where((todo) => todo.userId == userId)
              .toList();
          return Success(TodosModel(todos: filteredTodos));
        } else {
          return Error(FailureModel.fromJson(response.response.data));
        }
      } on DioException catch (e) {
        return Error(FailureModel.fromJson(e.response?.data ?? defaultError));
      }
    } else {
      return Error(FailureModel(message: AppStrings().noInternetError));
    }
  }

  @override
  Future<Result<TodoModel, FailureModel>> addTodo(CreateRequest request) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await appServiceClient.addTodo(request);
        if (response.response.statusCode == 200) {
          return Success(response.data);
        } else {
          return Error(FailureModel.fromJson(response.response.data));
        }
      } on DioException catch (e) {
        return Error(FailureModel.fromJson(e.response?.data ?? defaultError));
      }
    } else {
      return Error(FailureModel(message: AppStrings().noInternetError));
    }
  }

  @override
  Future<Result<TodoModel, FailureModel>> deleteTodo(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await appServiceClient.deleteTodo(id: id);
        if (response.response.statusCode == 200) {
          return Success(response.data);
        } else {
          return Error(FailureModel.fromJson(response.response.data));
        }
      } on DioException catch (e) {
        return Error(FailureModel.fromJson(e.response?.data ?? defaultError));
      }
    } else {
      return Error(FailureModel(message: AppStrings().noInternetError));
    }
  }

  @override
  Future<Result<TodoModel, FailureModel>> updateTodo(
      int id, UpdateRequest request) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await appServiceClient.updateTodo(id: id, request: request);
        if (response.response.statusCode == 200) {
          return Success(response.data);
        } else {
          return Error(FailureModel.fromJson(response.response.data));
        }
      } on DioException catch (e) {
        return Error(FailureModel.fromJson(e.response?.data ?? defaultError));
      }
    } else {
      return Error(FailureModel(message: AppStrings().noInternetError));
    }
  }
//-------------------------------------
}
