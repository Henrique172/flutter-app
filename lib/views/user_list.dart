import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/user_tile.dart';
import 'package:flutter_application_1/provider/users.dart';
import 'package:flutter_application_1/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    super.initState();
    // Chame fetchUsersFromAPI() no initState para carregar os usuários da API ao iniciar a tela
    Provider.of<Users>(context, listen: false).fetchUsersFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer para reconstruir o widget quando os usuários forem carregados
    return Consumer<Users>(
      builder: (context, users, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Lista de Usuários'),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                  );
                },
                icon: Icon(Icons.add),
              )
            ],
          ),
          body: ListView.builder(
            itemCount: users.count,
            itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
          ),
        );
      },
    );
  }
}
