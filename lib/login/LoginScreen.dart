import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firstproject/user/user_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _errorMessage;
  bool _obscurePassword = true;  // For toggling password visibility

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login",style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,),
      ),automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_errorMessage != null) ...[
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 12),
              ],
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  _email = value.trim();
                  userVM.updateEmail(value.trim());
                },
                validator: (value) =>
                value != null && value.contains('@') ? null : 'Enter valid email',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                onChanged: (value) {
                  _password = value;
                  userVM.updatePassword(value);
                },
                validator: (value) =>
                value != null && value.length >= 6 ? null : 'Password too short',
              ),
              const SizedBox(height: 24),
              userVM.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  setState(() {
                    _errorMessage = null;
                  });

                  final error = await userVM.login(_email, _password, context);

                  if (error != null) {
                    setState(() {
                      _errorMessage = error;
                    });
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup'); // Or use MaterialPageRoute if you're not using named routes
                },
                child: const Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

            ],
          ),
        ),

      ),

    );
  }
}



