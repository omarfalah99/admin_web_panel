import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  String id;
  String name;
  String des;
  String price;
  String imageUrl;
  String quantity;
  String category;
  EditScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.des,
    required this.imageUrl,
    required this.category,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final name_controller = TextEditingController();
  final des_controller = TextEditingController();
  final image_controller = TextEditingController();
  final price_controller = TextEditingController();
  final quantity_controller = TextEditingController();
  final category_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              // controller: name,
              initialValue: widget.name,
              onChanged: (val) {
                name_controller.text = val;
              },
              decoration: const InputDecoration(hintText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              // controller: des,
              onChanged: (val) {
                des_controller.text = val;
              },
              initialValue: widget.des,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              // controller: imageUrl,
              onChanged: (val) {
                image_controller.text = val;
              },
              initialValue: widget.imageUrl,
              decoration: const InputDecoration(hintText: 'Image'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              // controller: price,
              onChanged: (val) {
                price_controller.text = val;
              },
              initialValue: widget.price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Price'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              // controller: quantity,
              onChanged: (val) {
                quantity_controller.text = val;
              },
              initialValue: widget.quantity,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Quantity'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              // controller: category,
              onChanged: (val) {
                category_controller.text = val;
              },
              initialValue: widget.category,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(hintText: 'Category'),
            ),
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(246, 121, 82, 1),
                minimumSize: Size(MediaQuery.of(context).size.width - 200, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.edit),
              onPressed: () async {
                if (name_controller.text.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(widget.id.toString())
                      .set({
                    'name': name_controller.text,
                    'des': widget.des,
                    'imageUrl': widget.imageUrl,
                    'price': widget.price,
                    'quantity': widget.quantity,
                    'category': widget.category,
                    'id': widget.id.toString(),
                  });
                } else if (des_controller.text.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(widget.id.toString())
                      .set({
                    'des': des_controller.text,
                    'name': widget.name,
                    'imageUrl': widget.imageUrl,
                    'price': widget.price,
                    'quantity': widget.quantity,
                    'category': widget.category,
                    'id': widget.id.toString(),
                  });
                } else if (image_controller.text.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(widget.id.toString())
                      .set({
                    'imageUrl': image_controller.text,
                    'name': widget.name,
                    'des': widget.des,
                    'price': widget.price,
                    'quantity': widget.quantity,
                    'category': widget.category,
                    'id': widget.id.toString(),
                  });
                } else if (price_controller.text.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(widget.id.toString())
                      .set({
                    'price': price_controller.text,
                    'name': widget.name,
                    'des': widget.des,
                    'imageUrl': widget.imageUrl,
                    'quantity': widget.quantity,
                    'category': widget.category,
                    'id': widget.id.toString(),
                  });
                } else if (quantity_controller.text.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('products')
                      .doc(widget.id.toString())
                      .set({
                    'quantity': quantity_controller.text,
                    'price': widget.price,
                    'name': widget.name,
                    'des': widget.des,
                    'imageUrl': widget.imageUrl,
                    'category': widget.category,
                    'id': widget.id.toString(),
                  });
                }
              },
              label: const Text('Edit Product'))
        ],
      ),
    );
  }
}
