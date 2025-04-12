import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tela_login/components/user_title.dart';
import 'package:tela_login/models/User.dart';
import 'package:tela_login/pages/user_form.dart';
import 'package:tela_login/provider/users.dart';

class UsuariosCadastrados extends StatefulWidget {
  const UsuariosCadastrados({super.key});

  @override
  State<UsuariosCadastrados> createState() => _UsuariosCadastradosState();
}

class _UsuariosCadastradosState extends State<UsuariosCadastrados> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final todosUsuarios = usersProvider.searchUsers(_searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de usuários'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserForm()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Pesquisar usuário...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todosUsuarios.length,
              itemBuilder: (ctx, i) => UserTitle(todosUsuarios[i]),
            ),
          ),
        ],
      ),
    );
  }
}
