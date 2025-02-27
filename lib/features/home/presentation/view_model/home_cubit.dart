import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/di/di.dart';
import '../../../auth/presentation/view/login_view.dart';
import '../../../auth/presentation/view_model/login/login_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial()); // ✅ No context needed

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void logout(BuildContext context) {
    // print("Logout function called");

    // Save a stable navigator reference
    final navigator = Navigator.of(context);

    // Show logout message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logging out...')),
    );

    Future.delayed(const Duration(seconds: 2), () {
      // print("Attempting navigation to LoginView...");

      // Use the stored navigator reference
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<LoginBloc>(),
            child: const LoginView(),
          ),
        ),
      );
    });
  }




}
