import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/app/app.dart';
import 'package:task_app/domain/di/di_container.dart';

void main() async {
  runZonedGuarded(
    () async {
      setup();
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      FlutterError.onError = (details) =>
          GetIt.I<Talker>().handle(details.exception, details.stack);
      runApp(const MyApp());
    },
    (error, stack) {
      GetIt.I<Talker>().handle(error, stack);
    },
  );
}
