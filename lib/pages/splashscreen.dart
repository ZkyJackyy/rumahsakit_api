import 'package:flutter/material.dart';
import 'package:rumahsakit_api/pages/list_rs.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();
    // Tunggu 3 detik sebelum pindah ke halaman berikutnya
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ListRs()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[

            Image.asset('images/logo.png',width: 600,),

            SizedBox(height: 20,),
            const CircularProgressIndicator(
              color: Colors.lightBlue,
            ),
            // ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent), onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ListRs()));
            // }, child: Text('Get Started',style: TextStyle(color: Colors.black),))
          ],
        ),
      ),
    );
  }
}