import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_health/auth/auth.dart';
import 'package:smart_health/pages/messages.dart';
import 'package:smart_health/pages/schedule.dart';
import 'package:smart_health/pages/settings.dart';
import 'package:unicons/unicons.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  List<Widget> pages = [HomePage(), Messages(), Schedule(), Settings()];
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Hello You');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text("Sign Out"));
  }

  @override
  Widget build(BuildContext context) {
    List<String> symptoms = [
      '🤒Temperature',
      '🤧Snuffle',
      '🤕Vomiting',
      '🤕Nausea',
      '🤕Body weakness',
      '🤕Headache',
      '🤕Headache',
    ];

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Greeting and Name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Hello, ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Bonnie. L👋",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                      //Profile Picture
                      Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12)),
                          child: Image.asset(
                            "lib/assets/images/avatar.png",
                            fit: BoxFit.cover,
                          ))
                    ]),
              ),

              const SizedBox(
                height: 20,
              ),
              //card -> How do you feel
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.pink[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(children: [
                    //animation or cute picture
                    Container(
                      height: 150,
                      width: 150,
                      child: Image.asset(
                        "lib/assets/images/Diagnosis.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    // how do you feel + get started button
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "How do you feel?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text("Talk to a professional.",
                              style: TextStyle(fontSize: 14)),
                          const SizedBox(
                            height: 12,
                          ),
                          InkWell(
                            onTap: signOut,
                            child: Container(
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.deepPurple[300]),
                              child: const Center(
                                child: Text(
                                  "Book Appointment",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: null,
                        child: Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple[300],
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Icon(
                                      UniconsLine.medical_square,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  const Text(
                                    "Clinic Visit",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Make an appointment",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 170,
                        width: 170,
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurple[300],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Icon(
                                    UniconsLine.estate,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                const Text(
                                  "Home Visit",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Call the doctor home",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              ]),
                        ),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "What are your symptoms?",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.fast),
                        itemCount: symptoms.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Card(
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      symptoms[index],
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ))),
                          );
                        }),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Popular Doctors",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ),

                  //TO BE REFACTORED TO DISPLAY DYNAMICALLY
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 200,
                                width: 180,
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.asset(
                                            "lib/assets/images/avatar.png"),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Dr. Chris Frazier",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Pediatrician",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )),
                            Container(
                                height: 200,
                                width: 180,
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.asset(
                                            "lib/assets/images/avatar.png"),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Dr. Chris Frazier",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Pediatrician",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 200,
                                width: 180,
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.asset(
                                            "lib/assets/images/avatar.png"),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Dr. Chris Frazier",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Pediatrician",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )),
                            Container(
                                height: 200,
                                width: 180,
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border(),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.asset(
                                            "lib/assets/images/avatar.png"),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Dr. Chris Frazier",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Pediatrician",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white54,
        elevation: 2,
        destinations: const [
          NavigationDestination(
              icon: Icon(
                UniconsLine.estate,
              ),
              label: "Home"),
          NavigationDestination(
            icon: Icon(UniconsLine.envelopes),
            label: "Appointments",
          ),
          // NavigationDestination(
          //     icon: Icon(UniconsLine.schedule), label: "Schedule"),
          NavigationDestination(icon: Icon(UniconsLine.cog), label: "Profile"),
        ],
        selectedIndex: currentPage,
        onDestinationSelected: (int value) {
          setState(() {
            currentPage = value;
          });
        },
      ),
    );
  }
}
