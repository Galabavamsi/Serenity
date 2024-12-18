import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:serenity_app/user_auth/firebase_auth_implementation/firebase_auth_services.dart'; // Import the FirebaseUserAuth class

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> with TickerProviderStateMixin {
  List<Map<String, dynamic>> entries = []; // List to hold diary entries with title and date
  final FirebaseUserAuth _authService = FirebaseUserAuth(); // Instance of FirebaseUserAuth

  @override
  void initState() {
    super.initState();
    _fetchEntries();
  }

  String categorizeEntry(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final difference = today.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference <= 7) {
      return 'Last 7 Days';
    } else if (difference <= 30) {
      return 'Last 30 Days';
    } else {
      return DateFormat('MMMM yyyy').format(date);
    }
  }

  void _fetchEntries() async {
    List<Map<String, dynamic>> fetchedEntries = await _authService.fetchDiaryEntries();
    setState(() {
      entries = fetchedEntries.map((entry) {
        final date = DateTime.parse(entry['date']);
        return {
          'id': entry['id'],
          'title': entry['title'],
          'date': entry['date'],
          'category': categorizeEntry(date),
        };
      }).toList();
    });
  }

  void addEntry() {
    _showEntryDialog();
  }

  void updateEntry(int index) {
    _showEntryDialog(entry: entries[index], index: index);
  }

  void deleteEntry(int index) async {
    await _authService.deleteDiaryEntry(entries[index]['id']!);
    setState(() {
      entries.removeAt(index);
    });
  }

  void _showEntryDialog({Map<String, dynamic>? entry, int? index}) {
    TextEditingController controller = TextEditingController(text: entry?['title'] ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(entry == null ? 'Add Entry' : 'Update Entry'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter your diary entry here...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  if (entry == null) {
                    // Add new entry
                    await _authService.addDiaryEntry(controller.text, DateTime.now().toString().split(' ')[0]);
                  } else if (index != null) {
                    // Update existing entry
                    await _authService.updateDiaryEntry(entries[index]['id']!, controller.text);
                  }
                  _fetchEntries();
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Map<String, List<Map<String, dynamic>>> categorizedEntries = {};
    for (var entry in entries) {
      categorizedEntries.putIfAbsent(entry['category'], () => []).add(entry);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade50,
        title: Text(
          'My Diary',
          style: TextStyle(fontFamily: 'SecondFont'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.pink.shade50,
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              width: screenWidth * 0.9,
              height: screenHeight * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: entries.isEmpty
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty.png', // Replace with your image path
                    height: 150,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No entries yet. Tap + to add one!',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              )
                  : AnimationLimiter(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: categorizedEntries.length,
                  itemBuilder: (context, index) {
                    final category = categorizedEntries.keys.elementAt(index);
                    final categoryEntries = categorizedEntries[category]!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink.shade200,
                          ),
                        ),
                        ...categoryEntries.map((entry) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.pink.shade100,
                                    child: Icon(Icons.book, color: Colors.white),
                                  ),
                                  title: Text(entry['title']!),
                                  subtitle: Text('Date: ${entry['date']}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit, color: Colors.blue),
                                        onPressed: () => updateEntry(entries.indexOf(entry)),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => deleteEntry(entries.indexOf(entry)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        Divider(color: Colors.grey.shade300, thickness: 1),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade200,
        onPressed: addEntry,
        child: Icon(Icons.add),
      ),
    );
  }
}