import 'dart:async';

import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Invitation.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/presentation/managers/InvitationManager.dart';
import 'package:takwira/presentation/managers/PlayerManager.dart';

class PlayerInvitationPage extends StatefulWidget {
  final String playerId;

  const PlayerInvitationPage({Key? key, required this.playerId}) : super(key: key);

  @override
  _PlayerInvitationPageState createState() => _PlayerInvitationPageState();
}

class _PlayerInvitationPageState extends State<PlayerInvitationPage> {
  final InvitationManager _invitationManager = InvitationManager();
  final PlayerManager _playerManager = PlayerManager();
  late Future<Player> _playerFuture;

  @override
  void initState() {
    super.initState();
    _playerFuture = _getPlayer(widget.playerId);
  }

  Future<Player> _getPlayer(String playerId) async {
    return await _playerManager.getPlayerDetails(playerId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Player>(
      future: _playerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Invitations')),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Invitations')),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Invitations')),
            body: const Center(child: Text('Player not found')),
          );
        } else {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Invitations'),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Received'),
                    Tab(text: 'Sent'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  _buildReceivedInvitations(snapshot.data!),
                  _buildSentInvitations(snapshot.data!),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildReceivedInvitations(Player player) {
    return FutureBuilder<List<Invitation>>(
      future:
          _invitationManager.fetchReceivedInvitationsForPlayer(player.playerId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No received invitations.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Invitation invitation = snapshot.data![index];
              return ListTile(
                title: Text('Team: ${invitation.teamId}'),
                subtitle: Text('Invitation ID: ${invitation.invitationId}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () => _respondToInvitation(invitation, true),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => _respondToInvitation(invitation, false),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildSentInvitations(Player player) {
    return FutureBuilder<List<Invitation>>(
      future: _invitationManager.fetchSentInvitationsForPlayer(player.playerId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No sent invitations.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Invitation invitation = snapshot.data![index];
              return ListTile(
                title: Text('Team: ${invitation.teamId}'),
                subtitle: Text('Invitation ID: ${invitation.invitationId}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _removeSentInvitation(invitation),
                ),
              );
            },
          );
        }
      },
    );
  }

  void _respondToInvitation(Invitation invitation, bool accept) async {
    try {
      await _invitationManager.respondToInvitation(
          invitation.invitationId, accept);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Invitation ${accept ? 'accepted' : 'declined'}')),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to respond to invitation: $e')),
      );
    }
  }

  void _removeSentInvitation(Invitation invitation) async {
    try {
      await _invitationManager.removeInvitation(invitation.invitationId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invitation removed')),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove invitation: $e')),
      );
    }
  }
}
