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
  final imageUrl = TextEditingController();
  final price = TextEditingController();
  final quantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: name,
              decoration: InputDecoration(hintText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: des,
              decoration: InputDecoration(hintText: 'Description'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: imageUrl,
              decoration: InputDecoration(hintText: 'Image'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Price'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: quantity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Quantity'),
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
              icon: Icon(Icons.add),
              onPressed: () async {
                await FirebaseFirestore.instance.collection('products').add({
                  'name': name.text,
                  'des': des.text,
                  'imageUrl': imageUrl.text,
                  'price': price.text as double,
                  'quantity': quantity.text,
                });
              },
              label: Text('Add Products'))
        ],
      ),
    );
  }
}
