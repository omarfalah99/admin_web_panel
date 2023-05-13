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

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: form,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Name can\'t be empty';
                  }
                },
                controller: name,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Kg can\'t be empty';
                  }
                },
                controller: kg,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(hintText: 'Kg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Description can\'t be empty';
                  }
                },
                controller: des,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Image can\'t be empty';
                  } else if (!val.contains('http')) {
                    return 'This is not right type of image format';
                  }
                },
                controller: imageUrl,
                decoration: const InputDecoration(hintText: 'Image'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Price can\'t be empty';
                  }
                },
                controller: price,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Price'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: quantity,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Quantity can\'t be empty';
                  }
                },
                // initialValue: 100.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Quantity'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Category can\'t be empty';
                  }
                },
                controller: category,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(hintText: 'Category'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Barcode can\'t be empty';
                  }
                },
                controller: barcode,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(hintText: 'Barcode'),
              ),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(246, 121, 82, 1),
                  minimumSize:
                      Size(MediaQuery.of(context).size.width - 200, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.add),
                onPressed: () async {
                  if (form.currentState!.validate()) {
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
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Item added!'),
                        content: Text('Item has successfully has been added.'),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(246, 121, 82, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text('OK'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  }
                },
                label: const Text('Add Products'))
          ],
        ),
      ),
    );
  }
}
