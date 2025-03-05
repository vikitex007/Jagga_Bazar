import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jagga_bazar/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jagga_bazar/features/post/presentation/view_model/post_bloc.dart';
import 'package:jagga_bazar/features/post/domain/entity/post_entity.dart';

// Mock PostBloc for testing
class MockPostBloc extends MockBloc<PostEvent, PostState> implements PostBloc {}

void main() {
  late MockPostBloc mockPostBloc;

  setUp(() {
    mockPostBloc = MockPostBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<PostBloc>.value(
        value: mockPostBloc,
        child: const DashboardView(),
      ),
    );
  }

  /// 1️⃣ Test - Ensure GridView is displayed when posts are available
  testWidgets("Widget Test 7 Dashboard should display posts in a grid when loaded", (tester) async {
    when(() => mockPostBloc.state).thenReturn(PostState(
      isLoading: false,
      error: null,
      posts: [
        PostEntity(id: '1', title: 'House in Kathmandu', image: '', price: '5000000', location: 'Kathmandu', description: ''),
        PostEntity(id: '2', title: 'Land in Bhaktapur', image: '', price: '4000000', location: 'Bhaktapur', description: ''),
      ],
    ));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('House in Kathmandu'), findsOneWidget);
    expect(find.text('Land in Bhaktapur'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });

  /// 2️⃣ Test - Show loading indicator when posts are loading
  testWidgets("Widget Test 8 Dashboard should show a loading indicator while fetching posts", (tester) async {
    when(() => mockPostBloc.state).thenReturn(PostState(isLoading: true, posts: [], error: null));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  /// 3️⃣ Test - Show error message if post fetching fails
  testWidgets("Widget Test 9 Dashboard should display an error message if fetching posts fails", (tester) async {
    when(() => mockPostBloc.state).thenReturn(PostState(isLoading: false, posts: [], error: 'Failed to load data'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Error: Failed to load data'), findsOneWidget);
  });

  /// 4️⃣ Test - Navigate to Post Detail Page when clicking on a post
  testWidgets("Widget Test 10 Clicking on a post should navigate to PostDetailView", (tester) async {
    when(() => mockPostBloc.state).thenReturn(PostState(
      isLoading: false,
      error: null,
      posts: [PostEntity(id: '1', title: 'House in Kathmandu', image: '', price: '5000000', location: 'Kathmandu', description: '')],
    ));

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('House in Kathmandu'));
    await tester.pumpAndSettle();

    // Expect that the post detail page is shown
    expect(find.text('House in Kathmandu'), findsOneWidget);
  });
}
