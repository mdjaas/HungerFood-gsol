import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:geocoding/geocoding.dart';
import 'package:path/path.dart' as path;
import 'package:geolocator/geolocator.dart';

import 'package:g_solution/widgets/text_field_widget.dart';
import 'package:g_solution/widgets/app_bar_widget.dart';
import 'package:g_solution/widgets/ink_well_widget.dart';
import 'package:g_solution/widgets/category_selector.dart';
import 'package:g_solution/widgets/image_picker_widget.dart';
import 'dart:io';

class BusinessAddProduct extends StatefulWidget{
  BusinessAddProduct({super.key});

  @override
  _BusinessAddProductState createState() => _BusinessAddProductState();
}
class _BusinessAddProductState extends State<BusinessAddProduct>{
    TextEditingController _ProductName = TextEditingController();
    TextEditingController _Description = TextEditingController();
    TextEditingController _Price = TextEditingController();
    TextEditingController _Qty = TextEditingController();
    File? pickedImage;

    String productName="";
    String description="";
    String price="";
    String selectedCategory = "";
    int qty = 0;
    double? latitude;
    double? longitude;
    String? location;
    FirebaseFirestore db = FirebaseFirestore.instance;

    void _changeCategory(String value) {
      setState(() {
        selectedCategory = value;
      });
    }

    void showSnackbar(BuildContext context, String message) {
      final snackBar = SnackBar(
        content: Text(message),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Future<void> addProductToFirestore() async {
      try {
        String? user = FirebaseAuth.instance.currentUser?.uid;
        CollectionReference businessProductsCollection =
        db.collection('users').doc(user).collection('userProducts');

        if (pickedImage != null && productName!="" && price!="" && selectedCategory!="" && qty!=0 &&
            latitude!=null && longitude!=null) {
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
            'quantity': qty,
            'latitude': latitude,
            'longitude': longitude,
            'location': location,
          });
          showSnackbar(context, 'Product added successfully');
        } else {

          showSnackbar(context, 'Please enter all details');
        }
      } catch (error) {
        print('Error adding product to Firestore: $error');
      }
    }

    Future<void> getCurrentLocation() async {
      try {
        LocationPermission permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          // Handle the case where the user denies permission
          showSnackbar(context, 'Location permission denied');
          return;
        }
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        latitude = position.latitude;
        longitude = position.longitude;
        showSnackbar(context, 'Location detected');
        print('Latitude: $latitude, Longitude: $longitude');
        List<Placemark> placemarks = await placemarkFromCoordinates(latitude!, longitude!);

        Placemark place = placemarks[0];
        location = "${place.name}, ${place.locality}, ${place.country}";
      } catch (e) {
        print('Error getting location: $e');
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
                      placeholder: "Quantity",
                      inputType: TextInputType.number,
                      textEditingController: _Qty,
                      onTextChanged: (value){
                        setState(() {
                          qty = qty = int.tryParse(value) ?? 0;
                        });
                      },
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CategorySelector(
                          image: './assets/food.png',
                          category: 'Grocery',
                          value: "Grocery",
                          groupValue: selectedCategory,
                          onClick: _changeCategory,
                        ),
                        SizedBox(width: 20,),
                        CategorySelector(
                          image: './assets/food.png',
                          category: 'Bakery',
                          value: "Bakery",
                          groupValue: selectedCategory,
                          onClick: _changeCategory,
                        ),
                        SizedBox(width: 20,),
                        CategorySelector(
                          image: './assets/food.png',
                          category: 'Meals',
                          value: "Meals",
                          groupValue: selectedCategory,
                          onClick: _changeCategory,
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,),
                        child: InkWellWidget(
                          buttonName: 'Get Current Location',
                          fontSize: 20,
                          buttonColor: Colors.redAccent,
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          onPress: (){
                            getCurrentLocation();
                          },
                        )
                    ),
                    SizedBox(height: 20,),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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