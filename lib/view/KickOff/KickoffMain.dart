import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:takwira/view/CreateTeam/CreateTeamMain.dart';
import 'package:takwira/view/Home/widget/HomeAppBar.dart';
import 'package:takwira/view/KickOff/widget/rechrcheEquipe.dart';
import 'package:takwira/view/KickOff/widget/vosEquipe.dart';

class KickOff extends StatefulWidget {
  const KickOff({Key? key}) : super(key: key);

  @override
  State<KickOff> createState() => _KickOffState();
}

class _KickOffState extends State<KickOff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      floatingActionButton: _buildFloatingActionButton(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: _buildTabBarView(),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateTeam()),
      ),
      child: const Icon(Icons.add),
    );
  }

  Widget _buildTabBarView() {
    return ContainedTabBarView(
      tabBarProperties: TabBarProperties(
        labelStyle: GoogleFonts.rubik(
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey,
      ),
      tabs: const [
        Text("Vos équipes"),
        Text("Recherche d'équipe"),
      ],
      views: [
        VosEquipe(),
        // Container(color: Colors.green), // Replace with actual team search view
        RechercheEquipe()
      ],
      onChange: (index) => print('Selected index: $index'),
    );
  }
}
