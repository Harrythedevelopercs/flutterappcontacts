import 'package:contactsbar/widegts/HomeWidegts/contactlist.dart';
import 'package:flutter/material.dart';
import '../../providers/app_providers.dart';
import '../../providers/widegtsproviders.dart';



class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContactList getfunction = ContactList();

    providesomething() {
      print("back button working");
    }

    return   Container(
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
                  fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
            ),
            Container(
              child: Row(
                children: [
                  BasicWidegtsProvider.MyIcons(
                      Icons.person_add_alt_1_rounded, getfunction.printSample),
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



