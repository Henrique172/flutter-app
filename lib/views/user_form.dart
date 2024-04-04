import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  final User? user; // Aceita um usuário opcional

  UserForm({this.user});

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  late Map<String, String?> _formData;

  @override
  void initState() {
    super.initState();
    // Inicializa _formData com os dados do usuário se existirem, caso contrário, com um mapa vazio
    _formData = {
      'name': widget.user?.name ?? '',
      'email': widget.user?.email ?? '',
      'avatarUrl': widget.user?.avatarUrl ?? '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Novo Usuário' : 'Editar Usuário'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final isValid = _form.currentState?.validate() ?? false;

              if (isValid) {
                _form.currentState?.save();
                final usersProvider = Provider.of<Users>(context, listen: false);
                final user = User(
                  id: widget.user?.id ?? '', // Use o ID do usuário se existir
                  name: _formData['name']!,
                  email: _formData['email']!,
                  avatarUrl: _formData['avatarUrl']!,
                );
                
                // Chama o método saveUser para salvar ou atualizar o usuário
                usersProvider.saveUser(context, user);

                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'], // Preenche com o valor inicial do nome
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome Inválido';
                  }
                  if (value.trim().length < 5) {
                    return 'Nome muito Pequeno. Minímo 5 letras';
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value,
              ),
              TextFormField(
                initialValue: _formData['email'], // Preenche com o valor inicial do email
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _formData['email'] = value,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'], // Preenche com o valor inicial do URL do avatar
                decoration: InputDecoration(labelText: 'URL Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
