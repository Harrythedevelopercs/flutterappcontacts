import 'package:contactsbar/providers/model.dart';
import 'package:contactsbar/widegts/HomeWidegts/zeroresults.dart';
import 'package:flutter/material.dart';
import '../../providers/app_providers.dart';
import 'package:ussd_phone_call_sms/ussd_phone_call_sms.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactList extends StatefulWidget {
  final dynamic callback;
  const ContactList({Key? key, this.callback}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
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
      const snackBar = SnackBar(
        content: Text('Contact Created'),
        animation: AlwaysStoppedAnimation(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  //Update Contact
  updateContact(int index, String fname, String lname, String phone) {
    setState(() {
      DbModel.contacts[index] = {
        "f_name": fname,
        "l_name": lname,
        "phone": phone
      };
      const snackBar = SnackBar(
        content: Text('Contact Updated'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  //Edit Contact Sheet
  editContact(var index, String fname_v, String lname_v, String phone_v) {
    fname.text = fname_v;
    lname.text = lname_v;
    phone.text = phone_v;

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
             const Text("Enter Contact Details",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25)),
              const SizedBox(
                height: 15,
              ),
               TextField(
                decoration: InputDecoration(hintText: "${fname_v}"),
                controller: fname,
              ),
              const  SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(hintText: "${lname_v}"),
                controller: lname,
              ),
              const  SizedBox(
                height: 5,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "${phone_v}",
                ),
                controller: phone,
              ),
             const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      updateContact(index, fname.text, lname.text, phone.text);
                      Navigator.pop(context);
                    },
                    child: Text("Save Contact"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppProviders.pimaryColorGreen),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      deleteContact(index);
                      Navigator.pop(context);
                    },
                    child: Text("Delete Contact"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent),
                  ),
                ],
              ),
            ],
          ),
        );

      },
    );
  }

  deleteContact(var index){
    setState((){
      DbModel.contacts.removeAt(index);
      const snackBar = SnackBar(
        content: Text('Contact Delete'),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

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
      return ZeroResultScreen(callback: addContact);
    } else {
      return ListView.builder(
        itemCount: contactsCount,
        itemBuilder: (context, index) {
          var name = contacts[index]['f_name'];
          var lname = contacts[index]['l_name'];
          var phone = contacts[index]['phone'];
          return ListTile(
            onTap: (){
              editContact(index, name, lname, phone);
            },
            leading: CircleAvatar(
              radius: 35,
              backgroundColor: AppProviders.pimaryColorGreen,
              child: GestureDetector(
                onTap: () {
                  editContact(index, name, lname, phone);
                },
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text("${name} ${lname}"),
            subtitle: Text("${phone}"),
            trailing: Container(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppProviders.pimaryColorGreen,
                    child: IconButton(
                      onPressed: () {
                        phoneCall(phone);
                      },
                      icon: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppProviders.secondryColory,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chat_outlined,
                        color: Colors.white,
                      ),
                    ),
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
