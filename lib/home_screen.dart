import 'package:admin_web_panel/description_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                maxLengthEnforcement: MaxLengthEnforcement.none,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromRGBO(246, 121, 82, 1),
                  ),
                  hintText: 'Search...',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(246, 121, 82, 1)),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            ),
            Expanded(
              flex: 7,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshots) {
                  return (snapshots.connectionState == ConnectionState.waiting)
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(246, 121, 82, 1),
                          ),
                        )
                      : (!name.isEmpty)
                          ? ListView.builder(
                              itemCount: snapshots.data!.docs.length,
                              itemBuilder: (context, index) {
                                var data = snapshots.data!.docs[index].data()
                                    as Map<String, dynamic>;
                                if (data['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(name.toLowerCase())) {
                                  return TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Color.fromRGBO(246, 121, 82, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      minimumSize: Size(double.infinity, 50),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return desScreen(
                                          image: data['imageUrl'],
                                          tag: 'tag',
                                          kg: data['kg'],
                                          des: data['des'],
                                          name: data['name'],
                                          price: data['price'],
                                          barcode: data['barcode'],
                                          id: data['id'],
                                          category: data['category'],
                                        );
                                      }));
                                    },
                                    child: ListTile(
                                      title: Text(
                                        data['name'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      leading: Image.network(data['imageUrl']),
                                      trailing: Text(data['quantity']),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            )
                          : GridView.builder(
                              itemCount: snapshots.data?.docs.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    MediaQuery.of(context).size.width > 1000
                                        ? 6
                                        : 4,
                                mainAxisExtent:
                                    MediaQuery.of(context).size.width * 0.32,
                              ),
                              itemBuilder: (context, index) {
                                if (snapshots.connectionState ==
                                    ConnectionState.waiting) {
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  final products = snapshots.data?.docs[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        primary: const Color.fromRGBO(
                                            246, 121, 82, 1),
                                        padding: const EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        backgroundColor:
                                            const Color(0xFFF5F6F9),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return desScreen(
                                            image: products['imageUrl'],
                                            tag: 'wow$index',
                                            des: products['des'],
                                            name: products['name'],
                                            price: products['price'],
                                            id: products['id'],
                                            kg: products['kg'],
                                            category: products['category'],
                                            barcode: products['barcode'],
                                          );
                                        }));
                                      },
                                      child: Column(
                                        children: [
                                          Image.network(
                                            products!['imageUrl'],
                                            fit: BoxFit.cover,
                                          ),
                                          MediaQuery.of(context).size.width <
                                                  600
                                              ? Container()
                                              : Text(products['name']),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
