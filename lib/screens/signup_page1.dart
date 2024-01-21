import 'package:flutter/material.dart';

import 'package:g_solution/widgets/app_bar_widget.dart';
import 'package:g_solution/widgets/ink_well_widget.dart';
import 'signup_page2.dart';
import 'package:g_solution/widgets/dropdown_widget.dart';

class GettingStarted extends StatelessWidget {
  const GettingStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        backgroundColor: Colors.transparent,
        iconThemeColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
              children: [
                Text(
                  "GETTING STARTED",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),

                ),
                Text(
                  "Let's Unite for a Hunger-Free World!",
                  style: TextStyle(fontSize: 18),

                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          const Padding(padding: EdgeInsets.all(20),
            child:Text("I am a,",
            style: TextStyle(fontSize: 22),
            )
          ),
          

          DropdownWidget(),

          Padding(padding: EdgeInsets.only(top:20, left:20, right: 20),
              child: InkWellWidget(
                buttonName: 'Next',
                fontSize: 20,
                padding: const EdgeInsets.only(top: 10, bottom: 10,),
                onPress: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp(),
                    ),
                  );
                },
              )
          ),

        ],
      ),
    );
  }
}
