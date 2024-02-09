import 'package:flutter/material.dart';
import 'package:g_solution/widgets/ink_well_widget.dart';

class UserProductsWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String? price;
  final String? location;

  const UserProductsWidget({
    Key? key,
    this.image,
    this.price,
    this.location,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              image!,
              width: 100,
              height: 100,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 120),
              Text(
                "Rs." + price!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(location ?? ''),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 60, top: 20, bottom: 10),
            child: InkWellWidget(
              buttonColor: Colors.redAccent,
              fontSize: 20,
              buttonName: "Add to cart",
            ),
          ),
        ],
      ),
    );
  }
}
