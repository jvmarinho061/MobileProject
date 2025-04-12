import 'package:flutter/material.dart';
import 'package:tela_login/models/User.dart';
import 'package:tela_login/pages/user_form.dart';
import 'package:tela_login/provider/users.dart';
import 'package:provider/provider.dart';

class UserTitle extends StatelessWidget {
  final User user;

  const UserTitle(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatar = (user.avatarUrl?.isNotEmpty ?? false)
        ? CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl!))
        : const CircleAvatar(child: Icon(Icons.person));

    return ListTile(
      leading: avatar,
      title: Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(user.emailAddress),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserForm(),
                    settings: RouteSettings(arguments: user),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir Usuário'),
                    content: Text('Tem certeza?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Não')),
                      TextButton(
                        onPressed: () {
                          context.read<UsersProvider>().removeUser(user.id!);
                          Navigator.of(context).pop();
                        },
                        child: Text('Sim'),
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete),
              color: Colors.red[400],
            )
          ],
        ),
      ),
    );
  }
}
