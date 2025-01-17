import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jagga_bazar/features/auth/presentation/view/register_view.dart';

import '../view_model/login/login_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background1.png', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),

          // Semi-transparent overlay for better contrast
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),

          // Foreground Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40.0),

                    // Login Form
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email Field
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter Email',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),

                          // Password Field
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter Password',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25.0),

                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  context.read<LoginBloc>().add(
                                    LoginUserEvent(
                                      context: context,
                                      username: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),

                          // Register Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account? ',
                                style: TextStyle(color: Colors.white),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.read<LoginBloc>().add(
                                    NavigateRegisterScreenEvent(
                                      destination: const RegisterView(),
                                      context: context,
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30.0),

                    // Divider with Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white54,
                            thickness: 1,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Or Login with',
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white54,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),

                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _socialLoginButton(Icons.login, 'Google', Colors.red, () {}),
                        _socialLoginButton(Icons.apple, 'Apple', Colors.black, () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialLoginButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
