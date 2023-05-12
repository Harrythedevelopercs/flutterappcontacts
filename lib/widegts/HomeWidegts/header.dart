import 'package:contactsbar/widegts/HomeWidegts/contactlist.dart';
import 'package:flutter/material.dart';
import '../../providers/app_providers.dart';
import '../../providers/model.dart';
import '../../providers/widegtsproviders.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {


  @override
  Widget build(BuildContext context) {
    TextEditingController fname = TextEditingController();
    TextEditingController lname = TextEditingController();
    TextEditingController phone = TextEditingController();


    ContactList StatefulClassMethods = ContactList();
    StatefulClassMethods;

    providesomething() {
      print("back button working");
    }

    return Container(
      padding: const EdgeInsets.only(
          left: AppProviders.appScreenPadding,
          right: AppProviders.appScreenPadding),
      width: double.infinity,
      color: AppProviders.secondryColory,
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BasicWidegtsProvider.MyIcons(
                Icons.arrow_circle_left, providesomething),
            const Text(
              AppProviders.appName,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white),
            ),
            Container(
              child: Row(
                children: [
                  BasicWidegtsProvider.MyIcons(
                      Icons.person_add_alt_1_rounded, providesomething),
                  BasicWidegtsProvider.MyIcons(
                      Icons.settings, providesomething),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
