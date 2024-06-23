import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/presentation/managers/InvitationManager.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';

class TeamDetailsPage extends StatefulWidget {
  final String teamId;

  TeamDetailsPage({required this.teamId});

  @override
  _TeamDetailsPageState createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  final TeamManager _teamManager = TeamManager();
  final PlayerManager _playerManager = PlayerManager();
  final InvitationManager _invitationManager = InvitationManager();
  Team? _team;
  int? _maxGoalkeepers;
  int? _maxDefenders;
  int? _maxMidfielders;
  int? _maxForwards;
  List<Player> _availablePlayers = [];

  @override
  void initState() {
    super.initState();
    _loadTeam();
    _loadPlayers();
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

  Future<void> _loadPlayers() async {
    try {
      List<Player> players = await _playerManager.getPlayers();
      setState(() {
        _availablePlayers = players;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load players: $e')),
        );
      }
    }
  }

  Future<void> _updateSlotLimits() async {
    try {
      await _teamManager.changeTeamSlotLimits(
        widget.teamId,
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

  void _invitePlayerToSlot(String slotId, Player player) async {
    try {
      if (_team != null && _team!.slots!.any((slot) => slot.slotId == slotId)) {
        // Check if the slot is available for invitation
        if (_team!.slots!.any((slot) =>
            slot.slotId == slotId && slot.status == SlotStatus.Available)) {
          await _invitationManager.sendInvitationToPlayer(
            playerId: player.playerId,
            slotId: slotId,
            teamId: _team!.teamId,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invitation sent to ${player.nickname}')),
          );

          setState(() {
            _team = _team!;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('This slot is not available for invitation')),
          );
        }
      } else {
        throw Exception('Team or slot not found');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send invitation: $e')),
      );
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
                  Text('player IDs: ${_team!.players.toString()}'),
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
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _team!.slots?.length,
                      itemBuilder: (context, index) {
                        String slotId = _team!.slots![index].slotId;
                        PositionSlot slot = _team!.slots![index];
                        return _buildSlotCard(slot);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSlotCard(PositionSlot slot) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Slot ${slot.number} - ${slot.position.toString().split('.').last}',
            ),
            Text('Status: ${slot.status.toString().split('.').last}'),
            if (slot.playerId != null) ...[
              Text('Player ID: ${slot.playerId}'),
            ] else ...[
              Text('No player assigned'),
              SizedBox(height: 10),
              Text('Invite Player:'),
              _buildPlayerDropdown(slot.slotId),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerDropdown(String slotId) {
    return DropdownButton<Player>(
      hint: Text('Select Player'),
      onChanged: (Player? player) {
        if (player != null) {
          _invitePlayerToSlot(slotId, player);
        }
      },
      items: _availablePlayers.map((Player player) {
        return DropdownMenuItem<Player>(
          value: player,
          child: Text(player.nickname),
        );
      }).toList(),
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
