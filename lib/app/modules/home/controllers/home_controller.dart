import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/Menu.dart';
import '../../../data/cart.dart';

class HomeController extends GetxController {
  CollectionReference ref = FirebaseFirestore.instance.collection('menu');
  TextEditingController namaController = TextEditingController();
  TextEditingController hpController = TextEditingController();
  final carts = Carts();
  final orderRef = FirebaseFirestore.instance.collection('order');
  final currencyFormatter = NumberFormat.decimalPattern('en_us');

  String getCurrency(double price) {
    return currencyFormatter.format(price);
  }

  final selectedValueIndex = 0.obs;
  final buttonText = ["Pulsa", "Data", "Game"];
  final iconButton = [
    "assets/images/ic_makanan.png",
    "assets/images/ic_kuah.png",
    "assets/images/ic_minuman.png"
  ];

  @override
  void onInit() {
    super.onInit();
    FlutterNativeSplash.remove();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Stream<List<Menu>> readMenu(String jenis) => FirebaseFirestore.instance
      .collection('menu')
      .where('jenis', isEqualTo: jenis)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Menu.fromJson(doc.data())).toList());

  Future<void> addOrder(String nama, String hp, double total, String status,
      List<Cart> data) async {
    final docRef = orderRef.doc();
    final a = data.map((e) => e.toJson()).toList();
    await docRef.set({
      'id': docRef.id,
      'nama': nama,
      'hp': hp,
      'status': status,
      'total': total,
      'data': a,
    });
  }
}
