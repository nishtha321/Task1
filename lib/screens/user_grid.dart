import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:task1/screens/user_profile.dart';

import '../models/user.dart';

class UserGrid extends StatefulWidget {
  const UserGrid({Key? key}) : super(key: key);

  @override
  State<UserGrid> createState() => _UserGridState();
}

class _UserGridState extends State<UserGrid> {
  late List<User> _users;

  // ignore: override_on_non_overriding_member
  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  Future<void> _getUsers() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/users'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      _users = (jsonData as List).map((e) => User.fromJson(e)).toList();
      setState(() {});
    } else {
      throw Exception('Failed to load users');
    }
  }

  Widget _buildUserGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: _users.length,
      itemBuilder: (BuildContext context, int index) {
        final user = _users[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserProfile(
                          user: user,
                        )));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user.image),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(user.name),
                const SizedBox(
                  height: 5,
                ),
                Text(user.email),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfile(
                                  user: user,
                                )));
                  },
                  child: const Text("View Profile"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext conytext) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profiles'),
      ),
      body: _users == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildUserGrid(),
    );
  }
}
