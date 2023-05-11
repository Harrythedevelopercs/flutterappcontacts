import 'package:flutter/material.dart';

import 'app_providers.dart';

class BasicWidegtsProvider{
   static MyIcons(var IconName,[dynamic callback , dynamic Color = AppProviders.pimaryColorGreen ]){
     return IconButton(onPressed: (){
       callback();
     }, icon:  Icon(
       IconName,
       color: Color,
       size: 32,
     ),);
   }
}