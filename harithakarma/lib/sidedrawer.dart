import 'package:flutter/material.dart';
import 'package:harithakarma/login.dart';
import 'package:harithakarma/main.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _SideDrawer(),
      appBar: AppBar(
        title: Text('Haritha Karma'),
        backgroundColor: Color.fromARGB(255, 23, 75, 7),
      ),
      body: Center(
        child: Text('Haritha Karma'),
      ),
    );
  }
}

class _SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'HarithaKarma',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 23, 75, 7),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashbord'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Login(),
                ),
                (route) => false,
              )
            },
          ),
        ],
      ),
    );
  }
}
