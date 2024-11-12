import 'package:flutter/material.dart';
import 'package:myapp/auth/auth_service.dart';
import 'package:myapp/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool hidePassword = true;

  void register() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please fill all the fields"),
          ),
        );
      }
      return;
    }
    if (password != confirmPassword) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Passwords do not match"),
          ),
        );
      }
      return;
    }
    try {
      await authService.signUpWithEmailPassword(email, password);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration successful"),
          ),
        );
      }
      Navigator.pop(context);
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

  void hidePass() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  onDispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Register"),
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
                labelText: "Confirm Password",
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                suffixIcon: IconButton(
                  onPressed: hidePass,
                  icon: const Icon(Icons.remove_red_eye),
                ),
              ),
              controller: _confirmPasswordController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: register,
              child: const Text(
                "Register",
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
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign In',
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
