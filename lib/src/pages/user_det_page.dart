import 'package:flutter/material.dart';
import 'package:providers_oso/src/models/user_model.dart';
import 'package:providers_oso/src/providers/users_providers.dart';

class UserDetPage extends StatefulWidget {
  @override
  _UserDetPageState createState() => _UserDetPageState();
}

class _UserDetPageState extends State<UserDetPage> {

  final usersProviders = UsersProviders();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final User user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context, true);}),
        centerTitle: true,
        title: Text('Detalle de usuario'),
      ),
      body: FutureBuilder(
        future: usersProviders.getUserById(user.id.toString()),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return buildBody(snapshot.data, context);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ), 
    );
  }

  Container buildBody(User user, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: double.infinity,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Nombre'),
            subtitle: Text(user.name),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Correo'),
            subtitle: Text(user.email),
          ),

          SizedBox(
            width: 180.0,
            height: 40.0,
            child: OutlineButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Text('Modificar informacion'),
              onPressed: () {
                // Navigator.pushNamed(context, 'update_user', arguments: user);
                _navigateToUpdate(user);
              },
              
            ),
          ),

          Expanded(
            child: Container(),
          ),

          SizedBox(
            width: 180.0,
            height: 40.0,
            child: OutlineButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {},
              child: Text('Restaurar clave'),
            ),
          ),

          SizedBox(height: 20.0,),

          deleteUser(context, user),
        ],
      ),
    );
  }

  SizedBox deleteUser(BuildContext context, User user) {
    return SizedBox(
      height: 40.0,
      width: 180.0,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: Colors.white10
        ),
        child: OutlineButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: () {
            // _confirmDelete(user);

            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Icon(Icons.warning, color: Colors.red, size: 30.0,),
                  content: Text('Desea Eliminar este Usuario?', textAlign: TextAlign.center,),
                  // actionsPadding: ,
                  actions: [
                    FlatButton(
                      onPressed: () => Navigator.pop(context, true), // passing false
                      child: Text('Eliminar'),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.pop(context, false), // passing true
                      child: Text('Cancelar'),
                    ),
                  ],
                );
              }).then((exit) async {
              if (exit == null) return;

              if (exit) {
                var response = await usersProviders.deleteUserById(user.id.toString());
                if (response != null) {
                Navigator.pop(context);    
                } else {
                  _mostrarSnackbar('Imposible eliminar este usuario');
                }
              } else {
                // user pressed No button
              }
            });
          },
          child: Text('Eliminar usuario', style: TextStyle(color: Colors.red),),
        ),
      ),
    );
  }

  void _mostrarSnackbar(String text) {
    final snackbar = SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 2200),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _navigateToUpdate(User user) async {
    final result = await Navigator.pushNamed(context, 'update_user', arguments: user);
    if(result == true) {
      setState(() {});
    }
  }


}