import 'package:admin_web_panel/edit_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class desScreen extends StatefulWidget {
  String tag;
  String des;
  String id;
  String name;
  String kg;
  String image;
  String barcode;
  String price;
  String category;

  desScreen({
    Key? key,
    required this.image,
    required this.tag,
    required this.kg,
    required this.des,
    required this.name,
    required this.price,
    required this.barcode,
    required this.id,
    required this.category,
  }) : super(key: key);

  @override
  State<desScreen> createState() => _desScreenState();
}

class _desScreenState extends State<desScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Color.fromRGBO(246, 121, 82, 1),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return EditScreen(
                  id: widget.id,
                  name: widget.name,
                  quantity: '100',
                  kg: widget.kg,
                  price: widget.price,
                  des: widget.des,
                  imageUrl: widget.image,
                  category: widget.category,
                  barcode: widget.barcode,
                );
              }));
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          return ListView(
            children: [
              Hero(
                tag: 'wow${widget.tag}',
                child: Image.network(
                  widget.image,
                  height: 300,
                  width: double.infinity,
                ),
              ),
              Text(
                widget.des,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  '${widget.price} \$',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(246, 121, 82, 1),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.delete),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(246, 121, 82, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('products')
                        .doc(widget.id)
                        .delete();

                    Navigator.of(context).pop();
                  },
                  label: Text('Delete'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
