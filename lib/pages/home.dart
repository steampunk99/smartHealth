import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  static const List body = [
    Icon(Icons.home, size: 50,),
    Icon(Icons.message, size: 50,),
    Icon(Icons.schedule, size: 50,),
    Icon(Icons.settings, size: 50,),
  ];


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: body.elementAt(currentIndex);
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.message), label: 'Message'),
          NavigationDestination(icon: Icon(Icons.schedule), label: 'Schedule'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedIndex: currentIndex,
        onDestinationSelected: int(index){
          setState(() {
            currentIndex=index;
          });
        },
        
      ),
      
    );
  }
}
