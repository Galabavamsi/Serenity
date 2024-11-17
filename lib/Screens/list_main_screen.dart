import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> with TickerProviderStateMixin {
  List<Map<String, String>> entries = []; // List to hold diary entries with title and date

  void addEntry() {
    _showEntryDialog();
  }

  void updateEntry(int index) {
    _showEntryDialog(entry: entries[index], index: index);
  }

  void deleteEntry(int index) {
    setState(() {
      entries.removeAt(index);
    });
  }

  void _showEntryDialog({Map<String, String>? entry, int? index}) {
    TextEditingController controller =
    TextEditingController(text: entry?['title'] ?? "");

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
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    if (entry == null) {
                      // Add new entry
                      entries.add({
                        'title': controller.text,
                        'date': DateTime.now().toString().split(' ')[0], // Current date
                      });
                    } else if (index != null) {
                      // Update existing entry
                      entries[index] = {
                        'title': controller.text,
                        'date': entry['date']!,
                      };
                    }
                  });
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
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
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
                                  onPressed: () => updateEntry(index),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => deleteEntry(index),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
