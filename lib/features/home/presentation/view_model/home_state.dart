import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jagga_bazar/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:jagga_bazar/features/post/presentation/view/post_view.dart';
import 'package:jagga_bazar/features/post/presentation/view_model/post_bloc.dart';
import '../../../../app/di/di.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        // Dashboard view wrapped in BlocProvider with PostBloc
        BlocProvider(
          create: (context) => getIt<PostBloc>(),  // Providing PostBloc here
          child: DashboardView(),
        ),

        // Post view wrapped in BlocProvider with PostBloc
        BlocProvider(
          create: (context) => getIt<PostBloc>(),
          child: PostView(),
        ),
        // Placeholder views for other tabs
        const Center(
          child: Text('Favourite'),
        ),
        const Center(
          child: Text('Account'),
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
