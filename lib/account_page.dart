import 'package:flutter/material.dart';
import 'managers/theme_manager.dart';

class AccountSettingsPage extends StatefulWidget {
  final ThemeManager themeManager;

  AccountSettingsPage({required this.themeManager});

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
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        children: <Widget>[
          ListTile(
            title: Text('Change Password'),
            onTap: () {
              // Navigate to the change password screen
            },
          ),
          ListTile(
            title: Text('View Email'),
            subtitle: Text(userEmail), // Display user's email dynamically
            onTap: () {
              // Implement functionality to view email
            },
          ),
          Divider(),
          SwitchListTile(
            title: Text('Dark Mode'),
            value: widget.themeManager.currentTheme == ThemeType.dark,
            onChanged: (value) {
              widget.themeManager.toggleDarkMode();
              setState(() {});
            },
          ),
          Divider(),
          ListTile(
            title: Text('Language Settings'),
            onTap: () {
              // Navigate to language settings screen
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Implement logout functionality
            },
          ),
          ListTile(
            title: Text('Delete Account'),
            onTap: () {
              // Implement delete account functionality
            },
          ),
          Divider(),
          ListTile(
            title: Text('Support'),
            onTap: () {
              // Implement support functionality
            },
          ),
          ListTile(
            title: Text('Terms of Service'),
            onTap: () {
              // Implement viewing terms of service functionality
            },
          ),
        ],
      ),
    );
  }
}
