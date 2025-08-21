// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'lending_page.dart';
// import 'hospital.dart';
// import 'signup.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//   bool _isSendOtpButtonEnabled = false;
//   bool _isVerifyButtonEnabled = false;
//   bool _isOtpSent = false;
//   int _otpTimer = 30;
//   Timer? _timer;

//   // Dummy data to simulate existing and new users
//   static const List<String> _existingUsers = ['1234567890', '9876543210'];
//   // Dummy OTP for demonstration
//   static const String _dummyOtp = '123456';

//   @override
//   void initState() {
//     super.initState();
//     _phoneController.addListener(_updateSendOtpButtonState);
//     _otpController.addListener(_updateVerifyButtonState);
//   }

//   @override
//   void dispose() {
//     _phoneController.removeListener(_updateSendOtpButtonState);
//     _otpController.removeListener(_updateVerifyButtonState);
//     _phoneController.dispose();
//     _otpController.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }

//   void _updateSendOtpButtonState() {
//     setState(() {
//       _isSendOtpButtonEnabled = _phoneController.text.length == 10;
//     });
//   }

//   void _updateVerifyButtonState() {
//     setState(() {
//       _isVerifyButtonEnabled = _otpController.text.length == 6;
//     });
//   }

//   void _startOtpTimer() {
//     _otpTimer = 30;
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_otpTimer > 0) {
//         setState(() {
//           _otpTimer--;
//         });
//       } else {
//         _timer?.cancel();
//         _otpController.clear();
//         setState(() {
//           _isOtpSent = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('OTP has expired. Please resend.'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     });
//   }

//   void _sendOtp() {
//     setState(() {
//       _isOtpSent = true;
//     });
//     _startOtpTimer();
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('OTP sent to your phone number.'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   void _handleLogin() {
//     if (_otpController.text == _dummyOtp) {
//       _timer?.cancel();
//       bool isExistingUser = _existingUsers.contains(_phoneController.text);

//       if (isExistingUser) {
//         // Navigate to the main app dashboard for existing users
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const UBloodHomePage()),
//         );
//       } else {
//         // Navigate to the sign-up page for new users
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const SignUpScreen()),
//         );
//       }
//     } else {
//       _showErrorDialog(
//         'Invalid OTP',
//         'The OTP you entered is incorrect. Please try again.',
//       );
//     }
//   }

//   void _showErrorDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: Text(title),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFFFEE8E8), Color(0xFFFFFFFF)],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Image.asset('assets/images/newlogo.png', height: 150),
//                 ),
//                 const SizedBox(height: 30),
//                 const Text(
//                   'Welcome to Blood Link',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF2C3E50),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Enter your phone number to continue',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 18, color: Color(0xFF2C3E50)),
//                 ),

//                 const SizedBox(height: 50),

//                 _buildInputField(
//                   controller: _phoneController,
//                   hintText: '10-digit phone number',
//                   icon: Icons.phone_outlined,
//                   keyboardType: TextInputType.phone,
//                   maxLength: 10,
//                 ),
//                 const SizedBox(height: 20),

//                 if (_isOtpSent) ...[
//                   _buildInputField(
//                     controller: _otpController,
//                     hintText: 'Enter 6-digit OTP',
//                     icon: Icons.vpn_key_outlined,
//                     keyboardType: TextInputType.number,
//                     maxLength: 6,
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'OTP valid for $_otpTimer seconds',
//                     style: TextStyle(
//                       color: _otpTimer > 10 ? Colors.green : Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                 ],

//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed:
//                         _isOtpSent
//                             ? (_isVerifyButtonEnabled ? _handleLogin : null)
//                             : (_isSendOtpButtonEnabled ? _sendOtp : null),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           _isOtpSent
//                               ? (_isVerifyButtonEnabled
//                                   ? const Color(0xFFE55B5B)
//                                   : Colors.grey)
//                               : (_isSendOtpButtonEnabled
//                                   ? const Color(0xFFE55B5B)
//                                   : Colors.grey),
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       elevation: 8,
//                       shadowColor: const Color(0xFFE55B5B).withOpacity(0.4),
//                     ),
//                     child: Text(
//                       _isOtpSent ? 'Verify OTP' : 'Send OTP',
//                       style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 SizedBox(
//                   width: double.infinity,
//                   child: OutlinedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const HospitalScreen(),
//                         ),
//                       );
//                     },
//                     style: OutlinedButton.styleFrom(
//                       side: const BorderSide(
//                         color: Color(0xFF2C3E50),
//                         width: 2,
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     child: const Text(
//                       'Hospital Admin',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF2C3E50),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField({
//     required TextEditingController controller,
//     required String hintText,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//     int? maxLength,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         maxLength: maxLength,
//         decoration: InputDecoration(
//           hintText: hintText,
//           prefixIcon: Icon(icon, color: const Color(0xFFE55B5B), size: 24),
//           filled: true,
//           fillColor: Colors.transparent,
//           counterText: '',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 18,
//             horizontal: 16,
//           ),
//         ),
//         style: const TextStyle(fontSize: 18, color: Color(0xFF2C3E50)),
//       ),
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFEE8E8),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: Container(
//                 child: Center(child: Image.asset('assets/images/newlogo.png')),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Placeholder for other screens
// class UBloodHomePage extends StatelessWidget {
//   const UBloodHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Dashboard')),
//       body: const Center(child: Text('Welcome Back! ')),
//     );
//   }
// }

// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Sign Up')),
//       body: const Center(
//         child: Text('Welcome! Please sign up to create a new account.'),
//       ),
//     );
//   }
// }

// class HospitalScreen extends StatelessWidget {
//   const HospitalScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Hospital Admin Login')),
//       body: const Center(child: Text('This is the hospital admin login page.')),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:blood_link/lending_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateLoginButtonState);
    _passwordController.addListener(_updateLoginButtonState);
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateLoginButtonState);
    _passwordController.removeListener(_updateLoginButtonState);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateLoginButtonState() {
    setState(() {
      _isLoginButtonEnabled =
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  void _handleLogin(BuildContext context) {
    if (_isLoginButtonEnabled) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UBloodHomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both email and password.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFEE8E8), Color(0xFFFFFFFF)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/newlogo.png', height: 150),
                ),
                const SizedBox(height: 30),
                _buildInputField(
                  controller: _emailController,
                  hintText: 'Email address',
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _isLoginButtonEnabled
                            ? () => _handleLogin(context)
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isLoginButtonEnabled
                              ? const Color(0xFF2C3E50)
                              : Colors.grey,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      shadowColor: const Color(0xFF2C3E50).withOpacity(0.4),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 18, color: Color(0xFF2C3E50)),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to SignUpScreen
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE55B5B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: const Color(0xFFE55B5B), size: 24),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),
        ),
        style: const TextStyle(fontSize: 18, color: Color(0xFF2C3E50)),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEE8E8),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Image.asset('assets/images/newlogo.png'),
        ),
      ),
    );
  }
}
