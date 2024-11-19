import 'package:flutter/material.dart';
import 'package:pet_door_user/controllers/auth_service.dart';
import 'package:pet_door_user/provider/user_provider.dart';
import 'package:pet_door_user/views/about_us.dart';
import 'package:pet_door_user/views/termsAndconditions.dart';
import 'package:pet_door_user/widgets/colors.dart';
import 'package:pet_door_user/widgets/signout.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgr,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Card
            Consumer<UserProvider>(
              builder: (context, value, child) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                shadowColor: Colors.grey.withOpacity(0.3),
                child: ListTile(
                  contentPadding: EdgeInsets.all(20),
                  // leading: CircleAvatar(
                  //   radius: 30,
                  //   backgroundImage: AssetImage(
                  //       'assets/profile_placeholder.png'), // Placeholder profile image
                  // ),
                  title: Text(
                    value.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    value.email,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/update_profile");
                  },
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      Icons.edit_outlined,
                      color: Colors.blue,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Options Section
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 10),

            // Orders Option
            buildOptionTile(
              context,
              title: "Orders",
              icon: Icons.local_shipping_outlined,
              color: Colors.orange,
              onTap: () {
                Navigator.pushNamed(context, "/orders");
              },
            ),

            // About Us Option

            buildOptionTile(
              context,
              title: "Contact us",
              icon: Icons.mail,
              color: Colors.blue,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Mail us at petdoor@gmail.com")));
              },
            ),
            buildOptionTile(
              context,
              title: "About us",
              icon: Icons.support_agent,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUs()),
                );
              },
            ),
            buildOptionTile(
              context,
              title: "Terms and Conditions",
              icon: Icons.description,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Terms()),
                );
              },
            ),
            buildOptionTile(
              context,
              title: "Logout",
              icon: Icons.logout_outlined,
              color: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomAlertDialog(
                      title: "Confirm Logout",
                      content: "Are you sure you want to log out?",
                      cancelText: "Cancel",
                      continueText: "Logout",
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                      onContinue: () async {
                        Navigator.of(context).pop();
                        // Proceed with logout
                        Provider.of<UserProvider>(context, listen: false)
                            .cancelProvider();
                        await AuthService().logout();
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/login", (route) => false);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Reusable ListTile for Options
  Widget buildOptionTile(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 2,
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
