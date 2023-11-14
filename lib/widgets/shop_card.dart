import 'package:flutter/material.dart';
import 'package:gmart/screens/gmart_form.dart';
import 'package:gmart/screens/list_item.dart';

class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}

class Item {
  String name = "";
  int amount = 0;
  String description = "";
  String type = "";

  Item(this.name, this.amount, this.description, this.type);
}

List<Item> listItem = [];

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
          if (item.name == "Tambah Item"){
            Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const ShopFormPage()
            ));
          }
          if (item.name == "Lihat Item"){
            Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const ListItemPage()
            ));
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}