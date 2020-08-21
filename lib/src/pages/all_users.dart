import 'package:flutter/material.dart';
// import 'package:providers_oso/src/bloc/user_bloc.dart';
import 'package:providers_oso/src/models/user.dart';
import 'package:providers_oso/src/providers/providers.dart';

class AllUsersPage extends StatefulWidget {

  @override
  _AllUsersPageState createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  final comunicationService= new ComunicationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todos los usuarios'),
      ),
      body: 
      // StreamBuilder(
      //   stream: usersBloc.usersStream,
      //   builder: (BuildContext context,  AsyncSnapshot<List<User>> snapshot) {

      //     if (!snapshot.hasData) {
      //       return Center(child: CircularProgressIndicator(),);
      //     }
      //     final users = snapshot.data;
      //     if (users.length == 0) {
      //       return Center(child: CircularProgressIndicator(),);
      //     }
      //     return _listUsers(users);
      //   }
      // )
      
      FutureBuilder(
        future: comunicationService.getAllUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _listUsers(snapshot.data);
          } else {
            return Container(
              child: Center(child: CircularProgressIndicator(),),
            );
          }
        },
      ),
    );
  }

  Widget _listUsers(List<User> users) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return _sigleUser(context, users[index]);
      }, 
      separatorBuilder: (context, index) => Divider(), 
      itemCount: users.length
    );
  }

  Widget _sigleUser(BuildContext context, User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: Icon(Icons.person),
      onTap: () {
        // Navigator.pushNamed(context, 'user_det', arguments: user);
        _navigateToUserDet(context, user);
      },
    );
  }

  _navigateToUserDet(BuildContext context, User user) async {
    final result = await Navigator.pushNamed(context, 'user_det', arguments: user);
    if(result == true) {
      setState(() {
        
      });
    }
  }
}