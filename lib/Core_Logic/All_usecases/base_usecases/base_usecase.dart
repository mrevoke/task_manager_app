import 'package:task_manager/fail_case_model/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class BaseUseCase<In, Out> {
  Future<Result<Out, FailureModel>> execute(In input);
}

abstract class BaseUseCaseEmptyInput<Out> {
  Future<Result<Out, FailureModel>> execute();
}
