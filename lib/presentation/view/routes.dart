import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/Home/home_page.dart';
import 'package:takwira/presentation/view/MatchDetails/MatchDetail.dart';
import 'package:takwira/presentation/view/Onbording/Onbording.dart';
import 'package:takwira/presentation/view/Profile/Profile.dart';
import 'package:takwira/presentation/view/SearchOponent/searchOponent.dart';
import 'package:takwira/presentation/view/login%20&%20sign%20up/completeSginup/completeSignup.dart';
import 'package:takwira/presentation/view/login%20&%20sign%20up/login.dart';
import 'package:takwira/presentation/view/StadeDetail/StadeDetails.dart';
import 'package:takwira/presentation/view/Stades/Stade.dart';
import 'package:takwira/domain/entities/Team.dart';

class Routes {
  static const String onboarding = '/onboarding';
  static const String searchOpponent = '/search-opponent';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String matches = '/matches';
  static const String terrainDetails = '/terrain-details';
  static const String terrainList = '/terrain-list';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      onboarding: (context) => const Onbording(),
      searchOpponent: (context) => const SearchOponent(),
      login: (context) => const Login(),
      signup: (context) => const CompleteSignup(),
      home: (context) => const HomePage(),
      profile: (context) => const Profile(),
      terrainDetails: (context) {
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        final stadiumId = args?['stadiumId'] as String?;

        return StadeDetails(
          showReservationButton: true,
          isReserved: true,
        );
      },
      terrainList: (context) => const Stades(),
      matches: (context) {
        final args = ModalRoute.of(context)?.settings.arguments;
        if (args is! Team) {
          throw ArgumentError('MatchDetails requires a Team argument');
        }
        return MatchDetails(team: args);
      },
    };
  }
}
