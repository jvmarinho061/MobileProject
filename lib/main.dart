import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tela_login/Routes/app_routes.dart';
import 'package:tela_login/pages/LoginScreen.dart';
import 'package:tela_login/pages/user_form.dart';
import 'package:tela_login/provider/users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UsersProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Tela de Login',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: LoginScreen(),
        initialRoute: '/', //página de login
        routes: {
          AppRoutes.USER_FORM: (context) => UserForm()
        },
      ),
    );
  }
}