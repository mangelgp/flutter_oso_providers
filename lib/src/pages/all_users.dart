import 'package:flutter/material.dart';
import 'package:providers_oso/src/bloc/users_bloc.dart';
import 'package:providers_oso/src/models/user_model.dart';
import 'package:providers_oso/src/providers/users_providers.dart';

class AllUsersPage extends StatefulWidget {

  @override
  _AllUsersPageState createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {

  final usersProviders = new UsersProviders();
  final usersBloc = new UsersBloc();

  @override
  Widget build(BuildContext context) {
    usersBloc.getAllUsers();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todos los usuarios'),
      ),
      body: buildStreamBuilder(), 
      // _buildBody(),
    );
  }

  Widget buildStreamBuilder() {
    return StreamBuilder(
      stream: usersBloc.userStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        
        final listUser = snapshot.data;

        if (listUser.length == 0) {
          return Center(child: Text('No hay registros en la base de datos'),);
        }

        return _listUsers(listUser);

      },
    );
  }

  // FutureBuilder<List<User>> _buildBody() {
  //   return FutureBuilder(
  //     future: usersProviders.getAllUsers(),
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
  //       if (snapshot.hasData) {
  //         return _listUsers(snapshot.data);
  //       } else {
  //         return Container(
  //           child: Center(child: CircularProgressIndicator(),),
  //         );
  //       }
  //     },
  //   );
  // }

  Widget _listUsers(List<User> users) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return _singleUser(context, users[index]);
      }, 
      separatorBuilder: (context, index) => Divider(), 
      itemCount: users.length
    );
  }

  Widget _singleUser(BuildContext context, User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: Icon(Icons.person),
      onTap: () {
        // _navigateToUserDet(context, user);
        Navigator.pushNamed(context, 'user_det', arguments: user);
      },
    );
  }
}