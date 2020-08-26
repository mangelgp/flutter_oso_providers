
import 'dart:async';

import 'package:providers_oso/src/models/user_model.dart';
import 'package:providers_oso/src/providers/users_providers.dart';

class UsersBloc {

  static final UsersBloc _singleton = UsersBloc._internal();

  factory UsersBloc() {
    return _singleton;
  }

  UsersBloc._internal() {
    getAllUsers();
  }

  final usersProviders = new UsersProviders();

  final _usersController = StreamController<List<User>>.broadcast();

  Stream<List<User>> get userStream => _usersController.stream;

  dispose() {
    _usersController?.close();
  }

  getAllUsers() async {
    _usersController.sink.add(await usersProviders.getAllUsers());
  }

}