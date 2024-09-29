import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/app/pages/home_page/bloc/list_bloc.dart';
import 'package:task_app/app/pages/login_page/bloc/login_bloc.dart';
import 'package:task_app/app/pages/sign_up_page/bloc/sign_up_bloc.dart';
import 'package:task_app/app/pages/tasks_list_page/bloc/tasks_list_bloc.dart';
import 'package:task_app/data/services/auth/auth_service.dart';
import 'package:task_app/data/services/list/list_service.dart';
import 'package:task_app/data/services/list/list_service_interface.dart';
import 'package:task_app/data/services/task/task_service.dart';
import 'package:task_app/data/services/task/task_service_interface.dart';
import 'package:task_app/domain/repositories/list/list_repository.dart';
import 'package:task_app/domain/repositories/list/list_repository_interface.dart';
import 'package:task_app/domain/repositories/task/task_repository.dart';
import 'package:task_app/domain/repositories/task/task_repository_interface.dart';

GetIt locator = GetIt.I;
final talker = TalkerFlutter.init();
void setup() {
  setupTalker();
  //     repositories
  // list
  locator.registerLazySingleton<AbstractListService>(
    () => ListService(),
  );
  locator.registerLazySingleton<AbstractListRepository>(
    () => ListRepository(locator<AbstractListService>()),
  );
  // task
  locator.registerLazySingleton<AbstractTaskService>(
    () => TaskService(),
  );
  locator.registerLazySingleton<AbstractTaskRepository>(
    () => TaskRepository(locator<AbstractTaskService>()),
  );

  // bloc
  locator.registerLazySingleton<LoginBloc>(
    () => LoginBloc(AuthService()),
  );
  locator.registerLazySingleton<ListBloc>(
    () => ListBloc(
      GetIt.I.get<AbstractListRepository>(),
    ),
  );
  locator.registerLazySingleton<SignUpBloc>(
    () => SignUpBloc(AuthService()),
  );
  locator.registerLazySingleton<TasksListBloc>(
    () => TasksListBloc(GetIt.I.get<AbstractTaskRepository>()),
  );
}

void setupTalker() {
  locator.registerSingleton<Talker>(talker);
  GetIt.I<Talker>().debug('Talker started...');
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );
}
