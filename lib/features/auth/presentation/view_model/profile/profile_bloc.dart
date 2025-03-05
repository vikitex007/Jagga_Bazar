import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/use_case/get_profile_usecase.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileBloc({required this.updateProfileUseCase}) : super(ProfileInitial()) {
    // on<GetProfileEvent>((event, emit) async {
    //   emit(ProfileLoading());
    //   // final result = await getProfileUseCase();
    //   result.fold(
    //         (failure) => emit(ProfileError(_mapFailureToMessage(failure))),
    //         (user) => emit(ProfileLoaded(user)),
    //   );
    // });

    on<UpdateProfileEvent>((event, emit) async {
      emit(ProfileUpdating());
      final result = await updateProfileUseCase(event.user);
      result.fold(
            (failure) => emit(ProfileUpdateFailure(_mapFailureToMessage(failure))),
            (user) => emit(ProfileUpdateSuccess(user)),
      );
    });

  }

  String _mapFailureToMessage(Failure failure) {
    return failure is ApiFailure ? failure.message : 'Unexpected error';
  }


}
