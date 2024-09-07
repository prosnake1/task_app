import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/app/pages/pages.dart';

GoRouter router = GoRouter(
  initialLocation: (FirebaseAuth.instance.currentUser == null) ? '/login' : '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'list/:title',
          builder: (context, state) {
            final title = state.extra as String;
            return ListPage(
              title: title,
            );
          },
          routes: [
            GoRoute(
              path: 'create-task',
              builder: (context, state) => const CreateTaskPage(),
            ),
          ],
        ),
        GoRoute(
          path: 'create-list',
          builder: (context, state) => const CreateList(),
        )
      ],
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
