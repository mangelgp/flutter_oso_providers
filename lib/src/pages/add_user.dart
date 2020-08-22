import 'package:flutter/material.dart';
import 'package:providers_oso/src/models/error_user.dart';
import 'package:providers_oso/src/models/user.dart';
import 'package:providers_oso/src/providers/providers.dart';

class NewUserPage extends StatefulWidget {
  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {

  final comunicationService= new ComunicationService();

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  TextEditingController _controllerPassConfirm = TextEditingController();

  String _name                 = '';
  String _email                = '';
  String _password             = '';
  String _passwordConfirmation = '';
  String _alert                = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registro de usuario'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: _controllerName,
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

                TextField(
                  controller: _controllerEmail,
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

                SizedBox(height: 25.0,),

                TextField(
                  controller: _controllerPass,
                  obscureText: true,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    hintText: 'Introduzca su clave',
                    labelText: 'Clave',
                  ),
                  onChanged: (valor) {
                    setState(() {
                      _password = valor;
                      print(_password);
                    });
                  },
                ),

                SizedBox(height: 25.0,),

                TextField(
                  controller: _controllerPassConfirm,
                  obscureText: true,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    hintText: 'Confirme su clave',
                    labelText: 'Confirmacion',
                  ),
                  onChanged: (valor) {
                    setState(() {
                      _passwordConfirmation = valor;
                      print(_passwordConfirmation);
                    });
                  },
                ),

                SizedBox(height: 20.0,),

                Center(child: Text(_alert, style: TextStyle(color: Colors.red),)),

                SizedBox(height: 20.0,),

                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  color: Theme.of(context).primaryColor,
                  child: Text('Agregar', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    _addNewUser(context);
                  }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _addNewUser(BuildContext context) async {

    var response = await comunicationService.addNewUser(
      nombre           : _name,
      correo           : _email,
      clave            : _password,
      claveConfirmation: _passwordConfirmation
    );

    if (response is User) {

      _controllerName.clear();
      _controllerEmail.clear();
      _controllerPass.clear();
      _controllerPassConfirm.clear();
      setState(() {});

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.done, size: 35.0, color: Colors.green,),
          content: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black,),
              children: [
                TextSpan(text: "Usuario creado exitosamente!\n"),
                TextSpan(text: 'ID de Usuario: ${response.idUser}', style: TextStyle(fontWeight: FontWeight.w500)),
              ]
            ),
            textAlign: TextAlign.center,
          ),
        ),
        barrierDismissible: true,
      );

    } else if (response is ErrorUser){
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.warning, size: 35.0, color: Colors.red),
          content: Text('error: ${response.name}, ${response.email}, ${response.password}'),
        ),
        barrierDismissible: true,
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.warning, size: 35.0, color: Colors.red),
          content: Text('error: $response'),
        ),
        barrierDismissible: true,
      );
    }
  }
}