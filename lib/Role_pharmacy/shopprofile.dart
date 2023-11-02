import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../chat/chat.dart';
import '../widgets/Service.dart';

class Shopprofile extends StatefulWidget {
  Shopprofile({
    super.key,
    required this.Shopname,
    required this.Addressshop,
    required this.Pharmacyname,
    required this.Timeclosing,
    required this.Timeopening,
    required this.Url,
    required this.Licensepharmacy,
    required this.PharmacyEmail,
    required this.Userkey,
  });

  String Shopname;
  String Addressshop;
  String Pharmacyname;
  String Timeopening;
  String Timeclosing;
  String? Url;
  String Licensepharmacy;
  String PharmacyEmail;
  String Userkey;
  @override
  State<Shopprofile> createState() => _ShopprofileState();
}

void createrequset(){
   
    
  }

class _ShopprofileState extends State<Shopprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดร้านขายยา'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16), // Add padding to the container
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
          children: [
            const Text(
              "", // Empty text, you might want to put something here
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            if(widget.Url != null)
            Align(
              alignment: Alignment.center,
              child: Image.network(widget.Url.toString(), width: 200),
            ),
            const SizedBox(height: 12),
            Text(
              widget.Shopname,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.Addressshop,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "ร้านเปิด " + widget.Timeopening + "-" + widget.Timeclosing,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(221, 0, 47, 255),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "ภก. " +
                  widget.Pharmacyname +
                  " เลขที่ใบอนุญาต " +
                  widget.Licensepharmacy,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(221, 95, 93, 93),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: InkWell(
                onTap: () {
                  ProviderSer profileService =
                  Provider.of<ProviderSer>(context, listen: false);
                  //final userProvider = Provider.of<Useridprovider>(context, listen: false);
                  print(profileService.reademail);
                   String senderid = profileService.readid;
                   String receiverId = widget.Userkey;

                   String pathpharmacy ="Pharmacy/$receiverId/request";
      
                   DatabaseReference refpharmacyrequest = FirebaseDatabase.instance.ref(pathpharmacy);
                   refpharmacyrequest.update({
                   senderid:"requestid" ,
                  });
                  
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatScreen(chatName: widget.Shopname, image: widget.Url.toString(), receiverId: widget.Userkey, senderId:profileService.readid,),));
                },
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 243, 16, 72),
                  ),
                  child: const Text(
                    "ปรึกษาเภสัชกร",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}