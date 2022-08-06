import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_updated/layout/new_home_layout.dart';
import 'package:todo_updated/shared/bloc_observer.dart';




void main() {
  BlocOverrides.runZoned(
        () {
      // Use cubits...
      runApp( MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new_home_layout(),
    );
  }
}
