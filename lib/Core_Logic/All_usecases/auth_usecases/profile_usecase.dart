import 'package:task_manager/Core_Logic/models/auth_models/responses/profile_response/profile_response.dart';
import 'package:task_manager/Core_Logic/All_usecases/base_usecases/base_usecase.dart';
import 'package:task_manager/fail_case_model/failure.dart';
// ignore: implementation_imports
import 'package:multiple_result/src/result.dart';

import '../../repository/repository.dart';

class ProfileUsecase extends BaseUseCaseEmptyInput<ProfileResponse> {
  final Repository repository;

  ProfileUsecase({required this.repository});

  @override
  Future<Result<ProfileResponse, FailureModel>> execute() async {
    return await repository.profile();
  }
}
