import 'package:flutter/material.dart';
import 'package:tela_login/data/dummy_users.dart';
import 'package:tela_login/models/User.dart';

class UsersProvider extends ChangeNotifier {
  final ValueNotifier<Map<String, User>> _itemsNotifier = ValueNotifier<Map<String, User>>({...DUMMY_USERS});

  // Getter para acessar o ValueNotifier
  ValueNotifier<Map<String, User>> get itemsNotifier => _itemsNotifier;

  // Getter para acessar a lista de usuários como ValueNotifier<List<User>>
  ValueNotifier<List<User>> get users {
    return ValueNotifier(_itemsNotifier.value.values.toList());
  }

  int get count {
    return _itemsNotifier.value.length;
  }

  User byIndex(int i) {
    return _itemsNotifier.value.values.elementAt(i);
  }

  void put(User user) {
    if (user == null) return;

    final id = user.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    final newMap = {..._itemsNotifier.value, id: user};

    _itemsNotifier.value = newMap;
    notifyListeners();
  }

  void removeUser(String userId) {
    if (!_itemsNotifier.value.containsKey(userId)) return;

    final newMap = {..._itemsNotifier.value};
    newMap.remove(userId);
    _itemsNotifier.value = newMap;
    notifyListeners();
  }

  void updateUser(User user) {
    if (user.id == null || !_itemsNotifier.value.containsKey(user.id)) return;

    final newMap = {..._itemsNotifier.value, user.id: user};
    _itemsNotifier.value = newMap;
    notifyListeners();
  }

  List<User> searchUsers(String query) {
    query = query.toLowerCase();

    return _itemsNotifier.value.values.where((user) {
      final name = user.name.toLowerCase();
      final email = user.emailAddress.toLowerCase();
      return name.contains(query) || email.contains(query);
    }).toList();
  }
}
