import 'package:admin_web_panel/edit_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DescriptionScreen extends StatefulWidget {
  String tag;
  String des;
  String id;
  String name;
  String image;
  String price;
  String category;

  DescriptionScreen({
    Key? key,
    required this.image,
    required this.tag,
    required this.des,
    required this.name,
    required this.price,
    required this.id,
    required this.category,
  }) : super(key: key);

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
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
                  price: widget.price,
                  des: widget.des,
                  imageUrl: widget.image,
                  category: widget.category,
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
