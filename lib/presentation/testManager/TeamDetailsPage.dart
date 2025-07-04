import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/managers/InvitationManager.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';
import 'package:takwira/presentation/testManager/TeamListPage.dart';

import '../../domain/entities/Address.dart';
import '../managers/AddressManager.dart';
import 'GameDetailsPage.dart';

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
  final AddressManager _addressManager = AddressManager();

  Team? _team;
  Address? address;
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
      if (team.addressId != null) {
        address = await _addressManager.getAddressDetails(team.addressId!);
      }
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
      Team team = await _teamManager.getTeamById(widget.teamId);
      setState(() {
        _availablePlayers = players
            .where((player) => !team.players.contains(player.playerId))
            .toList();
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
      if (_team != null && _team!.slots.any((slot) => slot.slotId == slotId)) {
        if (_team!.slots.any((slot) =>
            slot.slotId == slotId && slot.status == SlotStatus.Available)) {
          await _invitationManager.sendInvitationFromTeamToPlayer(
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
        actions: [
          if (_team != null)
            _team!.currentGameId == null
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Navigate to players screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TeamListPage(
                                  homeTeamId: widget.teamId,
                                )),
                      );
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.stadium),
                    onPressed: () {
                      // Navigate to game details screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                GameDetailsPage(gameId: _team!.currentGameId!)),
                      );
                    },
                  ),
        ],
      ),
      body: _team == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Team Name: ${_team!.teamName}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Address: ${address?.country}, ${address?.state}, ${address?.city}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Team ID: ${_team!.teamId}'),
                  SizedBox(height: 10),
                  Text('Player IDs: ${_team!.players.toString()}'),
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _team!.slots?.length,
                    itemBuilder: (context, index) {
                      PositionSlot slot = _team!.slots![index];
                      return _buildSlotCard(slot);
                    },
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (slot.slotType == SlotType.Public) {
                        await _teamManager.updateSlotStatusToPrivate(
                            _team!.teamId, slot.slotId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Slot made Private')),
                        );
                      } else {
                        await _teamManager.updateSlotStatusToPublic(
                            _team!.teamId, slot.slotId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Slot made Public')),
                        );
                      }
                      setState(() {
                        _team = _team!;
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to update slot: $e')),
                      );
                    }
                  },
                  child: Text(
                    slot.slotType == SlotType.Public
                        ? 'Make Private'
                        : 'Make Public',
                  ),
                ),
              ],
            ),
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
