import 'package:flutter/material.dart';
import '../../Managers/UserManager.dart';
import '../../domain/entities/User.dart';

class TestUserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<TestUserPage> {
  final UserManager _userManager =
      UserManager(); // Assuming UserManager is properly initialized
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _profileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Manager'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _userManager.users.length,
              itemBuilder: (context, index) {
                User user = _userManager.users[index];
                return ListTile(
                  title: Text(user.email),
                  subtitle: Text('Role: ${user.role}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _userManager.deleteUser(user.userId).then((_) {
                        setState(() {});
                      });
                    },
                  ),
                );
              },
            ),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _roleController,
            decoration: InputDecoration(labelText: 'Role'),
          ),
          TextField(
            controller: _profileController,
            decoration: InputDecoration(labelText: 'Profile'),
          ),
          ElevatedButton(
            onPressed: () {
              User newUser = User(
                email: _emailController.text,
                role: _roleController.text,
                profile: _profileController.text,
              );
              _userManager.addUser(newUser).then((_) {
                setState(() {
                  _emailController.clear();
                  _roleController.clear();
                  _profileController.clear();
                });
              });
            },
            child: Text('Add User'),
          ),
        ],
      ),
    );
  }
}
