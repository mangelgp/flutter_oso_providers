import 'package:flutter/material.dart';
import 'package:providers_oso/src/pages/add_user.dart';
import 'package:providers_oso/src/pages/all_users.dart';
import 'package:providers_oso/src/pages/find_user.dart';
import 'package:providers_oso/src/pages/home_page.dart';
import 'package:providers_oso/src/pages/update_user_page.dart';
import 'package:providers_oso/src/pages/user_det_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API REST',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/'           : (BuildContext context) => HomePage(),
        'add_user'    : (BuildContext context) => NewUserPage(),
        'all_user'    : (BuildContext context) => AllUsersPage(),
        'user_det'    : (BuildContext context) => UserDetPage(),
        'find_user'   : (BuildContext context) => FindUser(),
        'update_user' : (BuildContext context) => UpdateUserPage(),
      },
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      themeMode: ThemeMode.system,
    );
  }
}