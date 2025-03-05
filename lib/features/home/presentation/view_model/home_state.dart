import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jagga_bazar/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:jagga_bazar/features/favourite/presentation/view/favourite_page.dart';
import 'package:jagga_bazar/features/post/presentation/view/post_view.dart';
import 'package:jagga_bazar/features/profile/presentation/view/Profile_view.dart';
import '../../../../app/di/di.dart';
import '../../../auth/presentation/view_model/profile/profile_bloc.dart';
import '../../../favourite/presentation/view_model/favourite_bloc.dart';
import '../../../post/presentation/view_model/post_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state (NO BuildContext needed)
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        BlocProvider(
          create: (context) => getIt<PostBloc>(), // ✅ Correct way
          child: const DashboardView(),
        ),
        BlocProvider(
          create: (context) => getIt<PostBloc>(), // ✅ Correct way
          child: const PostView(),
        ),
        const FavouritePage(),

        BlocProvider(
          create: (context) => getIt<ProfileBloc>(), // Use ProfileBloc here
          child: const ProfileView(),
        ),
      ],
    );
  }


  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
