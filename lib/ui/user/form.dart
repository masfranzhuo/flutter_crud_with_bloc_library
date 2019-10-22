import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_with_bloc_library/bloc/user_bloc.dart';
import 'package:flutter_crud_with_bloc_library/model/user_model.dart';

class UserFormScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      User user = state.user != null ? state.user : User();
      _nameController.value = _nameController.value.copyWith(text: user.name);
      _usernameController.value = _usernameController.value.copyWith(text: user.username);
      _emailController.value = _emailController.value.copyWith(text: user.email);
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text((user.id == null ? 'Add' : 'Edit') + ' User'),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        onChanged: (value) {
                          user.name = value;
                        },
                        validator: (value) {
                          if (value.length < 1) {
                            return 'Name cannot be empty';
                          }
                          return null;
                        }),
                    TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                        onChanged: (value) {
                          user.username = value;
                        },
                        validator: (value) {
                          if (value.length < 1) {
                            return 'Username cannot be empty';
                          }
                          return null;
                        }),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        onChanged: (value) {
                          user.email = value;
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
                          userBloc.add(UserEvent(event: user.id == null ? UserBlocEvent.CREATE : UserBlocEvent.UPDATE, user: user));
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
