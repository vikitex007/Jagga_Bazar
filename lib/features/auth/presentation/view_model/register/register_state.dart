part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;
  // final bool isProfileUpdated;

  const RegisterState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
    // this.isProfileUpdated = false,
  });

  // ✅ Corrected `initial` constructor
  const RegisterState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null;
        // isProfileUpdated = false; // ✅ Fixed syntax error

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
    // bool? isProfileUpdated, // ✅ Add isProfileUpdated to copyWith
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
      // isProfileUpdated: isProfileUpdated ?? this.isProfileUpdated, // ✅ Include this
    );
  }

  @override
  List<Object?> get props => [isSuccess, isLoading, imageName]; // ✅ Add isProfileUpdated to props
}
