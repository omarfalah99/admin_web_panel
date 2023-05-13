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
  String barcode;
  String kg;
  EditScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.kg,
    required this.quantity,
    required this.price,
    required this.barcode,
    required this.des,
    required this.imageUrl,
    required this.category,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final name_controller = TextEditingController();
  final barcode_controller = TextEditingController();
  final des_controller = TextEditingController();
  final image_controller = TextEditingController();
  final price_controller = TextEditingController();
  final quantity_controller = TextEditingController();
  final category_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('barcode', isEqualTo: widget.barcode)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: snapshot.data!.docs[0]['barcode'],
                      onChanged: (val) {
                        barcode_controller.text = val;
                      },
                      decoration: const InputDecoration(hintText: 'Barcode'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // controller: quantity,
                      onChanged: (val) {
                        quantity_controller.text = val;
                      },
                      initialValue: snapshot.data!.docs[0]['quantity'],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Quantity'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // controller: name,
                      initialValue: snapshot.data!.docs[0]['name'],
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
                      initialValue: snapshot.data!.docs[0]['des'],
                      decoration:
                          const InputDecoration(hintText: 'Description'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // controller: imageUrl,
                      onChanged: (val) {
                        image_controller.text = val;
                      },
                      initialValue: snapshot.data!.docs[0]['imageUrl'],
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
                      initialValue: snapshot.data!.docs[0]['price'],
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
                      initialValue: snapshot.data!.docs[0]['quantity'],
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
                      initialValue: snapshot.data!.docs[0]['category'],
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(hintText: 'Category'),
                    ),
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(246, 121, 82, 1),
                        minimumSize:
                            Size(MediaQuery.of(context).size.width - 200, 70),
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
                            'barcode': widget.barcode,
                            'kg': widget.kg,
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
                            'barcode': widget.barcode,
                            'quantity': widget.quantity,
                            'category': widget.category,
                            'id': widget.id.toString(),
                            'kg': widget.kg,
                          });
                        } else if (image_controller.text.isNotEmpty) {
                          await FirebaseFirestore.instance
                              .collection('products')
                              .doc(widget.id.toString())
                              .set({
                            'imageUrl': image_controller.text,
                            'name': widget.name,
                            'des': widget.des,
                            'barcode': widget.barcode,
                            'price': widget.price,
                            'kg': widget.kg,
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
                            'kg': widget.kg,
                            'barcode': widget.barcode,
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
                            'kg': widget.kg,
                            'des': widget.des,
                            'barcode': widget.barcode,
                            'imageUrl': widget.imageUrl,
                            'category': widget.category,
                            'id': widget.id.toString(),
                          });
                        } else if (barcode_controller.text.isNotEmpty) {
                          await FirebaseFirestore.instance
                              .collection('products')
                              .doc(widget.id.toString())
                              .set({
                            'quantity': quantity_controller.text,
                            'price': widget.price,
                            'name': widget.name,
                            'kg': widget.kg,
                            'des': widget.des,
                            'barcode': barcode_controller.text,
                            'imageUrl': widget.imageUrl,
                            'category': widget.category,
                            'id': widget.id.toString(),
                          });
                        }
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Icon(Icons.check_circle,
                                color: Colors.green, size: 80),
                            content: Text('Item has been updated',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(246, 121, 82, 1),
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
                        Navigator.of(context).pop();
                      },
                      label: const Text('Edit Product'))
                ],
              );
            }
          }),
    );
  }
}
