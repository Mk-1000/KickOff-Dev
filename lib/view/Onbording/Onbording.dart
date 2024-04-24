import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takwira/view/Onbording/bloc/bloc/onbording_bloc.dart';
import 'package:takwira/view/Onbording/widget/body/body.dart';

class Onbording extends StatefulWidget {
  const Onbording({super.key});

  @override
  State<Onbording> createState() => OnbordingStat();
}

class OnbordingStat extends State<Onbording>  with TickerProviderStateMixin   {
   static OnbordingBloc TypeSwitcher = OnbordingBloc();
     late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 650),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body:  
         BlocBuilder<OnbordingBloc,OnbordingState>(
      bloc: TypeSwitcher,
        builder: (context, state) {
          if(state is OnbordingInitial ) {
            _controller.reset();
            _controller.forward();
            return  Container(
        margin: EdgeInsets.only(left: 24, right: 24),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.s,
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: size.height * 0.04, left: size.width * 0.27),
                  child: AutoSizeText(
                    textAlign: TextAlign.center,
                    'KickOff',
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
            AutoSizeText(
                    textAlign: TextAlign.center,
                    'Passer',
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Color(0xFF6D7289),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
              ],
            ),
            FadeTransition(
        opacity: _animation,
        child:  Body(img: state.img, text:state.text, title:state.title, postion: state.page,)),
           
      
         ],
        ),
      );
          }
          return  Container(
        margin: EdgeInsets.only(left: 24, right: 24),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.s,
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: size.height * 0.04, left: size.width * 0.27),
                  child: AutoSizeText(
                    textAlign: TextAlign.center,
                    'Kawer',
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
            AutoSizeText(
                    textAlign: TextAlign.center,
                    'Passer',
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                          color: Color(0xFF6D7289),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
              ],
            ),
            Body(img: 'assets/image/onbording1.png', text: 'Kawer est la première application pour gérer votre équipe et réserver vos places.', title: 'Vous voulez améliorer encore votre meilleur jeu ?', postion: 0,)
      
         ],
        ),
      ) ; 
        }),
    ));
  }
}
