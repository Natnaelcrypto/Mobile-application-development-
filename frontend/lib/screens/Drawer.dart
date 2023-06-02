import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';

import '../LocalStroe/Store.dart';
import '../auth/view/auth/Login_page.dart';
import '../user/model/user_model.dart';
import 'Profile.dart';

class Drawerpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(36, 130, 50, .6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  child: Text(
                    "${UserPreferences.username[0].toUpperCase()}",
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "    ${UserPreferences.username}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading:
                const Icon(Icons.home, color: Color.fromRGBO(36, 130, 50, .6)),
            title: const Text(
              'Home',
              style: TextStyle(
                color: Color.fromRGBO(36, 130, 50, .6),
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () {
              context.go("/home");
            },
          ),
          ListTile(
            key: const Key("Inventory"),
            leading: const Icon(Icons.inventory,
                color: Color.fromRGBO(36, 130, 50, .6)),
            title: const Text(
              'Inventory',
              style: TextStyle(
                color: Color.fromRGBO(36, 130, 50, .6),
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () {
              context.go("/inventory");
            },
          ),
          ListTile(
            leading: Icon(Icons.task, color: Color.fromRGBO(36, 130, 50, .6)),
            title: const Text(
              'Task',
              style: TextStyle(
                color: Color.fromRGBO(36, 130, 50, .6),
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () {
              context.go("/tasklist");
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.pets, color: Color.fromRGBO(36, 130, 50, .6)),
            title: const Text(
              'Herd',
              style: TextStyle(
                color: Color.fromRGBO(36, 130, 50, .6),
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () {
              context.go('/herdlist');
            },
          ),
          UserPreferences.role.toLowerCase() == "user"
              ? ListTile(
                  leading: const Icon(Icons.agriculture,
                      color: Color.fromRGBO(36, 130, 50, .6)),
                  title: const Text(
                    'Emplooye',
                    style: TextStyle(
                      color: Color.fromRGBO(36, 130, 50, .6),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  onTap: () {
                    context.go("/emplooyes");
                  },
                )
              : const Text(""),
          ListTile(
            leading: const Icon(Icons.logout,
                color: Color.fromRGBO(36, 130, 50, .6)),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Color.fromRGBO(36, 130, 50, .6),
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
            onTap: () {
              UserPreferences.farmName = "";
              UserPreferences.role = "";
              UserPreferences.userId = "";
              UserPreferences.username = "";
              context.go("/");
            },
          ),
        ],
      ),
    );
  }

  void _navigateToProfilePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }
}
