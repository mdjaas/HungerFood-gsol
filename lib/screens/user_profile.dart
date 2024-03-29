import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:g_solution/widgets/text_field_widget.dart';
import 'package:g_solution/widgets/ink_well_widget.dart';
import 'package:g_solution/providers/user_provider.dart';
import 'package:g_solution/providers/cart_provider.dart';

class UserProfile extends StatefulWidget{
  UserProfile({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController= TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  String? name="";
  String? email="";
  int? phone=0;

  Future<void> updateUserDetails() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      DocumentReference userReference =
      FirebaseFirestore.instance.collection('users').doc(userProvider.user?.uid ?? '');

      String updatedName = _nameController.text;
      String updatedEmail = _emailController.text;
      int? updatedPhone = int.tryParse(_phoneController.text) ?? 0;

      await userReference.update({
        "Name": updatedName,
        "email": updatedEmail,
        "phone": updatedPhone,
      });

      userProvider.updateUser(name: updatedName, username: updatedEmail, phone: updatedPhone);
      showSnackbar(context, 'User details updated successfully!');
    } catch (error) {
      print('Error updating user details: $error');
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    _nameController.text = userProvider.user?.name ?? '';
    _emailController.text = userProvider.user?.username ?? '';
    _phoneController.text = userProvider.user?.phone.toString() ?? '';
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
                            placeholder: "Name",
                            textEditingController: _nameController,
                            onTextChanged: (value){
                              setState(() {
                                name=value;
                              });
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextFieldWidget(
                            placeholder: "Email",
                            textEditingController: _emailController,
                            textEnabled: false,
                            onTextChanged: (value){
                              setState(() {
                                email=value;
                              });
                            },
                          ),
                          const SizedBox(height: 20,),
                          TextFieldWidget(
                            placeholder: "Phone",
                            inputType: TextInputType.phone,
                            textEditingController: _phoneController,
                            onTextChanged: (value){
                              setState(() {
                                phone=value as int?;
                              });
                            },
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: InkWellWidget(
                              buttonName: 'Update Profile',
                              fontSize: 20,
                              buttonColor: Colors.redAccent,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              onPress: (){
                                updateUserDetails();
                              },
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
                                cartProvider.cartItems=[];
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
