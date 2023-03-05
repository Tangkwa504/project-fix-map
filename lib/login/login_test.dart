import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      // Your login logic here
      final username = _usernameController.text;
      final password = _passwordController.text;
      print('Username: $username, Password: $password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                obscureText: _isPasswordHidden,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}