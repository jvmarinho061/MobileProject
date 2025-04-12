import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tela_login/models/User.dart';
import 'package:tela_login/provider/users.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = ModalRoute.of(context)!.settings.arguments as User?;
    if (user != null && _formData.isEmpty) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['emailAddress'] = user.emailAddress;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de Usuário"),
        actions: [
          IconButton(
            onPressed: () {
              if (_form.currentState!.validate()) {
                _form.currentState!.save();

                final newUser = User(
                  id: _formData['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
                  name: _formData['name'] ?? '',
                  emailAddress: _formData['emailAddress'] ?? '',
                  avatarUrl: _formData['avatarUrl'] ?? '',
                );

                context.read<UsersProvider>().put(newUser);
                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Campos do usuário
                TextFormField(
                  initialValue: _formData['name'],
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, insira um nome válido';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['emailAddress'],
                  decoration: InputDecoration(labelText: 'E-mail'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty || !value.contains('@')) {
                      return 'Por favor, insira um e-mail válido';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['emailAddress'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: InputDecoration(labelText: 'URL do Avatar'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor, insira uma URL válida';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['avatarUrl'] = value!,
                ),

                SizedBox(height: 20),
                Text("Cadastro de Livro", style: TextStyle(fontWeight: FontWeight.bold)),

                TextFormField(
                  decoration: InputDecoration(labelText: 'Título do Livro'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o título do livro';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['titulo'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Autor'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o autor do livro';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['autor'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'ISBN'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o ISBN do livro';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['isbn'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Editora'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe a editora do livro';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['editora'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Ano de Publicação'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty || int.tryParse(value) == null) {
                      return 'Informe um ano válido';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['ano'] = value!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
