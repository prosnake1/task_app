import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/app/pages/pages.dart';

GoRouter router = GoRouter(
  observers: [TalkerRouteObserver(GetIt.I.get<Talker>())],
  initialLocation:
      (FirebaseAuth.instance.currentUser == null) ? '/login' : '/home',
  routes: <RouteBase>[
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'task',
          name: 'noti_task',
          builder: (context, state) {
            return TaskPage(
              name: state.uri.queryParameters['name'].toString(),
              desc: state.uri.queryParameters['desc'].toString(),
            );
          },
        ),
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
          routes: [
            GoRoute(
              path: 'create-task',
              builder: (context, state) {
                final name = state.extra as String;
                return CreateTaskPage(
                  listId: name,
                );
              },
            ),
            GoRoute(
              path: 'task/:name',
              name: 'task',
              builder: (context, state) {
                return TaskPage(
                  name: state.pathParameters['name'].toString(),
                  desc: state.uri.queryParameters['desc'].toString(),
                );
              },
            )
          ],
        ),
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
