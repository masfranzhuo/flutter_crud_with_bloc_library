import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_with_bloc_library/bloc/user_form/user_form_bloc.dart';
import 'package:flutter_crud_with_bloc_library/bloc/user_form/user_form_event.dart';
import 'package:flutter_crud_with_bloc_library/bloc/user_list/bloc.dart';
import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:flutter_crud_with_bloc_library/ui/user/form.dart';
import 'package:flutter_crud_with_bloc_library/widgets/loading_widget.dart';
import 'package:flutter_crud_with_bloc_library/widgets/no_data_widget.dart';

class UserListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  UserListBloc userListBloc;
  UserFormBloc userFormBloc;

  TextEditingController _searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    userListBloc = BlocProvider.of<UserListBloc>(context);
    userFormBloc = BlocProvider.of<UserFormBloc>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            autocorrect: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  userListBloc.add(GetUsers(query: _searchController.text));
                },
              ),
              hintText: 'Search...',
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<UserFormScreen>(
                  builder: (context) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<UserFormBloc>.value(
                            value: userFormBloc..add(GetUser())),
                        BlocProvider<UserListBloc>.value(value: userListBloc),
                      ],
                      child: UserFormScreen(),
                    );
                  },
                ),
              );
            }),
        body: Center(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              userListBloc.add(GetUsers());
            },
            child: BlocBuilder<UserListBloc, UserListState>(
                builder: (context, state) {
              if (state is Loaded) {
                return Container(
                    child: (state.users.isNotEmpty
                        ? ListView.builder(
                            itemCount: state.users.length,
                            itemBuilder: (context, index) {
                              User user = state.users[index];
                              return _userCard(user, context);
                            },
                          )
                        : NoData()));
              }
              return LoadingWidget();
            }),
          ),
        ));
  }

  Card _userCard(User user, BuildContext context) {
    return Card(
        child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(padding: EdgeInsets.all(10), child: Text(user.name)),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<UserFormScreen>(
                      builder: (context) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider<UserFormBloc>.value(
                                value: userFormBloc..add(GetUser(user: user))),
                            BlocProvider<UserListBloc>.value(
                                value: userListBloc),
                          ],
                          child: UserFormScreen(),
                        );
                      },
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  userListBloc.add(DeleteUser(user));
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text(user.name + ' deleted')));
                },
              )
            ],
          ),
        ],
      ),
    ));
  }
}
