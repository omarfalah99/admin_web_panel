import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'order_details.dart';

class ConfirmedOrders extends StatefulWidget {
  const ConfirmedOrders({Key? key}) : super(key: key);

  @override
  State<ConfirmedOrders> createState() => _ConfirmedOrdersState();
}

class _ConfirmedOrdersState extends State<ConfirmedOrders> {
  String name = '';
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
                    .collection('confirmedOrders')
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
                                var e = snapshots.data!.docs[index].data()
                                    as Map<String, dynamic>;
                                if (e['nameOfUser']
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
                                        return OrderDetails(
                                          street: e['street'],
                                          status: 'Confirm',
                                          orders: e['items'],
                                          city: e['city'],
                                          email: e['email'],
                                          garak: e['garak'],
                                          name: e['nameOfUser'],
                                          phone: e['phone'],
                                          date: e['date'].toString(),
                                        );
                                      }));
                                    },
                                    child: ListTile(
                                      title: Text(
                                        e['nameOfUser'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(e['date']
                                          .toString()
                                          .substring(0, 10)),
                                      trailing: Text(e['city']),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            )
                          : ListView.builder(
                              itemCount: snapshots.data?.docs.length,
                              itemBuilder: (context, index) {
                                if (snapshots.connectionState ==
                                    ConnectionState.waiting) {
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  final e = snapshots.data?.docs[index];
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
                                          return OrderDetails(
                                            street: e['street'],
                                            status: 'Confirm',
                                            orders: e['items'],
                                            city: e['city'],
                                            email: e['email'],
                                            garak: e['garak'],
                                            name: e['nameOfUser'],
                                            phone: e['phone'],
                                            date: e['date'].toString(),
                                          );
                                        }));
                                      },
                                      child: ListTile(
                                        title: Text(
                                          e['nameOfUser'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(e['date']
                                            .toString()
                                            .substring(0, 10)),
                                        trailing: Text(e['city']),
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
