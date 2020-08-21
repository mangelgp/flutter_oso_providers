

import 'dart:async';

import 'package:providers_oso/src/models/user.dart';
import 'package:providers_oso/src/providers/providers.dart';

class UsersBloc {

  final comService = ComunicationService();

  static final UsersBloc _singleton = UsersBloc._internal();
  factory UsersBloc() {
    return _singleton;
  }

  UsersBloc._internal() {
    getAllUsers();
  }

  final _usersController = StreamController<List<User>>.broadcast();
  final _userController = StreamController<User>.broadcast();

  Stream<List<User>> get usersStream => _usersController.stream;
  Stream<User> get userStream => _userController.stream;

  dispose() {
    _usersController?.close();
    _userController?.close();
  }

  getAllUsers() async {
    _usersController.sink.add(await comService.getAllUsers());
  }

  getUserById(String idUser) async {
    _userController.sink.add(await comService.getUserById(idUser));
  }

  Future<User> updateUser(String email, String idUser, String name) async{
    final response = await comService.updateUser(
      email: email,
      id: idUser.toString(),
      name: name
    );
    getAllUsers();
    return response;
  }
  deleteUserById(String idUser) async {
    await comService.deleteUserById(idUser);
    getAllUsers();
  }
}