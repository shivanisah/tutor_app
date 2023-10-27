import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_urls/app_urls.dart';
import '../shared_preferences.dart/user_preferences.dart';

class TutorDrawer extends StatefulWidget {
  @override
  State<TutorDrawer> createState() => _TutorDrawerState();
}

class _TutorDrawerState extends State<TutorDrawer> {
  final userPreferences = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userPreferences.getUser(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text('No user data');
        }

        final user = snapshot.data!;
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  user.fullName,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                accountEmail: Text(
                  user.phoneNumber,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 238, 231, 231),
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 60,
                  child: ClipOval(
                    child: user.image != null
                        ? Image.network(
                            AppUrl.baseUrl + user.image!,
                            width: 150,
                            height: 120,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          )
                        : Image.asset(
                            "assets/images/d1.jpg",
                            width: 150,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              // ... Add the rest of your drawer items here ...
            ],
          ),
        );
      },
    );
  }
}
