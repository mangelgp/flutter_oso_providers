import 'package:flutter/material.dart';
import 'package:providers_oso/src/models/error_user_model.dart';
import 'package:providers_oso/src/models/user_model.dart';
import 'package:providers_oso/src/providers/users_providers.dart';


class UpdateUserPage extends StatefulWidget {
  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {

  final comService = UsersProviders();

  final _nameController = TextEditingController();
  final _emailController =TextEditingController();

  @override
  void dispose() { 
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final User user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context, true);}),
        centerTitle: true,
        title: Text('Modificar'),
      ),
      body: _buildBody(user, context),
    );
  }

  Widget _buildBody(User user, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: double.infinity,
      child: Column(
        children: [
          _fieldName(user),
          SizedBox(height: 25.0,),
          _fieldEmail(user),
          SizedBox(height: 30.0,),
          _updateButton(context, user)
        ],
      ),
    );
  }

  TextField _fieldName(User user) {
    return TextField(
      controller: _nameController,
      autofocus: true,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: '${user.name}',
        labelText: 'Nombre',
      ),
      onChanged: (valor) {
        setState(() {
          print(_nameController);
        });
      },
    );
  }

  TextField _fieldEmail(User user) {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: '${user.email}',
        labelText: 'Correo',
      ),
      onChanged: (valor) {
        setState(() {
          print(_emailController);
        });
      },
    );
  }

  FlatButton _updateButton(BuildContext context, User user) {
    return FlatButton(
      child: Text('Actualizar', style: TextStyle(color: Colors.white),),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Theme.of(context).primaryColor,
      onPressed: () {
        _updateUser(context, user);
      }, 
    );
  }

  _updateUser(BuildContext context, User user,) async {
    var updatedUser = await comService.updateUserById(
      id: user.id.toString(),
      name: _nameController.text,
      email: _emailController.text,
    );
    
     if (updatedUser is User) {

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.done, size: 35.0, color: Colors.green,),
          content: Text("Datos actualizados exitosamente!", textAlign: TextAlign.center,)
        ),
        barrierDismissible: true,
      ).then((value) => Navigator.pop(context, true));

    } else if (updatedUser is ErrorUser){
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.warning, size: 35.0, color: Colors.red),
          content: Text('error: ${updatedUser.name}, ${updatedUser.email}'),
        ),
        barrierDismissible: true,
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Icon(Icons.warning, size: 35.0, color: Colors.red),
          content: Text('error: $updatedUser'),
        ),
        barrierDismissible: true,
      );
    }
  }

}