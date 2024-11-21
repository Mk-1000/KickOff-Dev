import 'package:flutter/material.dart';
import 'package:takwira/presentation/managers/GameManager.dart';
import '../../business/services/StadiumService.dart';
import '../../domain/entities/Game.dart';
import '../../domain/entities/Stadium.dart';
import '../managers/StadiumManager.dart';

class StadiumListScreen extends StatefulWidget {
  final String gameId;

  StadiumListScreen({required this.gameId});

  @override
  _StadiumListScreenState createState() => _StadiumListScreenState();
}

class _StadiumListScreenState extends State<StadiumListScreen> {
  late StadiumManager _stadiumManager;
  late Future<List<Stadium>> _stadiumsFuture;
  String? _selectedStadiumId;

  @override
  void initState() {
    super.initState();
    _stadiumManager = StadiumManager(stadiumService: StadiumService());
    _stadiumsFuture = _stadiumManager.getAllStadiums();
    _loadSelectedStadium();
  }

  Future<void> _loadSelectedStadium() async {
    Game game = await GameManager().getGameDetails(widget.gameId);
    setState(() {
      _selectedStadiumId = game.stadiumId;
    });
  }

  Future<void> _selectStadium(String stadiumId) async {
    await GameManager().updateGameStadium(widget.gameId, stadiumId);
    setState(() {
      _selectedStadiumId = stadiumId;
    });
    Navigator.pop(context);
  }

  Future<void> _cancelSelection() async {
    await GameManager().cancelGameStadium(widget.gameId);
    setState(() {
      _selectedStadiumId = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Stadium'),
      ),
      body: FutureBuilder<List<Stadium>>(
        future: _stadiumsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No stadiums available'));
          }

          final stadiums = snapshot.data!;
          return ListView.builder(
            itemCount: stadiums.length,
            itemBuilder: (context, index) {
              final stadium = stadiums[index];
              final isSelected = stadium.stadiumId == _selectedStadiumId;
              return StadiumCard(
                stadium: stadium,
                onSelect: () => _selectStadium(stadium.stadiumId),
                onCancel: _cancelSelection,
                isSelected: isSelected,
              );
            },
          );
        },
      ),
    );
  }
}

class StadiumCard extends StatelessWidget {
  final Stadium stadium;
  final VoidCallback onSelect;
  final VoidCallback onCancel;
  final bool isSelected;

  const StadiumCard({
    Key? key,
    required this.stadium,
    required this.onSelect,
    required this.onCancel,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: isSelected ? Colors.blue[100] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stadium.name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            if (stadium.mainImage != null)
              Image.network(
                stadium.mainImage!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 8.0),
            Text('Address: ${stadium.address ?? 'N/A'}'),
            Text('Phone: ${stadium.phoneNumber}'),
            const SizedBox(height: 8.0),
            Text(
              'Fields:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            ...stadium.fields.map((field) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Field ID: ${field.fieldId}'),
                    Text('Capacity: ${field.capacity}'),
                    Text('Match Price: \$${field.matchPrice.toStringAsFixed(2)}'),
                    if (field.images.isNotEmpty)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: field.images.map((image) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.network(
                                image,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 8.0),
            Center(
              child: ElevatedButton(
                onPressed: isSelected ? onCancel : onSelect,
                child: Text(isSelected ? 'Cancel Selection' : 'Select Stadium'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
