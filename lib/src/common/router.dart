import 'package:go_router/go_router.dart';
import 'package:swipe_transfer_2/src/features/home/views/home_view.dart';
import 'package:swipe_transfer_2/src/features/home/views/station_editor_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeView(),
      routes: [
        GoRoute(
          path: '/edit',
          name: 'edit',
          builder: (context, state) => const StationEditorView(),
        ),
      ],
    ),
  ],
);
