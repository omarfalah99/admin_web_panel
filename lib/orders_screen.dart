import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('admin_cart').snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemBuilder: (context, index) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return ListTile(
                  title: Text(snapshot.data?.docs[index]['phone']),
                );
              }
            },
            itemCount: snapshot.data?.docs.length,
          );
        },
      ),
    );
  }
}
