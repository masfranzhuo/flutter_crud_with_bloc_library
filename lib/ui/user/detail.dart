import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_with_bloc_library/bloc/user_bloc.dart';
import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:flutter_crud_with_bloc_library/widgets/no_data_widget.dart';

class UserDetailScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('User Details'),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed('/user-form');
            }),
        body: Center(
          child: SingleChildScrollView(
            child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              if (state.user != null) {
                User user = state.user;
                return Column(
                  children: <Widget>[
                    Text(user.name),
                    Text(user.username),
                    Text(user.email),
                  ],
                );
              }
              return NoData();
            }),
          ),
        ));
  }
}
