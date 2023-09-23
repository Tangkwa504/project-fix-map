import 'package:flutter/material.dart';



class Bottonhome extends StatelessWidget {
  const Bottonhome({
    Key? key, required this.title , required this.page , required this.icon
  }) : super(key: key);
final String title;
final Widget page;
final IconData icon;
  @override
  Widget build(BuildContext context) {
    print(title);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page,));
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