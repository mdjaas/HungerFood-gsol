import 'package:flutter/material.dart';
import 'package:g_solution/widgets/app_bar_widget.dart';
import 'package:g_solution/widgets/text_field_widget.dart';
import 'package:g_solution/widgets/ink_well_widget.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        iconThemeColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.25,),
                  const TextFieldWidget(
                    placeholder: 'Name',
                  ),
                  const SizedBox(height: 20),
                  const TextFieldWidget(
                    placeholder: 'Username',
                  ),
                  const SizedBox(height: 20),
                  const TextFieldWidget(
                    placeholder: 'Password',
                    secure: true,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: InkWellWidget(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      fontSize: 20,
                      buttonName: 'Sign Up',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
