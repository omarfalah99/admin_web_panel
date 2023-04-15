import 'package:admin_web_panel/order_details.dart';
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
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final order = snapshot.data?.docs[index];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrange,
                ),
              );
            } else {
              return ListTile(
                title: Text(order['nameOfUser']),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return OrderDetails(
                      orders: order['items'],
                    );
                  }));
                },
              );
            }
          },
          itemCount: snapshot.data?.docs.length,
        );
      },
      stream: FirebaseFirestore.instance.collection('admin_cart').snapshots(),
    ));
  }
}

// Container(
// width: double.infinity,
// height: 70,
// margin: EdgeInsets.all(10),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(15)),
// child: InkWell(
// onTap: () {},
// borderRadius: BorderRadius.circular(15),
// child: Card(
// margin: EdgeInsets.all(10),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(15)),
// color: Color.fromRGBO(246, 121, 82, 1),
// child: Row(
// // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// SizedBox(
// width:
// MediaQuery.of(context).size.width * 0.1,
// ),
// Text(
// data['nameOfUser'],
// style: const TextStyle(color: Colors.white),
// ),
// SizedBox(
// width: MediaQuery.of(context).size.width *
// 0.08,
// ),
// Text(
// data['phone'],
// style: TextStyle(color: Colors.white),
// ),
// SizedBox(
// width: MediaQuery.of(context).size.width *
// 0.06,
// ),
// Text(
// data['price'] + ' \$',
// style: TextStyle(color: Colors.white),
// ),
// SizedBox(
// width:
// MediaQuery.of(context).size.width * 0.1,
// ),
// Text(
// data['quantity'].toString(),
// style: const TextStyle(color: Colors.white),
// ),
// SizedBox(
// width: MediaQuery.of(context).size.width *
// 0.13,
// ),
// Text(
// data['subtotal'].toString() + ' \$',
// style: TextStyle(color: Colors.white),
// ),
// SizedBox(
// width:
// MediaQuery.of(context).size.width * 0.1,
// ),
// Text(
// data['date'].toString().substring(0, 10),
// style: TextStyle(color: Colors.white),
// ),
// ],
// ),
// ),
// ))

// SizedBox(
// width: double.infinity,
// height: 70,
// child: Card(
// margin: EdgeInsets.all(10),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(15)),
// color: Colors.purple,
// child: Row(
// // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// SizedBox(
// width: MediaQuery.of(context).size.width * 0.1,
// ),
// const Text(
// 'Name',
// style: TextStyle(color: Colors.white),
// ),
// SizedBox(
// width: MediaQuery.of(context).size.width * 0.1,
// ),
// const Text(
// 'Phone',
// style: TextStyle(color: Colors.white),
// ),
// SizedBox(
// width: MediaQuery.of(context).size.width * 0.1,
// ),
// const Text(
// 'Price',
// style: TextStyle(color: Colors.white),
// ),
// SizedBox(
// width: MediaQuery.of(context).size.width * 0.1,
// ),
// const Text(
// 'Quantity',
// style: TextStyle(color: Colors.white),
// ),
// SizedBox(
// width: MediaQuery.of(context).size.width * 0.1,
// ),
// const Text(
// 'Subtotal',
// style: TextStyle(color: Colors.white),
// ),
// SizedBox(
// width: MediaQuery.of(context).size.width * 0.1,
// ),
// const Text(
// 'Date',
// style: TextStyle(color: Colors.white),
// ),
// ],
// ),
// )),
