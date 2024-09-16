import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/domain/entities/Address.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';
import 'package:takwira/presentation/view/CreateTeam/bloc/bloc/create_team_bloc.dart';
import 'package:takwira/presentation/view/CreateTeam/widget/avatarPhoto/AvatarCreateTeam';
import 'package:takwira/presentation/view/KickOff/widget/blocVosEquipe/bloc/vos_equipe_bloc.dart';
import 'package:takwira/presentation/view/KickOff/widget/vosEquipe.dart';
import 'package:takwira/presentation/view/widgets/CounterInput/CounterInput.dart';
import 'package:takwira/presentation/view/widgets/StadeWidget/Stade.dart';
import 'package:takwira/presentation/view/widgets/button/blueButton/BlueButton.dart';
import 'package:takwira/presentation/view/widgets/forms/InputFild/InputFild.dart';
import 'package:takwira/presentation/view/widgets/popups/Allpop.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class CreateTeam extends StatefulWidget {
  static CreateTeamBloc CreateTeamController = CreateTeamBloc();
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
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).shadowColor),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<CreateTeamBloc, CreateTeamState>(
            bloc: CreateTeam.CreateTeamController,
            builder: (context, state) {
              if (state is CreateTeamInitial) {
                return Container(
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
                      SizedBox(height: 16.h),
                      _animatedElement(
                        inputFild(
                          controller: name,
                          hint: "Entrez votre nom d'équipe",
                          size: MediaQuery.of(context).size,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Column(
                        children: [
                          _animatedElement(
                              _buildCounter("Défenseur", state.defender)),
                          SizedBox(height: 16.h),
                          _animatedElement(
                              _buildCounter("Milieu", state.midle)),
                          SizedBox(height: 16.h),
                          _animatedElement(
                              _buildCounter("Attaquant", state.attacker)),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      _animatedElement(
                        Stade(
                          defender: state.defender,
                          mid: state.midle,
                          attack: state.attacker,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlueButton(
                            onTap: () async {
                              if (name.text != "") {
                                Allpups.loading(context);
                                await TeamManager().createTeamForPlayer(
                                    Team(
                                        teamName: name.text,
                                        captainId:
                                            Player.currentPlayer!.playerId,
                                        maxDefenders: state.defender,
                                        maxForwards: state.attacker,
                                        maxMidfielders: state.midle),
                                    Address(
                                      addressType: AddressType.TeamAddress,
                                      city: "city",
                                      state: "state",
                                    ),
                                    Player.currentPlayer!);

                                VosEquipe.VosEquipeController.add(loadData());
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }
                            },
                            text: "Accepter",
                            width: 110.w,
                            outlindedbutton: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return Container();
            }),
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

  Widget _buildCounter(String title, int counter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AllText.Autotext(
            text: title,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).shadowColor),
        SizedBox(height: 8.h),
        CounterInput(
          width: 111.w,
          height: 38.h,
          iconSize: 17.sp,
          counter: counter,
          titre: title,
        ),
      ],
    );
  }
}
