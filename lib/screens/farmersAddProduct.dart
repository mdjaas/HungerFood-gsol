import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;


import 'package:g_solution/widgets/text_field_widget.dart';
import 'package:g_solution/widgets/app_bar_widget.dart';
import 'package:g_solution/widgets/ink_well_widget.dart';
import 'package:g_solution/widgets/category_selector.dart';
import 'package:g_solution/widgets/image_picker_widget.dart';
import 'dart:io';

class FarmersAddProduct extends StatefulWidget{
  FarmersAddProduct({super.key});

  @override
  _FarmersAddProductState createState() => _FarmersAddProductState();
}
class _FarmersAddProductState extends State<FarmersAddProduct>{
  TextEditingController _ProductName = TextEditingController();
  TextEditingController _Description = TextEditingController();
  TextEditingController _Price = TextEditingController();
  File? pickedImage;

  String productName="";
  String description="";
  String price="";
  String selectedCategory = "";
  FirebaseFirestore db = FirebaseFirestore.instance;

  void _changeCategory(String value) {
    setState(() {
      selectedCategory = value;
    });
  }

  Future<void> addProductToFirestore() async {
    try {
      String? user = FirebaseAuth.instance.currentUser?.uid;
      CollectionReference businessProductsCollection =
      db.collection('users').doc(user).collection('userProducts');

      // Upload image to Firebase Storage
      if (pickedImage != null && productName!="" && price!="" && selectedCategory!="") {
        String imageName = path.basename(pickedImage!.path);
        firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(user!)
            .child(imageName);

        await storageReference.putFile(pickedImage!);
        String imageURL = await storageReference.getDownloadURL();

        await businessProductsCollection.add({
          'productName': productName,
          'description': description,
          'price': price,
          'category': selectedCategory,
          'imageURL': imageURL,
        });
      } else {

        print('Please enter all details');
      }
    } catch (error) {
      print('Error adding product to Firestore: $error');
    }
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
        body:
        SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                AppBarWidget(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconThemeColor: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:ImagePickerWidget(
                    onImagePicked: (image) => setState(() => pickedImage = image),
                  ),
                ),
                SizedBox(height: 20,),
                if (pickedImage != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20,),
                    child: Image.file(
                      pickedImage!,
                      width: 200,
                      height: 200,
                    ),
                  ),

                SizedBox(height: 20,),
                TextFieldWidget(
                  textEditingController: _ProductName,
                  onTextChanged: (value) {
                    setState(() {
                      productName = value;
                    });
                  },
                  placeholder: 'Product name',
                ),
                SizedBox(height: 20,),
                TextFieldWidget(
                  textEditingController: _Description,
                  onTextChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                  placeholder: 'Description',
                ),
                SizedBox(height: 20,),
                TextFieldWidget(
                  textEditingController: _Price,
                  onTextChanged: (value) {
                    setState(() {
                      price = value;
                    });
                  },
                  placeholder: 'Price',
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Category",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: CategorySelector(
                    image: './assets/food.png',
                    category: 'Farm',
                    value: "Farm",
                    groupValue: selectedCategory,
                    onClick: _changeCategory,
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: InkWellWidget(
                      buttonName: 'Add Product',
                      fontSize: 20,
                      buttonColor: Colors.redAccent,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      onPress: (){
                        addProductToFirestore();
                      },
                    )
                ),

              ],
            )
        )

    );
  }
}