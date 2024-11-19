import 'package:flutter/material.dart';
import 'package:pet_door_user/controllers/auth_service.dart';
import 'package:pet_door_user/views/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Loading state

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
                  // Welcome text
                  Text(
                    'Welcome to PetDoor!',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Login as Adopter',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 35),
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        // Email input field
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
                          validator: (value) =>
                              value!.isEmpty ? 'This field is required' : null,
                        ),
                        SizedBox(height: 20),
                        // Password input field
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
                              value!.isEmpty ? 'This field is required' : null,
                        ),
                        SizedBox(height: 10),
                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      title: Text('Reset your password'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Enter your email'),
                                          SizedBox(height: 10),
                                          TextFormField(
                                            controller: _emailController,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel')),
                                        TextButton(
                                            onPressed: () async {
                                              if (_emailController
                                                  .text.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Email can\'t be empty')));
                                              } else {
                                                await AuthService()
                                                    .resetPassword(
                                                        _emailController.text)
                                                    .then((value) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'Password reset link sent')));
                                                  Navigator.pop(context);
                                                });
                                              }
                                            },
                                            child: Text('Continue'))
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        // Login button and loading indicator
                        _isLoading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.orangeAccent),
                              )
                            : ElevatedButton.icon(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true; // Start loading
                                    });

                                    AuthService()
                                        .loginWithEmail(_emailController.text,
                                            _passwordController.text)
                                        .then((value) {
                                      setState(() {
                                        _isLoading = false; // Stop loading
                                      });

                                      if (value == 'Login Successful') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text('Login Successful')));
                                        Navigator
                                            .restorablePushNamedAndRemoveUntil(
                                                context,
                                                '/home',
                                                (route) => false);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(value,
                                              style: TextStyle(
                                                  color: Colors.white)),
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
                                  'Login',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                        SizedBox(height: 30),
                        // Sign-up option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign Up',
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
