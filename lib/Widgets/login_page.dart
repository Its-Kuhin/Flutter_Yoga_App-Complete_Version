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

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isSigningIn = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward(); // Start the slide-up animation
  }

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
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Check if email or password is empty
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'Email or Password cannot be empty.');
      return;
    }

    try {
      setState(() => _isSigningIn = true);
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Fluttertoast.showToast(msg: 'Welcome ${userCredential.user?.email}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()), // Navigate to Home
      );
    } on FirebaseAuthException catch (e) {
      String errorMsg;

      // Handle different Firebase authentication errors
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
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          AnimatedContainer(
            duration: Duration(seconds: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2196F3), // Blue
                  Color(0xFF0D47A1), // Dark Blue
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Container(),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: AnimatedOpacity(
                  opacity: _isSigningIn ? 0.5 : 1,
                  duration: Duration(seconds: 1),
                  child: SizedBox.shrink(), // Removed asset image
                ),
              ),
            ],
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    Text(
                      "Welcome to Yoga The Daily Fitness",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center, // Center the text
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Log in to continue",
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    SizedBox(height: 40),

                    // Email Input with Floating Labels
                    _buildTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      icon: Icons.email,
                    ),
                    SizedBox(height: 20),

                    // Password Input with Floating Labels
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
                    SizedBox(height: 30),
                    // Sign Up Text Button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.white70, fontSize: 18), // Default style
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                            ),
                            TextSpan(
                              text: "Sign up",
                              style: TextStyle(
                                color: Colors.blueAccent,  // Highlight the "Sign up" text
                                fontWeight: FontWeight.bold, // Make it bold
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

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

                    SizedBox(height: 20),

                    // Google Sign-In Button with Network Image
                    _buildCustomButtonGoogle(
                      icon: Image.asset(
                        'assets/logo/Google-Logo.png', // Asset Image URL
                        width: 50,
                        height: 50,
                      ),
                      onPressed: _signInWithGoogle,
                    ),

                    if (_isSigningIn) CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom TextField Widget with Floating Labels
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.8),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
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
        backgroundColor: Colors.deepOrange, // Changed color to a warmer tone
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
      onPressed: onPressed,
    );
  }

  // Custom Google Sign-In Button
  Widget _buildCustomButtonGoogle({
    required Image icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: icon,
      label: Text('Login with Google'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
      onPressed: onPressed,
    );
  }
}
