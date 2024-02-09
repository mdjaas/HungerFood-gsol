import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget{
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 50),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Center(
                    child: Image.asset('assets/food.png', width: 300, height: 200,),
                  ),
                  const SizedBox(height: 20),
                  const Text("I'M HUNGRY NOW",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25, fontStyle: FontStyle.italic),
                  ),
                ]
              )


            ),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
              child: const Column(
                children: [
                  Center(
                      child: Text("Save a food and make a difference",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                  )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text("Make a difference while feeding the hungry",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:60),
                    child: GetStartedButton(),
                  )

                ],
              ),
            )
          ],
        ),
    );
  }
}

class GetStartedButton extends StatelessWidget{
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context){
    return Material(
        child:Ink(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.green,
            ),

            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  'login',
                );
              },

              //borderRadius: BorderRadius.circular(40.0),
              child: const Padding(
                padding: EdgeInsets.only(left: 50, right:50, top: 10, bottom: 10),
                child: Text('Get Started',
                style: TextStyle(fontSize: 20),
                ),),
            )
        )
    );
  }
}