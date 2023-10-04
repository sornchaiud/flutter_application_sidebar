import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/home.dart';
import '../screens/contact.dart';
import '../screens/profile.dart';
import '../screens/about.dart';
import '../screens/settings.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('AccountName'),
            accountEmail: Text('email@example.com'),
            currentAccountPicture: CircleAvatar(
              // backgroundImage: NetworkImage(
              //     "https://www.ninenik.com/images/ninenik_page_logo.jpg"),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, Home.routeName);
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.info),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pushReplacementNamed(context, About.routeName);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.user),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushReplacementNamed(context, Profile.routeName);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.addressCard),
            title: Text('Contact Us'),
            onTap: () {
              Navigator.pushReplacementNamed(context, Contact.routeName);
            },
          ),
          Divider(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.cog),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pushNamed(context, Settings.routeName);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
