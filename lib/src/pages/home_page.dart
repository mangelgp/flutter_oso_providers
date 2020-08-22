import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('API REST'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        width: double.infinity,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text('Usuarios registrados'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, 'all_user');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Registrar nuevo usuario'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, 'add_user');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Buscar Usuario'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, 'find_user');
              },
            ),
          ],
        ),
      ),
    );
  }
}