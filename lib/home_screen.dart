import 'package:admin_web_panel/description_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: snapshot.data?.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisExtent: MediaQuery.of(context).size.width * 0.3,
                  ),
                  itemBuilder: (context, index) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final products = snapshot.data?.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: const Color.fromRGBO(246, 121, 82, 1),
                            padding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: const Color(0xFFF5F6F9),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return DescriptionScreen(
                                image: products['imageUrl'],
                                tag: 'wow' + index.toString(),
                                des: products['des'],
                                name: products['name'],
                                price: products['price'],
                                id: products['id'],
                                category: products['category'],
                              );
                            }));
                          },
                          child: Column(
                            children: [
                              Image.network(
                                products!['imageUrl'],
                                fit: BoxFit.cover,
                              ),
                              MediaQuery.of(context).size.width < 600
                                  ? Container()
                                  : Text(products['name']),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
