import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/users.dart';
import 'package:flutter_application_1/routes/app_routes.dart';
import 'package:flutter_application_1/views/user_form.dart';
import 'package:flutter_application_1/views/user_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => Users(),
        child: MaterialApp(
            title: 'Bora-bora',
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 1, 0, 0)),
              useMaterial3: true,
            ),
            // home: UserList(),
            routes:{
              AppRoutes.HOME: (_)=> UserList(), 
              AppRoutes.USER_FORM: (_) => UserForm()
            },
            )
            );
  }
}
