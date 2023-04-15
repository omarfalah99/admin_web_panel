import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  List orders;
  OrderDetails({Key? key, required this.orders}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  num total = 1;
  num getSum() {
    for (int i = 0; i < widget.orders.length; i++) {
      total += widget.orders[i]['subtotal'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(getSum().toString()),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.orders[index]['name']),
                    onTap: getSum,
                  );
                },
                itemCount: widget.orders.length),
          ),
        ],
      ),
    );
  }
}
