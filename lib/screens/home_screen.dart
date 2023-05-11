import 'package:flutter/material.dart';

import '../providers/widegtsproviders.dart';
import '../widegts/HomeWidegts/contactlist.dart';
import '../widegts/HomeWidegts/header.dart';
import '../widegts/HomeWidegts/searchbar.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  providesomething(){
    return "Working";
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(

              height: 230,
              child: Stack(
                children: [
                  const Positioned(child:  Header()),
                  const Positioned(top: 170,child:  SearchBar(),),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.72,

              child: ContactList(),
            )

          ],
        ),
      ),
    );
  }
}
