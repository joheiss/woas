import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../services/firebase_service.dart';

import '../../service_locator.dart';

class MenuDrawer extends StatelessWidget {
  final _firebaseService = locator<FirebaseService>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Hallo'),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text('Mehr Information'),
            trailing: Icon(Icons.info),
            // onTap: () => Navigator.pushNamed(context, '/info'),
          ),
          Divider(),
          ListTile(
              title: Text('Abmelden'),
              trailing: Icon(Icons.power_settings_new),
              onTap: () {
                _firebaseService.logoff();
                Navigator.pushNamed(context, LoginPage.route);
              }
          ),
        ],
      ),
    );
  }
}
