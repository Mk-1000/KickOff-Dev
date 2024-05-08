import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:takwira/presentation/view/login%20&%20sign%20up/completeSginup/widget/postion.dart';
import 'package:takwira/presentation/view/widgets/button/blueButton/BlueButton.dart';
import 'package:takwira/presentation/view/widgets/forms/InputFild/InputFild.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';


import 'bloc/bloc/complete_signup_bloc.dart';

class CompleteSignup extends StatefulWidget {
  const CompleteSignup({super.key});

  @override
  State<CompleteSignup> createState() => _CompleteSignupStateState();
}

class _CompleteSignupStateState extends State<CompleteSignup> {
  List<String> taille = ["S", "M", "L"];
  TextEditingController NameController = TextEditingController();
  TextEditingController UserNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  static CompleteSignupBloc completeSignup = CompleteSignupBloc();
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Container(
          margin: const EdgeInsets.only(left: 24, right: 24),
          child: BlocBuilder<CompleteSignupBloc, CompleteSignupState>(
              bloc: completeSignup,
              builder: (context, state) {
                if (state is CompleteSignupInitial) {
                  return body(state, size);
                }
                return Container();
              })),
    ));
    ;
  }

  Widget body(CompleteSignupInitial state, Size size) {
    return Column(children: [
      Container(
        margin: EdgeInsets.only(top: size.height * 0.03, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AllText.Autotext(
                text: "Étape ${state.page + 1}",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            AllText.Autotext(
                text: "${((state.page + 2) * 2) * 10}%",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 26),
        height: 4,
        width: size.width,
        child: LinearProgressIndicator(
          color: const Color(0xFF3053EC),
          backgroundColor: const Color(0xFFE3E5E5),
          value: ((((state.page + 2) * 2) * 10) / 100).toDouble(),
          semanticsLabel: 'Linear progress indicator',
        ),
      ),
      Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: AllText.Autotext(
              text: "Fournir vos coordonnées.",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black)),
      Container(
          margin: const EdgeInsets.only(bottom: 26),
          child: AllText.Autotext(
              text:
                  "Ces détails nous permettront de créer un profil professionnel pour vous.",
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF6D7289))),
      if (state.page == 0) ...{
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 8),
            child: AllText.Autotext(
                text: "Nom et Prénom",
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black)),
        Container(
            margin: const EdgeInsets.only(bottom: 16),
            alignment: Alignment.topLeft,
            //  margin: EdgeInsets.only(bottom: 26),
            child: inputFild(
              controller: NameController,
              hint: 'Entrez votre nom et prénom',
              obscureText: false,
              size: size,
            )),
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 8),
            child: AllText.Autotext(
                text: "Nom d'utilisateur",
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black)),
        Container(
            margin: const EdgeInsets.only(bottom: 16),
            alignment: Alignment.topLeft,
            //  margin: EdgeInsets.only(bottom: 26),
            child: inputFild(
              controller: UserNameController,
              hint: 'Entrez votre nom d\'utilisateur',
              obscureText: false,
              size: size,
            )),
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 8),
            child: AllText.Autotext(
                text: "Votre région",
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black)),
        Container(
            margin: const EdgeInsets.only(bottom: 16),
            alignment: Alignment.topLeft,
            //  margin: EdgeInsets.only(bottom: 26),
            child: inputFild(
              controller: UserNameController,
              hint: "Sélectionnez votre région",
              obscureText: false,
              size: size,
            )),
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 8),
            child: AllText.Autotext(
                text: "Téléphone",
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black)),
        Container(
            margin: const EdgeInsets.only(bottom: 16),
            alignment: Alignment.topLeft,
            //  margin: EdgeInsets.only(bottom: 26),
            child: inputFild(
              controller: UserNameController,
              hint: 'Entrez votre nom d\'utilisateur',
              obscureText: false,
              size: size,
            )),
      } else if (state.page == 1) ...{
        Container(
          margin: const EdgeInsets.only(bottom: 36, top: 32),
          width: 300,
          height: 270,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF3053EC), width: 3.0),
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          child: ScrollDatePicker(
            selectedDate: _selectedDate,
            locale: const Locale('en'),
            onDateTimeChanged: (DateTime value) {
              setState(() {
                _selectedDate = value;
              });
            },
          ),
        )
      } else if (state.page == 2) ...{
        Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: AllText.Autotext(
                text: "Choisissez votre Position",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF72777A))),
        Stack(
          children: [
            Image.asset(
              "assets/image/stade.png",
              fit: BoxFit.contain,
            ),
            const Postion(),
          ],
        ),
      } else if (state.page == 3) ...{
        Image.asset(
          "assets/image/dossard.png",
          height: 200,
          width: 200,
        ),
        Container(
          margin: EdgeInsets.only(top: 8,bottom: 30),
          child:        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < taille.length; i++) ...{
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 8,right:8),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                    child: AllText.Autotext(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14, text: taille[i]),
              )
            },
          ],
        )
           ),

      },
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlueButton(
            onTap: () {
              completeSignup.add(retour(state.page));
            },
            text: 'Retour',
            outlindedbutton: true,
            width: 115,
          ),
          BlueButton(
            onTap: () {
              completeSignup.add(changePage(state.page));
            },
            text: 'Suivant',
            width: 115,
            outlindedbutton: false,
          ),
        ],
      )
    ]);
  }
}
