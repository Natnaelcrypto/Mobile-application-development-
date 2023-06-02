import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../LocalStroe/Store.dart';
import '../farm_model/farm_model.dart';
import 'edit_item.dart';

class ItemDetailScreen extends StatelessWidget {
  late final Farm item;

  ItemDetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Detail'),
        backgroundColor: Color.fromRGBO(36, 130, 50, .6),
        actions: [
          UserPreferences.role.toLowerCase() == "user"
              ? IconButton(
                  icon: const Icon(Icons.mode_edit),
                  color: Color.fromRGBO(69, 55, 80, 0.9),
                  onPressed: () {
                    context.go("/edititem", extra: item);
                  },
                )
              : const Text(""),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Text(
              'Name: ${item.itemName}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Quantity: ${item.quantity}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Expiration Date: ${item.expirationDate}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            if (item.ismedication)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dosage: ${(item).dosage}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Instructions: ${(item).instructions}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),

            if (item.isfeed)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Brand: ${(item).brand}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Type: ${(item).type}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),

            // Add additional conditions for other item types
          ],
        ),
      ),
    );
  }
}
