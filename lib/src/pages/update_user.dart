import 'package:flutter/material.dart';
import 'package:providers_oso/src/bloc/user_bloc.dart';
import 'package:providers_oso/src/models/user.dart';
import 'package:providers_oso/src/providers/providers.dart';

class UpdateUserPage extends StatefulWidget {
  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {

  final comService = ComunicationService();
  final usersBloc = UsersBloc();

  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {

    final User user = ModalRoute.of(context).settings.arguments;
    // _name = user.name;
    // _email = user.email;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Modificar'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        width: double.infinity,
        child: Column(
          children: [
            TextFormField(
              initialValue: user.name,
              // controller: _controllerName,
              autofocus: true,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                hintText: 'Introduzca su nombre completo',
                labelText: 'Nombre',
              ),
              onChanged: (valor) {
                setState(() {
                  // _alert = '';
                  _name = valor;
                  print(_name);
                  // watcher();
                });
              },
            ),

            SizedBox(height: 25.0,),

            TextFormField(
              initialValue: user.email,
              // controller: _controllerEmail,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                hintText: 'Introduzca su direccion de correo',
                labelText: 'Correo',
              ),
              onChanged: (valor) {
                setState(() {
                  // _alert = '';
                  _email = valor;
                  print(_email);
                  // watcher();
                });
              },
            ),

            SizedBox(height: 30.0,),

            FlatButton(
              child: Text('Actualizar', style: TextStyle(color: Colors.white),),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              color: Colors.blue,
              onPressed: () async{
                // if (_ready) {
                //   var updateUser = await comService.updateUser(user: user);
                //   print(updateUser.name);
                //   Navigator.pop(context);
                // }
                // else _showAlert();

                var updateUser = await comService.updateUser(
                  email: _email,
                  name: _name,
                  id: user.idUser.toString()
                );
                print(updateUser);
                Navigator.pop(context, true);
              }, 
            )
          ],
        ),
      ),
    );
  }

  // void _showAlert() {
  //   setState(() {
  //     _alert = '*Porfavor llene todos los campos*';
  //   });
  // }

  // void watcher(){
  //   if (_name != '' && _email != '') {
  //     setState(() {
  //       _ready = true;
  //     });
  //   } else {
  //     _ready = false;
  //   }
  // }
}