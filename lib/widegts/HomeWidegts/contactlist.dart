import 'package:contactsbar/providers/model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../providers/app_providers.dart';
import 'package:ussd_phone_call_sms/ussd_phone_call_sms.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactList extends StatefulWidget {
  ContactList({Key? key}) : super(key: key);

  final _ContactListState MyStatefullClass = _ContactListState();

  @override
  State<ContactList> createState() => _ContactListState();
  void printSample(){
    MyStatefullClass.addContact();
  }
}

class _ContactListState extends State<ContactList> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController phone = TextEditingController();
  final _ussdPhoneCallSmsPlugin = UssdPhoneCallSms();

  //Saving Contacts
  saveContact(String fname, String lname, String phone) {
    setState(() {
      DbModel.contacts.add({"f_name": fname, "l_name": lname, "phone": phone});
    });
  }

  //Add Contacts Sheet
   addContact() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(25),
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter Contact Details",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25)),
              SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Enter First Name"),
                controller: fname,
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Enter last Name"),
                controller: lname,
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                ),
                controller: phone,
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  saveContact(fname.text, lname.text, phone.text);
                  Navigator.pop(context);
                },
                child: Text("Save Contact"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppProviders.pimaryColorGreen),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> phoneCall(phone) async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      bool status = await Permission.phone.isDenied;
      if (status) {
        openAppSettings();
      }
      await _ussdPhoneCallSmsPlugin.phoneCall(phoneNumber: '${phone}') ??
          'Unknown platform version'; // phone number
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    var contacts = DbModel.contacts;
    int contactsCount = DbModel.contacts.length;
    if (contactsCount == 0) {
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
                  addContact();
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
    } else {
      return ListView.builder(
        itemCount: contactsCount,
        itemBuilder: (context, index) {
          var name = contacts[index]['f_name'];
          var phone = contacts[index]['phone'];
          return ListTile(
            leading: const CircleAvatar(
              radius: 35,
              backgroundColor: AppProviders.pimaryColorGreen,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            title: Text("${name}"),
            subtitle: Text("${phone}"),
            trailing: Container(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        phoneCall(phone);
                      },
                      icon: Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                    ),
                    radius: 20,
                    backgroundColor: AppProviders.pimaryColorGreen,
                  ),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chat_outlined,
                        color: Colors.white,
                      ),
                    ),
                    radius: 20,
                    backgroundColor: AppProviders.secondryColory,
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
