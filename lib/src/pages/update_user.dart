import 'package:flutter/material.dart';
import 'package:providers_oso/src/models/user_model.dart';
import 'package:providers_oso/src/providers/users_providers.dart';


class UpdateUserPage extends StatefulWidget {
  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {

  final comService = UsersProviders();

  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {

    final User user = ModalRoute.of(context).settings.arguments;

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
                  _name = valor;
                  print(_name);
                });
              },
            ),

            SizedBox(height: 25.0,),

            TextFormField(
              initialValue: user.email,
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
                  _email = valor;
                  print(_email);
                });
              },
            ),

            SizedBox(height: 30.0,),

            FlatButton(
              child: Text('Actualizar', style: TextStyle(color: Colors.white),),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              color: Colors.blue,
              onPressed: () async{
                var updateUser = await comService.updateUser(
                  email: _email,
                  name: _name,
                  id: user.id.toString()
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
}