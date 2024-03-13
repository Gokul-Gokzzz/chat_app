import 'package:auth/controller/bottom_bar_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
          child: Container(
            height: 70,
            width: double.infinity,
            child: Consumer<BottomBarProvider>(
              builder: (context, value, child) => ListView.builder(
                itemCount: value.data.length,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (Context, Index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () async {
                      value.selectedIndex = Index;
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      width: 35,
                      decoration: BoxDecoration(
                        border: Index == value.selectedIndex
                            ? Border(
                                top:
                                    BorderSide(width: 3.0, color: Colors.white))
                            : null,
                        gradient: Index == value.selectedIndex
                            ? LinearGradient(
                                colors: [Colors.grey.shade800, Colors.black],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)
                            : null,
                      ),
                      child: Icon(
                        value.data[Index],
                        size: 35,
                        color: Index == value.selectedIndex
                            ? Colors.white
                            : Colors.grey.shade800,
                      ),
                    ),
                  ),
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
