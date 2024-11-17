import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallExpert extends StatefulWidget {
  const CallExpert({super.key});

  @override
  _CallExpertState createState() => _CallExpertState();
}

class _CallExpertState extends State<CallExpert> {
  final List<Map<String, String>> experts = [
    {
      'name': 'Dr. Gajanand Kumawat',
      'phone': '9407900500',
      'image': 'assets/images/expert.png',
      'specialty': 'Psychiatrist',
    },
    {
      'name': 'Dr. Shivam Singh',
      'phone': '9407900511',
      'image': 'assets/images/expert.png',
      'specialty': 'Psychiatrist',
    },
    {
      'name': 'Dr. Paritosh',
      'phone': '9407900522',
      'image': 'assets/images/expert.png',
      'specialty': 'Counselor',
    },
    {
      'name': 'Dr. Ankit Rath',
      'phone': '9407900533',
      'image': 'assets/images/expert.png',
      'specialty': 'Neurologist',
    },
  ];

  List<Map<String, String>> filteredExperts = [];
  String searchQuery = "";
  String selectedSpecialty = "All";

  @override
  void initState() {
    super.initState();
    filteredExperts = experts; // Initialize with all experts
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredExperts = experts
          .where((expert) =>
          expert['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void updateFilter(String specialty) {
    setState(() {
      selectedSpecialty = specialty;
      filteredExperts = specialty == "All"
          ? experts
          : experts.where((expert) => expert['specialty'] == specialty).toList();
    });
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: Text(
          'Call an Expert',
          style: TextStyle(fontFamily: 'SecondFont', fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade100, Colors.pink.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Search Experts",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onChanged: updateSearch,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Text(
                    "Filter by Specialty:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    value: selectedSpecialty,
                    items: ["All", "Psychiatrist", "Counselor", "Neurologist"]
                        .map((specialty) => DropdownMenuItem(
                      value: specialty,
                      child: Text(specialty),
                    ))
                        .toList(),
                    onChanged: (value) => updateFilter(value!),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredExperts.length,
                itemBuilder: (context, index) {
                  return ExpertCard(
                    name: filteredExperts[index]['name']!,
                    phone: filteredExperts[index]['phone']!,
                    image: filteredExperts[index]['image']!,
                    specialty: filteredExperts[index]['specialty']!,
                    onCall: () => makePhoneCall(filteredExperts[index]['phone']!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpertCard extends StatefulWidget {
  final String name;
  final String phone;
  final String image;
  final String specialty;
  final VoidCallback onCall;

  const ExpertCard({super.key, 
    required this.name,
    required this.phone,
    required this.image,
    required this.specialty,
    required this.onCall,
  });

  @override
  _ExpertCardState createState() => _ExpertCardState();
}

class _ExpertCardState extends State<ExpertCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: isHovered
            ? [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 20,
            spreadRadius: 1,
          )
        ]
            : [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: 1,
          )
        ],
        gradient: LinearGradient(
          colors: isHovered
              ? [Colors.pink.shade100, Colors.pink.shade200]
              : [Colors.white, Colors.white],
        ),
      ),
      child: InkWell(
        onTap: widget.onCall,
        onHover: (hovering) {
          setState(() {
            isHovered = hovering;
          });
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(widget.image),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontFamily: 'SecondFont',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.specialty,
                    style: TextStyle(
                      fontFamily: 'SecondFont',
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Text(
                    widget.phone,
                    style: TextStyle(
                      fontFamily: 'SecondFont',
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.phone, color: Colors.green),
              onPressed: widget.onCall,
            ),
          ],
        ),
      ),
    );
  }
}
