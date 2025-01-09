import 'package:flutter/material.dart';
import 'package:mirai/mirai.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  Widget? body;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    getWidget();
  }

  getWidget() async {
    await Mirai.fromAssets("assets/screen.json", context).then((value) {
      setState(() {
        body = value;
      });
    });
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