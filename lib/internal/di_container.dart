import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/app/pages/home_page/bloc/list_bloc.dart';
import 'package:task_app/app/pages/login_page/bloc/login_bloc.dart';
import 'package:task_app/app/pages/sign_up_page/bloc/sign_up_bloc.dart';
import 'package:task_app/app/pages/tasks_list_page/bloc/tasks_list_bloc.dart';
import 'package:task_app/data/db/task/requests.dart';
import 'package:task_app/data/services/auth/auth_service.dart';
import 'package:task_app/domain/list/list_db.dart';

GetIt locator = GetIt.I;
final talker = TalkerFlutter.init();
void setup() {
  setupTalker();
  locator.registerLazySingleton<LoginBloc>(
    () => LoginBloc(AuthService()),
  );
  locator.registerLazySingleton<ListBloc>(
    () => ListBloc(ListDataRepository()),
  );
  locator.registerLazySingleton<SignUpBloc>(
    () => SignUpBloc(AuthService()),
  );
  locator.registerLazySingleton<TasksListBloc>(
    () => TasksListBloc(TaskRepository()),
  );
}

void setupTalker() {
  locator.registerSingleton<Talker>(talker);
  GetIt.I<Talker>().debug('Talker started...');
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
        printStateFullData: false, printEventFullData: false),
  );
}
