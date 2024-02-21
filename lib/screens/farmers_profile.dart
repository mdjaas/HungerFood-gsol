import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:g_solution/widgets/text_field_widget.dart';
import 'package:g_solution/widgets/ink_well_widget.dart';
import 'package:g_solution/providers/user_provider.dart';

class FarmersProfile extends StatefulWidget{
  FarmersProfile({super.key});

  @override
  _FarmersProfileState createState() => _FarmersProfileState();
}

class _FarmersProfileState extends State<FarmersProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController= TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  String? name="";
  String? email="";
  int? phone=0;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    _nameController.text = userProvider.user?.name ?? '';
    _emailController.text = userProvider.user?.username ?? '';
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              child: Column(
                children: [
                  SizedBox(height: 280,),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30,),
                          TextFieldWidget(
                            placeholder: "Business Name",
                            textEditingController: _nameController,
                          ),
                          const SizedBox(height: 20,),
                          TextFieldWidget(
                            placeholder: "Email",
                            textEditingController: _emailController,
                          ),
                          const SizedBox(height: 20,),
                          TextFieldWidget(
                            placeholder: "Phone",
                            inputType: TextInputType.phone,
                            textEditingController: _phoneController,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: InkWellWidget(
                              buttonName: 'Update Profile',
                              fontSize: 20,
                              buttonColor: Colors.redAccent,
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: InkWellWidget(
                              buttonName: 'Sign Out',
                              fontSize: 20,
                              buttonColor: Colors.redAccent,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              onPress: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context,
                                    'landingScreen');
                                userProvider.logout();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
