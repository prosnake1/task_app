import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/app/pages/home_page/bloc/list_bloc.dart';
import 'package:task_app/app/pages/tasks_list_page/bloc/tasks_list_bloc.dart';

GetIt locator = GetIt.I;
final talker = TalkerFlutter.init();
void setup() {
  setupTalker();
  locator.registerLazySingleton<ListBloc>(
    () => ListBloc(),
  );
  locator.registerLazySingleton<TasksListBloc>(
    () => TasksListBloc(),
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
