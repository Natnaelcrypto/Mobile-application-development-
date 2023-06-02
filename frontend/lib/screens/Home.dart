import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/user/model/user_model.dart';
import '../LocalStroe/Store.dart';
import 'Drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Herd',
      home: HomePages(),
    );
  }
}

class HomePages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        title: const Text(
          'Herd Master',
          style: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Padding(
                padding: EdgeInsets.only(right: 2),
                child: Text(
                  '${UserPreferences.username}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  context.go("/editprofil");
                },
                icon: const Icon(Icons.person_2_outlined),
              ),
            ],
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color.fromRGBO(36, 130, 50, .6),
      ),
      drawer: Drawerpage(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              height: 200.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Header Text',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'A true herd master leads with patience and understanding, guiding their flock with wisdom and compassion.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: const Image(
                            image: AssetImage('assets/cow_and_calf.jpeg'))),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              height: 200.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                        child: const Image(
                            image: AssetImage('assets/cow_in_barn.jpeg'))),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Header Text',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'The mark of a skilled herd master is not just in their ability to control the animals, but in their ability to cultivate a sense of trust and harmony within the herd.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              height: 200.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Header Text',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'A herd master is a steward of the land and its creatures, working tirelessly to ensure the well-being and prosperity of their charges.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: const Image(
                            image: AssetImage('assets/man_in_barn.jpeg'))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            Container(
              color: Colors.grey[600],
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              height: 150,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Header Text',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Herd masters possess a unique connection with their animals, recognizing the individuality of each member and harnessing their collective strength to achieve greatness.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
