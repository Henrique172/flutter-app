import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
      print('url');
    return _items.values.elementAt(i);
  }

  Future<void> fetchUsersFromAPI() async {
    final url = 'http://10.150.4.166:3000/todos';
    try {
      final response = await http.get(Uri.parse(url));
    
      
      if (response.statusCode == 200) {
        final List<dynamic> userData = json.decode(response.body);
        
        _items.clear(); // Limpa os usuários existentes antes de adicionar os novos
        
        for (var userData in userData) {
          final user = User(
            id: userData['_id'],
            name: userData['name'],
            email: userData['email'],
            avatarUrl: userData['avatarUrl'],
          );
          _items[user.id] = user;
        }
        
        notifyListeners();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (error) {
      //throw Exception('Failed to load users: $error');
    }
  }


Future<void> remove(BuildContext context, User user) async {
  final url = 'http://10.150.4.166:3000/todos/${user.id}';
  
  // Exibir mensagem e ícone de carregamento
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Removendo usuário'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Por favor, aguarde...'),
        ],
      ),
    ),
  );

  try {
    // Envie a solicitação DELETE
    final response = await http.delete(Uri.parse(url));
    
    // Verifique se a solicitação foi bem-sucedida
    if (response.statusCode == 200) {
      // Remova o usuário da lista local
      _items.remove(user.id);
      
      // Feche o diálogo
      Navigator.of(context).pop();

      // Atualize a lista
      notifyListeners();

      // Exiba uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Usuário removido com sucesso'),
      ));
    } else {
      throw Exception('Failed to delete user: ${response.statusCode}');
    }
  } catch (error) {
    // Feche o diálogo
    Navigator.of(context).pop();

    // Exiba uma mensagem de erro
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Erro ao remover usuário: $error'),
      backgroundColor: Colors.red,
    ));
  }
}


Future<void> saveUser(BuildContext context, User user) async {
  try {
    final url = 'http://10.150.4.166:3000/todos';

      // Criação de novo usuário
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(user.toJson()),
        headers: {'Content-Type': 'application/json'},
      );


      if (response.statusCode == 201) {
        // Decodifica a resposta para obter o ID do usuário criado
        final responseData = json.decode(response.body);
        final newUserId = responseData['_id'];

        // Atualiza o usuário com o ID retornado
        final newUser = User(
          id: newUserId,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        );

        // Adiciona o novo usuário à lista local
        _items[newUserId] = newUser;

        // Atualiza a lista local
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Usuário criado com sucesso'),
        ));
      } else {
        throw Exception('Falha ao criar o usuário: ${response.statusCode}');
      }
    
  } catch (error) {
    print('Erro ao salvar usuário: $error');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Erro ao salvar usuário: $error'),
      backgroundColor: Colors.red,
    ));
  }
}




}