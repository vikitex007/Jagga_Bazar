import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jagga_bazar/features/auth/domain/use_case/upload_image_usecase.dart';
import '../../../../../core/common/snackbar/my_snackbar.dart';
import '../../../domain/use_case/register_usecase.dart';
import '../../../domain/use_case/update_profile_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  final UploadImageUsecase _uploadImageUsecase;
  // final UpdateProfileUseCase _updateProfileUseCase;

  RegisterBloc({
    required UploadImageUsecase uploadImageUsecase,
    required RegisterUseCase registerUseCase,
    // required UpdateProfileUseCase updateProfileUseCase,
  })  :
        _uploadImageUsecase = uploadImageUsecase,
        _registerUseCase = registerUseCase,
        // _updateProfileUseCase = updateProfileUseCase,
        super(RegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);
    on<LoadImage>(_onLoadImage);
    // on<UpdateProfile>(_onUpdateProfile);

  }

  // void _onUpdateProfile(
  //     UpdateProfile event,
  //     Emitter<RegisterState> emit,
  //     ) async {
  //   emit(state.copyWith(isLoading: true));
  //
  //   // ✅ Wrap parameters in UpdateProfileParams
  //   final result = await _updateProfileUseCase.call(
  //     UpdateProfileParams(
  //       userId: event.userId,
  //       username: event.newUsername,
  //       password: event.newPassword,
  //     ),
  //   );


  //   result.fold(
  //         (l) {
  //       emit(state.copyWith(isLoading: false, isSuccess: false));
  //       showMySnackBar(
  //           context: event.context, message: l.message, color: Colors.red);
  //     },
  //         (r) {
  //       emit(state.copyWith(isLoading: false, isSuccess: true, isProfileUpdated: true));
  //       showMySnackBar(
  //           context: event.context, message: "Profile Updated Successfully");
  //     },
  //   );
  // }


  void _onRegisterEvent(
      RegisterUser event,
      Emitter<RegisterState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
      fullName: event.fullName,
      phone: event.phone,
      location: event.location,
      username: event.username,
      password: event.password,
      image: state.imageName,
    ));

    result.fold(
          (l) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
            context: event.context, message: l.message, color: Colors.red);
      },
          (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
      },
    );
  }
  void _onLoadImage(
      LoadImage event,
      Emitter<RegisterState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _uploadImageUsecase.call(
      UploadImageParams(file: event.file),
    );

    result.fold(
          (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
          (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }
}
