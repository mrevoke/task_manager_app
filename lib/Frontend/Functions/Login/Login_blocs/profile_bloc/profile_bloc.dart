import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_manager/Core_Logic/models/auth_models/responses/profile_response/profile_response.dart';
import 'package:task_manager/Core_Logic/All_usecases/auth_usecases/profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUsecase profileUsecase;
  ProfileResponse? profileData;
  ProfileBloc({required this.profileUsecase})
      : super(const ProfileState.loading()) {
    on<ProfileEvent>((event, emit) async {
      await event.map(
        profile: (value) async {
          emit(const ProfileState.loading());
          final failureOrProfile = await profileUsecase.execute();
          failureOrProfile.when((profile) {
            profileData = profile;
            emit(ProfileState.success(profile: profile));
          }, (error) {
            emit(ProfileState.errror(message: error.message));
          });
        },
      );
    });
  }
}
