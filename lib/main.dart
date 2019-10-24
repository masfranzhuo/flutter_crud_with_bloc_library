import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_with_bloc_library/bloc/bloc_delegate.dart';
import 'package:flutter_crud_with_bloc_library/bloc/user_form/user_form_bloc.dart';
import 'package:flutter_crud_with_bloc_library/bloc/user_list/bloc.dart';
import 'package:flutter_crud_with_bloc_library/ui/user/list.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(brightness: Brightness.dark),
      home: MultiBlocProvider(providers: [
        BlocProvider<UserListBloc>(
          builder: (context) => UserListBloc()..add(GetUsers()),
        ),
        BlocProvider<UserFormBloc>(
          builder: (context) => UserFormBloc(),
        ),
      ], child: UserListScreen()),
    );
  }
}
