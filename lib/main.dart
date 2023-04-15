import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_with_bloc_library/bloc/bloc_delegate.dart';
import 'package:flutter_crud_with_bloc_library/bloc/user_form/user_form_bloc.dart';
import 'package:flutter_crud_with_bloc_library/bloc/user_list/bloc.dart';
import 'package:flutter_crud_with_bloc_library/ui/view/user/list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: MultiBlocProvider(providers: [
        BlocProvider<UserListBloc>(
          create: (context) => UserListBloc()..add(GetUsers()),
        ),
        BlocProvider<UserFormBloc>(
          create: (context) => UserFormBloc(),
        ),
      ], child: UserListScreen()),
    );
  }
}
