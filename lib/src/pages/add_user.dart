import 'package:flutter/material.dart';
import 'package:providers_oso/src/models/error_user_model.dart';
import 'package:providers_oso/src/models/user_model.dart';
import 'package:providers_oso/src/providers/users_providers.dart';

class NewUserPage extends StatefulWidget {
  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {

  final usersProviders = new UsersProviders();

  IconData _visiblePass = Icons.visibility;
  IconData _visiblePassConfirm = Icons.visibility;
  bool _hintPass = true;
  bool _hintPassConfirm = true;
  bool _isLoading = false;

  final _controllerName        = TextEditingController();
  final _controllerEmail       = TextEditingController();
  final _controllerPass        = TextEditingController();
  final _controllerPassConfirm = TextEditingController();

  @override
  void dispose() { 
    _controllerName.dispose();
    _controllerEmail.dispose();
    _controllerPass.dispose();
    _controllerPassConfirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registro de usuario'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _campoNombre(),
          SizedBox(height: 25.0,),
          _campoEmail(),
          SizedBox(height: 25.0,),
          _campoClave(),
          SizedBox(height: 25.0,),
          _campoClaveConfirm(),
          SizedBox(height: 40.0,),
          _addUserButton(context),
        ],
      ),
    );
  }

  TextField _campoNombre() {
    return TextField(
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
          print(_controllerName.text);
        });
      },
    );
  }

  TextField _campoEmail() {
    return TextField(
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
          print(_controllerEmail.text);
        });
      },
    );
  }

  TextField _campoClave() {
    return TextField(
      controller: _controllerPass,
      obscureText: _hintPass,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Introduzca su clave',
        labelText: 'Clave',
        suffixIcon: IconButton(
          icon: Icon(_visiblePass),
          onPressed: () {
            if ( _hintPass == true ) {
              _hintPass = false;
              _visiblePass = Icons.visibility_off;
              setState(() {});
            } else {
              _hintPass = true;
              _visiblePass = Icons.visibility;
              setState(() {});
            }
          }
        ),
      ),
      onChanged: (valor) {
        setState(() {
          print(_controllerPass.text);
        });
      },
    );
  }

  TextField _campoClaveConfirm() {
    return TextField(
      controller: _controllerPassConfirm,
      obscureText: _hintPassConfirm,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Confirme su clave',
        labelText: 'Confirmacion',
        suffixIcon: IconButton(
          icon: Icon(_visiblePassConfirm),
          onPressed: () {
            if ( _hintPassConfirm == true ) {
              _hintPassConfirm = false;
              _visiblePassConfirm = Icons.visibility_off;
              setState(() {});
            } else {
              _hintPassConfirm = true;
              _visiblePassConfirm = Icons.visibility;
              setState(() {});
            }
          }
        ),
      ),
      onChanged: (valor) {
        setState(() {
          print(_controllerPassConfirm.text);
        });
      },
    );
  }

  RaisedButton _addUserButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Theme.of(context).primaryColor,
      child: Text('Agregar', style: TextStyle(color: Colors.white),),
      onPressed: (!_isLoading) ? () {
        _addNewUser(context);
      } : null
    );
  }

  void _addNewUser(BuildContext context) async {

    setState(() {
      _isLoading = true;
    });

    var response = await usersProviders.addNewUser(
      nombre           : _controllerName.text,
      correo           : _controllerEmail.text,
      clave            : _controllerPass.text,
      claveConfirmation: _controllerPassConfirm.text
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
                TextSpan(text: 'ID de Usuario: ${response.id}', style: TextStyle(fontWeight: FontWeight.w500)),
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
    setState(() {
      _isLoading = false;
    });
  }
}