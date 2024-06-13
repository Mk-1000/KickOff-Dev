import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/domain/entities/Team.dart';

class TeamSlotsPage extends StatelessWidget {
  final Team team;

  TeamSlotsPage({required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Slots'),
      ),
      body: ListView.builder(
        itemCount: team.slots.length,
        itemBuilder: (context, index) {
          var slot = team.slots[index];
          if (slot == null) return Container(); // Handle null slots
          return ListTile(
            title: Text('Slot ${slot.number}: ${slot.position}'),
            subtitle: Text('Status: ${slot.status}'),
            trailing: slot.status == SlotStatus.Reserved
                ? Text('Player: ${slot.playerId}')
                : null,
          );
        },
      ),
    );
  }
}
