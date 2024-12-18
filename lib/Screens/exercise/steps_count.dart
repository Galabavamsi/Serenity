import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:serenity_app/Screens/exercise/exercise.dart'; // Import the ExerciseScreen

class YogaExercisesScreen extends StatefulWidget {
  const YogaExercisesScreen({super.key});

  @override
  _YogaExercisesScreenState createState() => _YogaExercisesScreenState();
}

class _YogaExercisesScreenState extends State<YogaExercisesScreen> {
  final List<Map<String, String>> _yogaExercises = [
    {
      'name': 'Sun Salutation',
      'url': 'https://www.youtube.com/watch?v=1xRX1MuoImw',
    },
    {
      'name': 'Downward Dog',
      'url': 'https://www.youtube.com/watch?v=ayQoxw8sRTk',
    },
    {
      'name': 'Tree Pose',
      'url': 'https://www.youtube.com/watch?v=Fr5kiIygm0c',
    },
    {
      'name': 'Warrior Pose',
      'url': 'https://www.youtube.com/watch?v=uEc5hrgIYx4',
    },
    {
      'name': 'Child\'s Pose',
      'url': 'https://www.youtube.com/watch?v=nMp3MlTz9fA',
    },
    {
      'name': 'Cat-Cow Pose',
      'url': 'https://www.youtube.com/watch?v=vuyUwtHl694',
    },
    {
      'name': 'Bridge Pose',
      'url': 'https://www.youtube.com/watch?v=XUcAuYd7VU0',
    },
    {
      'name': 'Legs Up the Wall Pose',
      'url': 'https://www.youtube.com/watch?v=do_1LisFah0',
    },
    {
      'name': 'Seated Forward Bend',
      'url': 'https://www.youtube.com/watch?v=1mwwxcMDDy8',
    },
    {
      'name': 'Corpse Pose',
      'url': 'https://www.youtube.com/watch?v=1VYlOKUdylM',
    },
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredExercises = [];

  @override
  void initState() {
    super.initState();
    _filteredExercises = _yogaExercises;
    _searchController.addListener(_filterExercises);
  }

  void _filterExercises() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredExercises = _yogaExercises.where((exercise) {
        return exercise['name']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (uri.host.contains('youtube.com')) {
      final Uri youtubeUri = Uri.parse('vnd.youtube:${uri.queryParameters['v']}');
      if (await canLaunchUrl(youtubeUri)) {
        await launchUrl(youtubeUri, mode: LaunchMode.externalApplication);
        return;
      }
    }
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoga Exercises'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ExerciseScreen()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade50, Colors.purple.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Expanded(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: _filteredExercises.length,
                itemBuilder: (context, index, animation) {
                  return _buildItem(_filteredExercises[index], animation);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(Map<String, String> item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          title: Text(
            item['name']!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.play_arrow, color: Colors.purple),
            onPressed: () => _launchURL(item['url']!),
          ),
        ),
      ),
    );
  }
}