import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UserProfileSection extends StatelessWidget {
  final Function onFilterTap;

  const UserProfileSection({
    Key? key,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage('assets/userpets.jpg'),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, Adil",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D4059),
              ),
            ),
            Text(
              "Welcome back!",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        Spacer(),
        // Stylish Lottie Animation
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/cart"),
              child: Lottie.asset(
                'assets/cartani.json',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.filter_list, size: 30, color: Color(0xFF2D4059)),
          onPressed: () => onFilterTap(),
        ),
      ],
    );
  }
}
