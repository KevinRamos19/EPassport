import 'package:flutter/material.dart';

void main() {
  runApp(const BoyScoutApp());
}

class BoyScoutApp extends StatelessWidget {
  const BoyScoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boy Scout Login',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const SignInPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      if (username == 'scout' && password == '1234') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'lib/boyscout_app/assets/images/bg.png',
            fit: BoxFit.cover,
          ),

          // Left-side overlay image
          Align(
            alignment: Alignment.centerLeft,
            child: Transform.translate(
              offset: const Offset(-50, 0), // Adjust this to nudge more/less
              child: Image.asset(
                'lib/boyscout_app/assets/images/left_side.png',
                fit: BoxFit.fitHeight,
                height: double.infinity,
              ),
            ),
          ),

          // Login Form aligned to the right
          Row(
            children: [
              const Spacer(), // Pushes the form to the right
              Expanded(
                flex: 2,
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Scout Serial Number',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white70,
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter a username'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white70,
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter a password'
                                : null,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: _signIn,
                            icon: const Icon(Icons.login),
                            label: const Text('Sign In'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
