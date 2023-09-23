import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../login/login_screen.dart';
import '../widgets/alertdialog.dart';

class Bottonhomeguest extends StatelessWidget {
  const Bottonhomeguest({
    Key? key, required this.title , required this.page , required this.icon
  }) : super(key: key);
final String title;
final Widget page;
final IconData icon;
  @override
  Widget build(BuildContext context) {
    print(title);
    return InkWell(
      onTap: () async{
        final action = await AlertDialogs.yesCancleDialog(
                            context,
                            'กรุณาเข้าสู่ระบบก่อนการใช้งาน',
                            'คุณต้องการที่จะเข้าสู่ระบบหรือไม่ ?');
                        if (action == DialogAction.Yes) {
                          Fluttertoast.showToast(
                              msg: "หน้าเข้าสู่ระบบ",
                              gravity: ToastGravity.TOP,
                              backgroundColor:
                                  Color.fromARGB(255, 243, 16, 72));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        };
      },
      child: Container(
        width: 130,
        height: 130,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration( 
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 151, 159, 182),
        ),
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,size: 50),
            Text( 
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
              
            ),
          ],
        ),
      ),
    );
  }
}