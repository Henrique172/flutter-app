import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/user.dart';

class UserService {
  static const String apiUrl = 'http://172.20.10.14:3000';

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Converta os dados JSON em uma lista de usuários
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      // Se a solicitação não foi bem-sucedida, lance uma exceção
      throw Exception('Failed to load users');
    }
  }
}
