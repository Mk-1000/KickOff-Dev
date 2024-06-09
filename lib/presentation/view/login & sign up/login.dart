/// The Login class is a StatefulWidget that displays a login form with email and password fields, along
/// with options for forgot password, terms and conditions, and social media login buttons.
import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/GoogleNavBar/Navbar.dart';
import 'package:takwira/presentation/view/widgets/button/blueButton/BlueButton.dart';
import 'package:takwira/presentation/view/widgets/forms/InputFild/InputFild.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';


import 'completeSginup/completeSignup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isChecked = false;
  bool login = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Login() {
      if (login) {
      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  GoogleNavBar()),
  );
      } else {
          Navigator.pushReplacement<void, void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => const CompleteSignup (),
    ),
  );
        print("this is the sgin up pressed ");
      }
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          margin: const EdgeInsets.only(left: 24, right: 24),
          child: Column(children: [
            Container(
                margin: EdgeInsets.only(
                    top: size.height * 0.04, left: size.width * 0.03),
                child: AllText.Autotext(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  text: login ? "Bienvenue !" : 'Créez votre compte',
                )),
            Container(
                margin: const EdgeInsets.only(top: 8),
                child: AllText.Autotext(
                  color: const Color(0xFF6D7289),
                  fontSize: 16,
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
                  fontSize: 16,
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
                margin: EdgeInsets.only(top: size.height * 0.03, bottom: 8),
                alignment: Alignment.topLeft,
                child: AllText.Autotext(
                  color: Colors.black,
                  fontSize: 16,
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
              margin: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  if (login) ...{
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 8),
                        child: AllText.Autotext(
                          color: const Color(0xFF6485F4),
                          fontSize: 16,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      text: "J'accepte les ",
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: AllText.Autotext(
                        color: const Color(0xFF6485F4),
                        fontSize: 16,
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
              text: login ? "Se connecter" : "Create an account", outlindedbutton: false, width: size.width,
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: AllText.Autotext(
                  color: const Color(0xFF6D7289),
                  fontSize: 16,
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
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    text: login
                        ? "Vous n'avez pas de compte ?"
                        : "Vous avez un compte ?",
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() => {login = !login});
                    },
                    child: AllText.Autotext(
                      color: const Color(0xFF6485F4),
                      fontSize: 14,
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
    )
    );
  }
}
