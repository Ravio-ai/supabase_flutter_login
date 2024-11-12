import 'package:flutter/material.dart';
import 'package:myapp/auth/auth_service.dart';
import 'package:myapp/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool hidePassword = true;

  void hidePass() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please fill all the fields"),
          ),
        );
      }
      return;
    }
    try {
      await authService.signInWithEmailPassword(email, password);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login successful"),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  onDispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Login"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                prefixIcon: const Icon(Icons.email),
                labelText: "Email",
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
              ),
              controller: _emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: hidePassword,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                prefixIcon: const Icon(Icons.lock),
                labelText: "Password",
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                suffixIcon: IconButton(
                  onPressed: hidePass,
                  icon: const Icon(Icons.remove_red_eye),
                ),
              ),
              controller: _passwordController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: login,
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
