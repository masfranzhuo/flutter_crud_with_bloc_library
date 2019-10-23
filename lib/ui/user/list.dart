import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_with_bloc_library/bloc/user_bloc.dart';
import 'package:flutter_crud_with_bloc_library/model/user_model.dart';
import 'package:flutter_crud_with_bloc_library/ui/user/detail.dart';
import 'package:flutter_crud_with_bloc_library/ui/user/form.dart';
import 'package:flutter_crud_with_bloc_library/widgets/loading_widget.dart';
import 'package:flutter_crud_with_bloc_library/widgets/no_data_widget.dart';

class UserListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  UserBloc userBloc;

  TextEditingController _searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
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
                  userBloc.add(UserEvent(
                      event: UserBlocEvent.LIST,
                      query: _searchController.text));
                },
              ),
              hintText: 'Search...',
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              userBloc.add(UserEvent(event: UserBlocEvent.READ, user: User()));
              Navigator.of(context).push(
                MaterialPageRoute<UserFormScreen>(
                  builder: (context) {
                    return BlocProvider.value(
                      value: userBloc,
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
              userBloc.add(UserEvent(event: UserBlocEvent.LIST));
            },
            child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              if (state is UninitializedUserState) {
                userBloc.add(UserEvent(event: UserBlocEvent.LIST));
                return Loading();
              } else {
                return Container(
                    child: (state.users.length != 0
                        ? ListView.builder(
                            itemCount: state.users.length,
                            itemBuilder: (context, index) {
                              User user = state.users[index];
                              return _userCard(user, context);
                            },
                          )
                        : NoData()));
              }
            }),
          ),
        ));
  }

  Card _userCard(User user, BuildContext context) {
    return Card(
        child: GestureDetector(
      onTap: () {
        userBloc.add(UserEvent(event: UserBlocEvent.READ, user: user));
        Navigator.of(context).push(
          MaterialPageRoute<UserDetailScreen>(
            builder: (context) {
              return BlocProvider.value(
                value: userBloc,
                child: UserDetailScreen(),
              );
            },
          ),
        );
      },
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(padding: EdgeInsets.all(10), child: Text(user.name)),
          Text(user.id.toString()),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              userBloc.add(UserEvent(event: UserBlocEvent.DELETE, user: user));
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text(user.name + ' deleted')));
            },
          )
        ],
      )),
    ));
  }
}
