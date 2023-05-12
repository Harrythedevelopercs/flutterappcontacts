import 'package:flutter/material.dart';

import '../../providers/app_providers.dart';
import '../../providers/widegtsproviders.dart';


class SearchBarInput extends StatelessWidget {
  const SearchBarInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      padding: EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppProviders.pimaryColorGreen,
      ),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 270,
            child: const TextField(
              decoration:  InputDecoration(
                  hintText: "Search Contacts Here",
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none
                  )
              ),
            ),
          ),
          Container(
              width: 50,
              child: BasicWidegtsProvider.MyIcons(Icons.search,null,Colors.white)
          )
        ],
      ),
    );
  }
}
