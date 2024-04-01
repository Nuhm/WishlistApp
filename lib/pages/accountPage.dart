import 'package:flutter/material.dart';
import 'package:wishlist_app/managers/themeManager.dart';

class AccountSettingsPage extends StatefulWidget {
  final ThemeManager themeManager;

  const AccountSettingsPage({super.key, required this.themeManager});

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  String _getUserEmail() {
    return 'user@example.com';
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = _getUserEmail();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        children: <Widget>[
          ListTile(
            title: const Text('Change Password'),
            onTap: () {
              // Navigate to the change password screen
            },
          ),
          ListTile(
            title: const Text('View Email'),
            subtitle: Text(userEmail),
            onTap: () {
              // Implement functionality to view email
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: widget.themeManager.currentTheme == ThemeType.dark,
            onChanged: (value) {
              widget.themeManager.toggleDarkMode();
              setState(() {});
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Language Settings'),
            onTap: () {
              // Navigate to language settings screen
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              // Implement logout functionality
            },
          ),
          ListTile(
            title: const Text('Delete Account'),
            onTap: () {
              // Implement delete account functionality
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Support'),
            onTap: () {
              // Implement support functionality
            },
          ),
          ListTile(
            title: const Text('Terms of Service'),
            onTap: () {
              // Implement viewing terms of service functionality
            },
          ),
        ],
      ),
    );
  }
}
