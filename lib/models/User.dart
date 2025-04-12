import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String emailAddress;
  final String avatarUrl;

  const User({
    required this.id,
    required this.name,
    required this.emailAddress,
    required this.avatarUrl,
  });
}