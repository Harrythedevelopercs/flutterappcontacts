import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../providers/app_providers.dart';

class ZeroResultScreen extends StatefulWidget {
  final dynamic callback;
  const ZeroResultScreen({Key? key,this.callback}) : super(key: key);

  @override
  State<ZeroResultScreen> createState() => _ZeroResultScreenState();
}

class _ZeroResultScreenState extends State<ZeroResultScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Lottie.network(
                "https://assets3.lottiefiles.com/packages/lf20_KOXhzYGQfb.json"),
            const Text(
              "No Contacts Found",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                widget.callback();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppProviders.pimaryColorGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.only(left: 35, right: 35)),
              child: const Text("Add Contact"),
            )
          ],
        ),
      ),
    );
  }


}
