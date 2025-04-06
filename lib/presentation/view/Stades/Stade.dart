import 'package:flutter/material.dart';
import 'package:takwira/business/services/StadiumService.dart';
import 'package:takwira/domain/entities/Stadium.dart';
import 'package:takwira/presentation/managers/StadiumManager.dart';
import 'package:takwira/presentation/view/Home/widget/HomeAppBar.dart';
import 'package:takwira/presentation/view/widgets/button/dropDownButton/DropDownButton.dart';
import 'package:takwira/presentation/view/widgets/cards/stadeCard.dart';
import 'package:takwira/presentation/view/widgets/forms/InputFild/search.dart';

class Stades extends StatefulWidget {
  const Stades({Key? key}) : super(key: key);

  @override
  State<Stades> createState() => _StadesState();
}

class _StadesState extends State<Stades> {
  final TextEditingController searchController = TextEditingController();
  late StadiumManager _stadiumManager;
  late Future<List<Stadium>> _stadiums;

  @override
  void initState() {
    super.initState();
    _stadiumManager = StadiumManager(stadiumService: StadiumService());
    _stadiums = _stadiumManager.getAllStadiums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Search(controller: searchController, hint: 'Recherche'),
              const SizedBox(height: 8),
              Expanded(
                child: FutureBuilder<List<Stadium>>(
                  future: _stadiums,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No stadiums found'));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return StadeCard(
                          index: index,
                          stadium: snapshot.data![index],
                          borderBlue: false,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
