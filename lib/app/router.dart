import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/app/pages/pages.dart';

GoRouter router = GoRouter(
  observers: [TalkerRouteObserver(GetIt.I.get<Talker>())],
  initialLocation: (FirebaseAuth.instance.currentUser == null) ? '/login' : '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'create-list',
          builder: (context, state) => const CreateList(),
        ),
        GoRoute(
          path: ':title',
          builder: (context, state) {
            final title = state.extra as String;
            return ListPage(
              title: title,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/list/create-task',
      builder: (context, state) => const CreateTaskPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
      routes: [
        GoRoute(
          path: 'sign-up',
          builder: (context, state) => const SignUpPage(),
        ),
      ],
    ),
  ],
);
