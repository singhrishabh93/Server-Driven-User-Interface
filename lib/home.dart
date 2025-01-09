import 'package:flutter/material.dart';
import 'package:mirai/mirai.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  Widget? body;
  late AnimationController _controller;
  late Animation<double> _animation;

  // URL to fetch the JSON from
  final String jsonUrl = "https://raw.githubusercontent.com/singhrishabh93/Server-Driven-User-Interface/refs/heads/main/assets/screen.json"; // Replace with your actual URL

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    fetchJsonData(); // Call to fetch the JSON data
  }

  // Function to fetch the JSON data from the URL
  Future<void> fetchJsonData() async {
    try {
      final response = await http.get(Uri.parse(jsonUrl));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final jsonData = jsonDecode(response.body);

        // Use Mirai to load the JSON data
        setState(() {
          body = Mirai.fromJson(jsonData, context);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching JSON: $e");
      setState(() {
        body = const Center(child: Text("Failed to load content"));
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body == null
          ? const Center(child: CircularProgressIndicator())
          : FadeTransition(
              opacity: _animation,
              child: body,
            ),
    );
  }
}
