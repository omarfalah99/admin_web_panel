import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final name = TextEditingController();
  final des = TextEditingController();
  final kg = TextEditingController();
  final barcode = TextEditingController();
  final imageUrl = TextEditingController();
  final price = TextEditingController();
  final quantity = TextEditingController();
  final category = TextEditingController();

  Key id = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: name,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: kg,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(hintText: 'Kg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: des,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: imageUrl,
              decoration: const InputDecoration(hintText: 'Image'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Price'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: quantity,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Quantity'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: category,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(hintText: 'Category'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: barcode,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(hintText: 'Barcode'),
            ),
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(246, 121, 82, 1),
                minimumSize: Size(MediaQuery.of(context).size.width - 200, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.add),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('products')
                    .doc(id.toString())
                    .set({
                  'name': name.text,
                  'des': des.text,
                  'imageUrl': imageUrl.text,
                  'price': price.text,
                  'quantity': quantity.text,
                  'barcode': barcode.text,
                  'kg': kg.text,
                  'category': category.text,
                  'id': id.toString(),
                });
              },
              label: const Text('Add Products'))
        ],
      ),
    );
  }
}
