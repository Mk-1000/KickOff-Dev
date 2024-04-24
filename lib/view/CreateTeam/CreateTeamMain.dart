import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takwira/view/CreateTeam/widget/CircleNumber.dart';
import 'package:takwira/view/CreateTeam/widget/avatarPhoto/AvatarCreateTeam';
import 'package:takwira/view/widgets/CounterInput/CounterInput.dart';
import 'package:takwira/view/widgets/StadeWidget/Stade.dart';
import 'package:takwira/view/widgets/button/blueButton/BlueButton.dart';
import 'package:takwira/view/widgets/forms/InputFild/InputFild.dart';
import 'package:takwira/view/widgets/text/text.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({Key? key}) : super(key: key);

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam>
    with SingleTickerProviderStateMixin {
  TextEditingController name = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).shadowColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AllText.Autotext(
            text: "Constituez votre équipe",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).shadowColor),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _animatedElement(
              Center(
                  child: ProfileAvatar(
                      onEdit: () {},
                      imageUrl:
                          'https://scontent.ftun9-1.fna.fbcdn.net/v/t39.30808-6/359720469_2280846032106939_5652556424780514616_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=_Vgx18VhCYYAX9mr0AF&_nc_ht=scontent.ftun9-1.fna&oh=00_AfA__25Mi-SIlTxreO5XsFPFE7gWYvnorMrAuPcvhQNb3A&oe=660A495E')),
            ),
            const SizedBox(height: 16),
            _animatedElement(
              inputFild(
                controller: name,
                hint: "Entrez votre nom d'équipe",
                size: MediaQuery.of(context).size,
              ),
            ),
            const SizedBox(height: 24),
            _animatedElement(
              AllText.Autotext(
                  text: "Nombre d'équipes",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).shadowColor),
            ),
            const SizedBox(height: 8),
            _animatedElement(
              CounterInput(width: double.infinity, height: 48, iconSize: 20),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _animatedElement(_buildCounter("Défenseur")),
                _animatedElement(_buildCounter("Milieu")),
                _animatedElement(_buildCounter("Attaquant")),
              ],
            ),
            const SizedBox(height: 8),
            _animatedElement(
             Stade(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlueButton(
                  onTap: () {},
                  text: "Accepter",
                  width: 115,
                  outlindedbutton: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _animatedElement(Widget child) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: child,
      ),
    );
  }

  Widget _buildCounter(String title) {
    return Column(
      children: [
        AllText.Autotext(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).shadowColor),
        const SizedBox(height: 8),
        CounterInput(width: 111, height: 38, iconSize: 17),
      ],
    );
  }
}
