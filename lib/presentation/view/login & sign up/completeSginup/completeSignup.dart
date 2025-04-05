import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';
import 'package:takwira/presentation/view/login%20&%20sign%20up/completeSginup/widget/postion.dart';
import 'package:takwira/presentation/view/login%20&%20sign%20up/login.dart';
import 'package:takwira/presentation/view/widgets/button/blueButton/BlueButton.dart';
import 'package:takwira/presentation/view/widgets/forms/InputFild/InputFild.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';
import '../../../../utils/TunisiaLocations.dart';

import '../../../../domain/entities/Address.dart';
import 'bloc/bloc/complete_signup_bloc.dart';

class CompleteSignup extends StatefulWidget {
  const CompleteSignup({super.key});

  @override
  State<CompleteSignup> createState() => _CompleteSignupStateState();
}

class _CompleteSignupStateState extends State<CompleteSignup> {
  List<String> tailles = ["S", "M", "L"];
  bool _isLoading = false;
  String? _selectedSize;
  TextEditingController NameController = TextEditingController();
  TextEditingController UserNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  static CompleteSignupBloc completeSignup = CompleteSignupBloc();
  DateTime _selectedDate = DateTime.now();
  String? selectedState;
  String? selectedCity;
  List<String> states = TunisiaLocations.states;
  List<String> cities = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin:
                const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
            child: BlocBuilder<CompleteSignupBloc, CompleteSignupState>(
              bloc: completeSignup,
              builder: (context, state) {
                if (state is CompleteSignupInitial) {
                  return body(state, size);
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget body(CompleteSignupInitial state, Size size) {
    return Column(
      children: [
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
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              child: AllText.Autotext(
                  text: "Gouvernorat",
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(
                "Sélectionnez un gouvernorat",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: selectedState,
              items: states.map((String state) {
                return DropdownMenuItem<String>(
                  value: state,
                  child: Text(state),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedState = newValue;
                  selectedCity = null;
                  cities = TunisiaLocations.citiesBystates[newValue] ?? [];
                });
              },
              underline: const SizedBox(),
            ),
          ),
          if (selectedState != null) ...{
            Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: AllText.Autotext(
                    text: "Ville",
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  "Sélectionnez une ville",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: selectedCity,
                items: cities.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCity = newValue;
                  });
                },
                underline: const SizedBox(),
              ),
            ),
          },
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 8, bottom: 8),
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
                controller: phoneController,
                hint: 'Entrez votre numéro de téléphone',
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
        } else if (state.page == 3) ...[
          Image.asset(
            "assets/image/dossard.png",
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 20),
          const Text(
            "Choisissez votre taille de maillot",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (String taille in tailles)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSize = taille;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: _selectedSize == taille
                          ? Colors.blue
                          : Colors.transparent,
                      border: Border.all(
                        width: 1,
                        color:
                            _selectedSize == taille ? Colors.blue : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      taille,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _selectedSize == taille
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlueButton(
              onTap: () {
                completeSignup.add(retour(state.page, context));
              },
              text: 'Retour',
              outlindedbutton: true,
              width: 115,
            ),
            BlueButton(
              onTap: () async {
                if (state.page == 3) {
                  if (_selectedSize == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Veuillez sélectionner une taille de maillot"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  setState(() {
                    _isLoading = true;
                  });
                  String? errorMessage = await PlayerManager().signUpPlayer(
                    LoginState.emailController.text,
                    LoginState.passController.text,
                    Address(
                      addressType: AddressType.PlayerAddress,
                      city: selectedCity ?? "Inconnu",
                      state: selectedState ?? "Inconnu",
                    ),
                    Player(
                      email: LoginState.emailController.text,
                      nickname: UserNameController.text,
                      birthdate: _selectedDate,
                      preferredPosition:
                          Position.values[PostionState.selected!],
                      phoneNumber: phoneController.text,
                      jerseySize: _selectedSize!,
                    ),
                  );
                  setState(() {
                    _isLoading = false;
                  });
                  if (errorMessage != null) {
                    // Afficher un message d'erreur
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Erreur d'inscription verifier vos informations"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Afficher un message de succès
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Inscription réussie ! Bienvenue 🎉"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pushReplacement<void, void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const Login(),
                    ),
                  );
                }

                completeSignup.add(changePage(state.page));
              },
              text: 'Suivant',
              width: 115,
              outlindedbutton: false,
            ),
          ],
        ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
