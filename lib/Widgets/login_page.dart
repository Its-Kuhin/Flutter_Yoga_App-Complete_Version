
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_yoga/Screens/home.dart';
import 'SignUpPage.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isSigningIn = false;

  Future<User?> _signInWithGoogle() async {
    try {
      setState(() => _isSigningIn = true);
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      Fluttertoast.showToast(msg: 'Welcome ${userCredential.user?.email}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()), // Navigate to Home
      );
      return userCredential.user;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error during Google sign-in, please try again');
      return null;
    } finally {
      setState(() => _isSigningIn = false);
    }
  }

  Future<void> _signInWithEmail() async {
    try {
      setState(() => _isSigningIn = true);
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Fluttertoast.showToast(msg: 'Welcome ${userCredential.user?.email}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()), // Navigate to Home
      );
    } on FirebaseAuthException catch (e) {
      // Display a more specific error message based on the error code
      String errorMsg;
      if (e.code == 'invalid-credential') {
        errorMsg = 'Invalid email or password format. Please try again.';
      } else if (e.code == 'wrong-password') {
        errorMsg = 'Incorrect password provided.';
      } else if (e.code == 'user-not-found') {
        errorMsg = 'No user found with that email.';
      } else {
        errorMsg = 'Error during sign-in: ${e.message}';
      }
      Fluttertoast.showToast(msg: errorMsg);
    } finally {
      setState(() => _isSigningIn = false);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF270B19),

                  Color(0xFF270B19), // Hex value for black

                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
                Padding(
                  padding: const EdgeInsets.only(top:0.0),
                  child: Image.asset("assets/logo/56734.png",),
                ),
            ],
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo
                  // CircleAvatar(
                  //   radius: 120,
                  //   backgroundColor: Colors.transparent,
                  //   backgroundImage: AssetImage('assets/logo/yoga_trasparent.png'),
                  // ),

                  SizedBox(height: 80),
                  Text(
                    "Welcome to Yoga The Daily",
                    style: TextStyle(color: Colors.blueAccent,fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Fitness",
                    style: TextStyle(color: Colors.blueAccent,fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 60),
                    ],
                  ),
                  Text(
                    "Log in to continue",
                    style: TextStyle(color: Colors.white70,fontSize: 15),
                  ),
                  SizedBox(height: 10),

                  // Email Input
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    icon: Icons.email,
                  ),

                  SizedBox(height: 20),

                  // Password Input
                  _buildTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),

                  SizedBox(height: 30),

                  // Login with Email Button
                  _buildCustomButton(
                    text: 'Login with Email',
                    onPressed: _signInWithEmail,
                  ),

                  // Sign Up Text Button
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()), // Navigate to SignUpPage
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),


                  SizedBox(height: 10),

                  // Divider with Text
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.white54)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('OR', style: TextStyle(color: Colors.white)),
                      ),
                      Expanded(child: Divider(color: Colors.white54)),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Google Sign-In Button
                  _buildCustomButtonGoogle(
                    icon: Image.asset(
                      'assets/logo/google_icon.png',
                      width: 40,
                      height: 40,
                     color: Colors.white,
                    ),
                    onPressed: _signInWithGoogle,
                  )
                  ,

                  if (_isSigningIn) CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom TextField Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Custom Button Widget
  Widget _buildCustomButton({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
  }) {
    return ElevatedButton.icon(
      icon: icon != null ? Icon(icon, color: Colors.white) : SizedBox.shrink(),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
    );
  }

  Widget _buildCustomButtonGoogle({Widget? icon, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10),
        shape: CircleBorder(),

      ),
      onPressed: onPressed,
      child: icon ?? SizedBox.shrink(),
    );
  }



}
