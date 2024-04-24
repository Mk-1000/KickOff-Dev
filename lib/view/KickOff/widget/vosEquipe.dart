import 'package:flutter/material.dart';
import 'package:takwira/view/MatchDetails/MatchDetail.dart';
import 'package:takwira/view/widgets/cards/vosEquipeCards.dart';
import 'package:takwira/view/widgets/forms/InputFild/search.dart';

class VosEquipe extends StatefulWidget {
  const VosEquipe({Key? key}) : super(key: key);

  @override
  State<VosEquipe> createState() => _VosEquipeState();
}

class _VosEquipeState extends State<VosEquipe> {
  final TextEditingController searchController = TextEditingController();
  static const int itemCount = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnimatedSearchBar(),
        Expanded(
          child: _buildAnimatedListView(),
        )
      ],
    );
  }

  Widget _buildAnimatedSearchBar() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, -50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Search(controller: searchController, hint: 'Recherche'),
    );
  }

  Widget _buildAnimatedListView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return _buildSlideFromBottomCard(index);
      },
    );
  }

  Widget _buildSlideFromBottomCard(int index) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + index * 200),
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 1, end: 0),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * value),
          child: Opacity(
            opacity: 1 - value,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
           Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MatchDetails()),
  );
        },
        child:  VosEquipeCard(
          name: 'Barcelona',
          photo: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSB7nXgavBhOElhzqVmf-9fI-j4n9K6LPplzuG7M3y0jA&s',
          place: 'Monastir, Tunisia',
           captine: true, postion: 'Milieu',
           id:index,
        ),
      ),
    );
  }
}
