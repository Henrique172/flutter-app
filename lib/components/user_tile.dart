import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/provider/users.dart';
import 'package:flutter_application_1/views/user_form.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
        leading: avatar,
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: Container(
          width: 100,
          child: Row(children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(

                    builder: (context) => UserForm(user: user),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Color.fromARGB(255, 187, 5, 5),
              onPressed: () {
                final users = Provider.of<Users>(context, listen: false);
                users.remove(context,
                    this.user); // Passando context como primeiro parâmetro
              },
            ),
          ]),
        ));
  }
}
