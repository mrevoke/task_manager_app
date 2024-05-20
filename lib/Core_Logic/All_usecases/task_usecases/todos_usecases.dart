// ignore_for_file: implementation_imports

import 'package:task_manager/Core_Logic/models/task_models/requests/create_request/create_request.dart';
import 'package:task_manager/Core_Logic/models/task_models/requests/update_request/update_request.dart';
import 'package:task_manager/fail_case_model/failure.dart';

import 'package:multiple_result/src/result.dart';

import '../../models/task_models/responses/todo_model.dart';
import '../../repository/repository.dart';
import '../base_usecases/base_usecase.dart';

class DeleteTodoUsecase extends BaseUseCase<int, TodoModel> {
  final Repository repository;

  DeleteTodoUsecase({required this.repository});

  @override
  Future<Result<TodoModel, FailureModel>> execute(int input) async {
    return await repository.deleteTodo(input);
  }
}

class UpdateTodoUsecase
    extends BaseUseCase<({int id, UpdateRequest updateRequest}), TodoModel> {
  final Repository repository;

  UpdateTodoUsecase({required this.repository});

  @override
  Future<Result<TodoModel, FailureModel>> execute(
      ({int id, UpdateRequest updateRequest}) input) async {
    return await repository.updateTodo(input.id, input.updateRequest);
  }
}

class AddTodoUsecase extends BaseUseCase<CreateRequest, TodoModel> {
  final Repository repository;

  AddTodoUsecase({required this.repository});

  @override
  Future<Result<TodoModel, FailureModel>> execute(CreateRequest input) async {
    return await repository.addTodo(input);
  }
}
