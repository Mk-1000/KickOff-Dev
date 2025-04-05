/// The Login class is a StatefulWidget that displays a login form with email and password fields, along
/// with options for forgot password, terms and conditions, and social media login buttons.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';
import 'package:takwira/presentation/view/GoogleNavBar/Navbar.dart';
import 'package:takwira/presentation/view/widgets/button/blueButton/BlueButton.dart';
import 'package:takwira/presentation/view/widgets/forms/InputFild/InputFild.dart';
import 'package:takwira/presentation/view/widgets/popups/Allpop.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

import 'completeSginup/completeSignup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passController = TextEditingController();
  bool isChecked = false;
  bool login = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Login() {
      if (login) {
        if (emailController.text != "" && passController.text != "") {
          Allpups.loading(context);

          PlayerManager()
              .signInWithEmailPassword(
                  emailController.text, passController.text)
              .then((value) {
            // Dismiss the loading indicator after the sign-in process finishes
            Navigator.of(context, rootNavigator: true).pop();

            if (value.isNotEmpty) {
              // Success: Navigate to the next screen (e.g., GoogleNavBar)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const GoogleNavBar()),
              );
            } else {
              // If no value returned (in case of failure), show error message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Failed to sign in."),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }).catchError((error) {
            // Dismiss the loading indicator in case of error
            Navigator.of(context, rootNavigator: true).pop();

            // If the future fails (in case of an exception), display the error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error
                    .toString()), // Display the error message from the exception
                backgroundColor: Colors.red,
              ),
            );
          });
        }
      } else {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const CompleteSignup(),
          ),
        );
        print("this is the sign up pressed ");
      }
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        reverse: false,
        child: Container(
          margin: const EdgeInsets.only(left: 24, right: 24),
          child: Column(children: [
            Container(
                margin: EdgeInsets.only(
                    top: size.height * 0.04, left: size.width * 0.03),
                child: AllText.Autotext(
                  color: Colors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  text: login ? "Bienvenue !" : 'Créez votre compte',
                )),
            Container(
                margin: const EdgeInsets.only(top: 8),
                child: AllText.Autotext(
                  color: const Color(0xFF6D7289),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  text: login
                      ? "Accédez à votre compte, invitez vos amis et réservez votre stade."
                      : 'Découvrez tous les avantages de nos services en créant votre compte',
                )),
            Container(
                margin: EdgeInsets.only(top: size.height * 0.05, bottom: 8),
                alignment: Alignment.topLeft,
                child: AllText.Autotext(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  text: "Email",
                )),
            inputFild(
              controller: emailController,
              hint: "Entrez votre email",
              size: size,
              obscureText: false,
            ),
            Container(
                margin: EdgeInsets.only(top: size.height * 0.03.h, bottom: 8.h),
                alignment: Alignment.topLeft,
                child: AllText.Autotext(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  text: "Mot de passe",
                )),
            inputFild(
              controller: passController,
              hint: "Entrez votre mot de passe",
              size: size,
              obscureText: true,
            ),
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Row(
                children: [
                  if (login) ...{
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 16.h, bottom: 8.h),
                        child: AllText.Autotext(
                          color: const Color(0xFF6485F4),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          text: "Mot de passe oublié ?",
                        ),
                      ),
                    )
                  } else ...{
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    AllText.Autotext(
                      color: const Color(0xFF6485F4),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      text: "J'accepte les ",
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: AllText.Autotext(
                        color: const Color(0xFF6485F4),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        text: "termes et conditions ",
                      ),
                    )
                  }
                ],
              ),
            ),
            BlueButton(
              onTap: Login,
              text: login ? "Se connecter" : "Create an account",
              outlindedbutton: false,
              width: size.width.w,
            ),
            Container(
              margin: EdgeInsets.only(top: 24.h),
              child: AllText.Autotext(
                  color: const Color(0xFF6D7289),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  text: "ou continuer avec"),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Image.asset(
                      "assets/image/google.png",
                      height: 20,
                      width: 20,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 22, right: 22),
                    alignment: Alignment.center,
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Image.asset(
                      "assets/image/facebook.png",
                      height: 20,
                      width: 20,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Image.asset(
                      "assets/image/apple.png",
                      height: 20,
                      width: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AllText.Autotext(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    text: login
                        ? "Vous n'avez pas de compte ?"
                        : "Vous avez un compte ?",
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {login = !login;});
                    },
                    child: AllText.Autotext(
                      color: const Color(0xFF6485F4),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      text: login ? " Inscrivez-vous" : ' Se connecter',
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
