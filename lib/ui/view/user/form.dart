import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_with_bloc_library/bloc/user_form/bloc.dart';
import 'package:flutter_crud_with_bloc_library/bloc/user_list/user_list_bloc.dart';
import 'package:flutter_crud_with_bloc_library/bloc/user_list/user_list_event.dart';
import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:flutter_crud_with_bloc_library/ui/shared/error_widget.dart';
import 'package:flutter_crud_with_bloc_library/ui/shared/loading_widget.dart';

class UserFormScreen extends StatefulWidget {
  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();

  UserListBloc userListBloc;

  UserFormBloc userFormBloc;

  @override
  Widget build(BuildContext context) {
    userListBloc = BlocProvider.of<UserListBloc>(context);
    userFormBloc = BlocProvider.of<UserFormBloc>(context);
    return WillPopScope(
      onWillPop: () async {
        userFormBloc.add(BackEvent());
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: BlocBuilder<UserFormBloc, UserFormState>(
          builder: (context, state) =>
              Text((state.user?.id == null ? 'Add' : 'Edit') + ' User'),
        )),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: BlocListener<UserFormBloc, UserFormState>(
                listenWhen: (previousState, state) {
                  return state is Success;
                },
                listener: (context, state) {
                  userListBloc.add(GetUsers());
                  Navigator.pop(context);
                },
                child: BlocBuilder<UserFormBloc, UserFormState>(
                    builder: (context, state) {
                  if (state is Loaded) {
                    User user = state.user?.id == null ? User() : state.user;
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Name',
                              ),
                              initialValue: user?.name ?? '',
                              onChanged: (value) {
                                user?.name = value;
                              },
                              validator: (value) {
                                if (value.length < 1) {
                                  return 'Name cannot be empty';
                                }
                                return null;
                              }),
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Username',
                              ),
                              initialValue: user?.username ?? '',
                              onChanged: (value) {
                                user?.username = value;
                              },
                              validator: (value) {
                                if (value.length < 1) {
                                  return 'Username cannot be empty';
                                }
                                return null;
                              }),
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                              ),
                              initialValue: user?.email ?? '',
                              onChanged: (value) {
                                user?.email = value;
                              },
                              validator: (value) {
                                if (value.length < 1) {
                                  return 'Email cannot be empty';
                                }
                                return null;
                              }),
                          RaisedButton(
                            child: Text('Submit'),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                userFormBloc.add(user?.id == null
                                    ? CreateUser(user: user)
                                    : UpdateUser(user: user));
                              }
                            },
                          )
                        ],
                      ),
                    );
                  }
                  if (state is Error) {
                    return error(state.message);
                  }
                  return loading();
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
