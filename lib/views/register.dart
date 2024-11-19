import 'package:flutter/material.dart';
import 'package:pet_door_user/controllers/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/adopt4.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App icon or logo
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/3744410.jpg'),
                      radius: 50,
                    ),
                  ),
                  SizedBox(height: 40),
                  // Sign Up text
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Join as an Adopter',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Form fields
                  Form(
                    key: formKey,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction, // Added this line
                    child: Column(
                      children: [
                        // Username Field
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Colors.orangeAccent),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            prefixIcon: Icon(Icons.person, color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            errorStyle: TextStyle(color: Colors.redAccent),
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (value) =>
                              value!.isEmpty ? 'Enter a username' : null,
                        ),
                        SizedBox(height: 20),
                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.orangeAccent),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            errorStyle: TextStyle(color: Colors.redAccent),
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            String pattern =
                                r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                            RegExp regex = RegExp(pattern);
                            if (value == null || value.isEmpty) {
                              return 'Enter your email';
                            } else if (!regex.hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // Password Field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.orangeAccent),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            errorStyle: TextStyle(color: Colors.redAccent),
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (value) =>
                              value!.isEmpty ? 'Enter your password' : null,
                        ),
                        SizedBox(height: 40),
                        // Sign Up Button
                        ElevatedButton.icon(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              String email = _emailController.text.trim();
                              String password = _passwordController.text.trim();
                              String username = _usernameController.text.trim();

                              AuthService()
                                  .createAccountWithEmail(
                                      username, email, password)
                                  .then((value) {
                                if (value == 'Account Created') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Account created successfully')));
                                  Navigator.restorablePushNamedAndRemoveUntil(
                                      context, '/home', (route) => false);
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(value,
                                        style: TextStyle(color: Colors.white)),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            foregroundColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 120,
                              vertical: 15,
                            ),
                          ),
                          icon: Icon(Icons.pets),
                          label: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 30),
                        // Already have an account option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
