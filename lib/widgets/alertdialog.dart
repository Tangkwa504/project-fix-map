import 'package:flutter/material.dart';
enum DialogAction { Yes, Cancle }

class AlertDialogs {
  static Future<DialogAction> yesCancleDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color.fromARGB(255, 243, 16, 72)),
                    ),
                onPressed: () => Navigator.of(context).pop(DialogAction.Cancle),
                child: Text(
                  "ยกเลิก",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
                      
                      
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 255, 17)),
                    ),
                onPressed: () => Navigator.of(context).pop(DialogAction.Yes),
                child: Text(
                  "ยืนยัน",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },);
        return (action != null) ? action : DialogAction.Cancle;
  }
}
