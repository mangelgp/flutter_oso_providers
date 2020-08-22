import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:providers_oso/src/models/error_user.dart';
import 'package:providers_oso/src/models/user.dart';

class ComunicationService {
  String authority = '192.168.0.2:8001';
  static Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  Future<List<User>> getAllUsers() async {
    final url = Uri.http(authority, 'api/users');
    return await _procesarRespuesta(url);
  }

  Future <User> getUserById(String idUser) async {
    final url = Uri.http(authority, 'api/users/$idUser');
    try {
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final user = new User.fromJson(decodedData['data']);
      print(decodedData['data']);
      return user;
    } catch (err) {
      print(err.toString());
    }
    return null;
  }

  Future<dynamic> addNewUser({String nombre, String correo, String clave, String claveConfirmation}) async {

    final url = Uri.http(authority, 'api/users',{
      'name'                  : nombre,
      'email'                 : correo,
      'password'              : clave,
      'password_confirmation' : claveConfirmation
    });

    final resp = await http.post(url);
    final decodedData = json.decode(resp.body);
    
    try {

      final user = new User.fromJson(decodedData['data']);
      print(decodedData['data']);
      return user;

    } catch (_) {

      try {
        final error = ErrorUser.fromJson(decodedData['error']);
        print(decodedData['error']);
        return error;
      } catch (error) {
        print(error.toString());
        return null;
      }

    }
  }

  Future<User> updateUser({String id, String name, String email}) async {
    Map <String, dynamic> body = {
      'name'    : name,
      'email'   : email,
    };
    try {
      final url = Uri.http(authority, 'api/users/$id');
      final resp = await http.put(url, body: body, headers: ComunicationService.headers);
      final decodedData = json.decode(resp.body);
      final updatedUser = new User.fromJson(decodedData['data']);
      return updatedUser;
    } catch (err) {
      print(err.toString());
    }
    return null;
  }

  Future<List<User>> _procesarRespuesta(Uri url) async {
    try {
      final resp = await http.get(url);
      final decodedData = json.decode(resp.body);
      final allUsers = new Users.fromJsonList(decodedData['data']);
      print(decodedData['data']);
      return allUsers.items;
    } catch (err) {
      print(err.toString());
    }
    return null;

  }

  Future deleteUserById(String idUser) async {
    try {
      final url = Uri.http(authority, 'api/users/$idUser');
      var response = await http.delete(url);
      print(response.body);
      return jsonDecode(response.body);
    } catch (err) {
      print('error: ${err.toString()}');
    }
    return null;
  }
}