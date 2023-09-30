import "package:Sashimi/Feed/feed_page.dart";
import "package:Sashimi/Login/signup.dart";
import "package:flutter/material.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Log In",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Username/Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: InkWell(
                  onTap: () => (
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  )
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        decoration: TextDecoration.underline, color: Colors.blue),
                  ),
                ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedPage()),
                );
              },
              child: Text('Log In'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => (
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                )
                ),
                child: Text(
                  'Don''t Have an Account? Register',
                  style: TextStyle(
                      decoration: TextDecoration.underline, color: Colors.blue),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
