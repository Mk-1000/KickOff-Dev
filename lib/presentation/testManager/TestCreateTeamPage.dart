import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Address.dart';
import 'package:takwira/domain/entities/Player.dart'; // Import the Player class
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';

import '../../utils/TunisiaLocations.dart';

class TestCreateTeamPage extends StatefulWidget {
  final Function(Team) onTeamCreated;

  TestCreateTeamPage({Key? key, required this.onTeamCreated}) : super(key: key);

  @override
  _TestCreateTeamPageState createState() => _TestCreateTeamPageState();
}

class _TestCreateTeamPageState extends State<TestCreateTeamPage> {
  final TeamManager _teamManager = TeamManager();
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _defenderCountController =
      TextEditingController();
  final TextEditingController _midfielderCountController =
      TextEditingController();
  final TextEditingController _forwardCountController = TextEditingController();

  String? selectedState;
  String? selectedCity;
  List<String> cities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _teamNameController,
              decoration: InputDecoration(labelText: 'Team Name'),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  hint: Text("Select State"),
                  value: selectedState,
                  items: TunisiaLocations.states.map((String state) {
                    return DropdownMenuItem<String>(
                      value: state,
                      child: Text(state),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedState = newValue;
                      selectedCity = null; // Reset city selection
                      cities = TunisiaLocations.citiesBystates[newValue!] ?? [];
                      // Debugging output
                      print('Selected state: $selectedState');
                      print('Cities: $cities');
                    });
                  },
                ),
                if (cities.isNotEmpty)
                  DropdownButton<String>(
                    hint: Text("Select City"),
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
                        // Debugging output
                        print('Selected city: $selectedCity');
                      });
                    },
                  ),
              ],
            ),
            TextField(
              controller: _defenderCountController,
              decoration:
                  InputDecoration(labelText: 'Number of Defenders per Team'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _midfielderCountController,
              decoration:
                  InputDecoration(labelText: 'Number of Midfielders per Team'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _forwardCountController,
              decoration:
                  InputDecoration(labelText: 'Number of Forwards per Team'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Parse input values
                int defenderCount =
                    int.tryParse(_defenderCountController.text) ?? 0;
                int midfielderCount =
                    int.tryParse(_midfielderCountController.text) ?? 0;
                int forwardCount =
                    int.tryParse(_forwardCountController.text) ?? 0;

                Address address = Address(
                  addressType: AddressType.TeamAddress,
                  city: selectedCity!,
                  state: selectedState!,
                  userId: Player.currentPlayer!.playerId,
                );
                // Create a new team using input values
                Team newTeam = Team(
                  teamName: _teamNameController.text,
                  captainId:
                      Player.currentPlayer!.playerId, // Current player's ID
                  maxDefenders: defenderCount,
                  maxMidfielders: midfielderCount,
                  maxForwards: forwardCount,
                );

                // Get the current player
                Player currentPlayer = Player.currentPlayer!;

                try {
                  // Call createTeamForPlayer method with the new team and current player
                  await _teamManager.createTeamForPlayer(
                      newTeam, address, currentPlayer);
                  widget.onTeamCreated(newTeam);
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to create team: $e'),
                  ));
                }
              },
              child: Text('Create Team'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _defenderCountController.dispose();
    _midfielderCountController.dispose();
    _forwardCountController.dispose();
    super.dispose();
  }
}
