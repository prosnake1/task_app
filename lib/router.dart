import 'package:go_router/go_router.dart';
import 'package:task_app/pages/create_list_page/create_list_page.dart';
import 'package:task_app/pages/create_task_page/create_task_page.dart';
import 'package:task_app/pages/home_page/home_page.dart';
import 'package:task_app/pages/list_page/list_page.dart';
import 'package:task_app/pages/login_page/login_page.dart';
import 'package:task_app/pages/sign_up_page/sign_up_page.dart';

GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/login/sign-up',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(path: '/list', builder: (context, state) => const ListPage()),
    GoRoute(
      path: '/list/create-task',
      builder: (context, state) => const CreateTaskPage(),
    ),
    GoRoute(
      path: '/create-list',
      builder: (context, state) => const CreateList(),
    )
  ],
);
