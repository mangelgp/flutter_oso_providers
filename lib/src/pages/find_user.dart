import 'package:flutter/material.dart';
import 'package:providers_oso/src/models/user_model.dart';
import 'package:providers_oso/src/providers/users_providers.dart';

class FindUser extends StatefulWidget {
  @override
  _FindUserState createState() => _FindUserState();
}

class _FindUserState extends State<FindUser> {

  final usersProviders = UsersProviders();

  TextEditingController _controller = TextEditingController();
  String _idUser = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Buscar Usuario'),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [

            TextField(
              controller: _controller,
              autofocus: true,
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                hintText: 'Introduzca el ID de Usuario',
                labelText: 'ID',
              ),
              onChanged: (valor) {
                setState(() {
                  _idUser = valor;
                  print(_idUser);
                });
              },
            ),

            SizedBox(height: 30.0,),

            FutureBuilder(
              future: usersProviders.getUserById(_idUser),
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                if (snapshot.hasData) {
                  return _createUserInfo(snapshot.data);
                } else {
                  return Center(child: Text('Este usuario no existe', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _createUserInfo(User user) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        setState(() {
          _idUser = '';
        });
        _controller.clear();
        Navigator.pushNamed(context, 'user_det', arguments: user);
      },
    );
  }
}