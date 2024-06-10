import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';

class TeamDetailsPage extends StatefulWidget {
  final String teamId;

  TeamDetailsPage({required this.teamId});

  @override
  _TeamDetailsPageState createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  final TeamManager _teamManager = TeamManager();
  Team? _team;
  int? _maxGoalkeepers;
  int? _maxDefenders;
  int? _maxMidfielders;
  int? _maxForwards;

  @override
  void initState() {
    super.initState();
    _loadTeam();
  }

  Future<void> _loadTeam() async {
    try {
      Team team = await _teamManager.getTeamById(widget.teamId);
      setState(() {
        _team = team;
        _maxGoalkeepers = team.maxGoalkeepers;
        _maxDefenders = team.maxDefenders;
        _maxMidfielders = team.maxMidfielders;
        _maxForwards = team.maxForwards;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load team: $e')),
        );
      }
    }
  }

  Future<void> _updateSlotLimits() async {
    try {
      await _teamManager.changeTeamSlotLimits(
        widget.teamId,
        newMaxGoalkeepers: _maxGoalkeepers,
        newMaxDefenders: _maxDefenders,
        newMaxMidfielders: _maxMidfielders,
        newMaxForwards: _maxForwards,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Team slot limits updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update team slot limits: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Details'),
      ),
      body: _team == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Team Name: ${_team!.teamName}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Team ID: ${_team!.teamId}'),
                  SizedBox(height: 10),
                  Text('Captain ID: ${_team!.captainId}'),
                  SizedBox(height: 20),
                  _buildSlotLimitField(
                    'Max Goalkeepers',
                    _maxGoalkeepers,
                    (value) => setState(() => _maxGoalkeepers = value),
                  ),
                  _buildSlotLimitField(
                    'Max Defenders',
                    _maxDefenders,
                    (value) => setState(() => _maxDefenders = value),
                  ),
                  _buildSlotLimitField(
                    'Max Midfielders',
                    _maxMidfielders,
                    (value) => setState(() => _maxMidfielders = value),
                  ),
                  _buildSlotLimitField(
                    'Max Forwards',
                    _maxForwards,
                    (value) => setState(() => _maxForwards = value),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateSlotLimits,
                    child: Text('Update Slot Limits'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSlotLimitField(
      String label, int? initialValue, ValueChanged<int?> onChanged) {
    return TextFormField(
      initialValue: initialValue?.toString(),
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      onChanged: (value) => onChanged(int.tryParse(value)),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:takwira/domain/entities/Team.dart';
// import 'package:takwira/presentation/managers/TeamManager.dart';
// import 'package:takwira/presentation/managers/PlayerManager.dart';
// import 'package:takwira/domain/entities/Player.dart';

// class TeamDetailsPage extends StatefulWidget {
//   final String teamId;

//   TeamDetailsPage({Key? key, required this.teamId}) : super(key: key);

//   @override
//   _TeamDetailsPageState createState() => _TeamDetailsPageState();
// }

// class _TeamDetailsPageState extends State<TeamDetailsPage> {
//   Team? team;
//   final TeamManager _teamManager = TeamManager();
//   final PlayerManager _playerManager = PlayerManager();
//   List<Player> availablePlayers = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchTeamDetails();
//     fetchAvailablePlayers();
//   }

//   void fetchTeamDetails() async {
//     try {
//       Team fetchedTeam = await _teamManager.getTeamById(widget.teamId);
//       setState(() {
//         team = fetchedTeam;
//       });
//     } catch (e) {
//       print('Error fetching team details: $e');
//       // Handle error appropriately
//     }
//   }

//   void fetchAvailablePlayers() async {
//     try {
//       List<Player> players = await _playerManager.getPlayers();
//       setState(() {
//         availablePlayers = players;
//       });
//     } catch (e) {
//       print('Error fetching available players: $e');
//       // Handle error appropriately
//     }
//   }

//   void _invitePlayer(Player player, String position, int placeNumber) async {
//     if (team != null) {
//       try {
//         await _teamManager.sendInvitation(
//             team!.teamId, player.playerId, position, placeNumber);
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Invitation sent to ${player.nickname}')));
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to send invitation: $e')));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Team Details'),
//       ),
//       body: team != null
//           ? Center(
//               child: Column(
//                 children: [
//                   Text('Team Name: ${team!.teamName}'),
//                   // Add more team details here
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: availablePlayers.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           child: ListTile(
//                             title: Text(availablePlayers[index].nickname),
//                             trailing: IconButton(
//                               icon: Icon(Icons.person_add),
//                               onPressed: () => _invitePlayer(
//                                   availablePlayers[index],
//                                   'defender',
//                                   index + 1),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }
