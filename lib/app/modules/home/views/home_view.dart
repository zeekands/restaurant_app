import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/Menu.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (ctx) => Container(
              height: 0.9.sh,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  const Text('Pesanan Anda', style: TextStyle(fontSize: 20))
                      .paddingSymmetric(horizontal: 20.w),
                  SingleChildScrollView(
                    child: controller.carts.items.isNotEmpty
                        ? SizedBox(
                            height: 0.53.sh,
                            width: 1.sw,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: controller.carts.items.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    controller.carts.removeSingleItem(controller
                                        .carts.items.values
                                        .elementAt(index)
                                        .id);
                                  },
                                  background: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    alignment: Alignment.centerRight,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.red,
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ).paddingOnly(right: 10.w),
                                  ),
                                  child: ListTile(
                                    title: Text(controller.carts.items.values
                                        .elementAt(index)
                                        .title),
                                    subtitle: Text(
                                        "${controller.carts.items.values.elementAt(index).quantity} Item(s)"),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: controller.carts.items.values
                                            .elementAt(index)
                                            .image,
                                        height: 50.h,
                                        width: 50.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    trailing: Text(
                                        "Rp ${controller.getCurrency(controller.carts.items.values.elementAt(index).price.toDouble() * controller.carts.items.values.elementAt(index).quantity)}"),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  thickness: 2.h,
                                );
                              },
                            ).paddingOnly(top: 10.h, left: 20.w, right: 20.w),
                          )
                        : Container(
                            height: 0.53.sh,
                            width: 1.sw,
                            alignment: Alignment.center,
                            child: const Text('Keranjang Kosong'),
                          ),
                  ),
                  SizedBox(
                    height: 0.3.sh,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rincian Harga",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold)),
                        10.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Subtotal'),
                            Text(
                                "Rp ${controller.getCurrency(controller.carts.totalAmount)}"),
                          ],
                        ),
                        10.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Pajak (11%)'),
                            Text(
                                "Rp ${controller.getCurrency(controller.carts.totalAmount * 0.11)}"),
                          ],
                        ),
                        20.verticalSpace,
                        Row(
                          children: List.generate(
                              800 ~/ 10,
                              (index) => Expanded(
                                    child: Container(
                                      color: index % 2 == 0
                                          ? Colors.transparent
                                          : Colors.grey,
                                      height: 2,
                                    ),
                                  )),
                        ),
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Harga',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                "Rp ${controller.getCurrency((controller.carts.totalAmount * 0.11) + controller.carts.totalAmount)}",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        20.verticalSpace,
                        Center(
                          child: SizedBox(
                            height: ScreenUtil().setHeight(40),
                            width: 0.8.sw,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.carts.items.isNotEmpty
                                    ? Get.bottomSheet(
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  'assets/images/logo_app.png',
                                                  height: 100.h,
                                                  width: 100.w,
                                                ),
                                                10.verticalSpace,
                                                Text(
                                                  'Silahkan Isi Form Berikut Untuk Memproses Pesanan',
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                20.verticalSpace,
                                                TextField(
                                                  controller:
                                                      controller.namaController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Nama Lengkap',
                                                    labelStyle: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                20.verticalSpace,
                                                TextField(
                                                  controller:
                                                      controller.hpController,
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  decoration: InputDecoration(
                                                    labelText: 'No Handphone',
                                                    labelStyle: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                20.verticalSpace,
                                                TextField(
                                                  controller:
                                                      controller.hpController,
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'Masukan Nomor Kartu Debit',
                                                    labelStyle: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                40.verticalSpace,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: Container(
                                                          height: ScreenUtil()
                                                              .setHeight(40),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                              color: Colors.red,
                                                              width: 1,
                                                            ),
                                                          ),
                                                          child: const Center(
                                                            child: Text(
                                                              "Cek ulang pesanan",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    20.horizontalSpace,
                                                    Flexible(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          if (controller
                                                                  .namaController
                                                                  .text
                                                                  .isNotEmpty &&
                                                              controller
                                                                  .hpController
                                                                  .text
                                                                  .isNotEmpty) {
                                                            await controller
                                                                .addOrder(
                                                              controller
                                                                  .namaController
                                                                  .text,
                                                              controller
                                                                  .hpController
                                                                  .text,
                                                              controller.carts
                                                                  .totalAmount,
                                                              "menunggu",
                                                              controller.carts
                                                                  .items.values
                                                                  .toList(),
                                                            );
                                                            controller.carts
                                                                .clear();
                                                            Get.back();
                                                            Get.back();
                                                            Get.bottomSheet(
                                                                Container(
                                                              height: 0.5.sh,
                                                              width: 1.sw,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image.asset(
                                                                    'assets/images/logo_app.png',
                                                                    height:
                                                                        200.h,
                                                                    width:
                                                                        300.w,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                  Text(
                                                                    "Arigatogozhaimasita\nPesanan Anda Sedang \nDipersiapkan",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          20.sp,
                                                                    ),
                                                                  ),
                                                                  20.verticalSpace,
                                                                  Text(
                                                                    "Silahkan Lakukan Pembayaran di Kasir",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                              .grey[
                                                                          400],
                                                                      fontSize:
                                                                          16.sp,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ));
                                                          } else {
                                                            Get.snackbar(
                                                              "Error",
                                                              "Silahkan Isi Form Terlebih Dahulu",
                                                              snackPosition:
                                                                  SnackPosition
                                                                      .TOP,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              colorText:
                                                                  Colors.white,
                                                              icon: Icon(
                                                                Icons.error,
                                                                color: Colors
                                                                    .white,
                                                                size: 20.sp,
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          height: ScreenUtil()
                                                              .setHeight(40),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.red,
                                                          ),
                                                          child: const Center(
                                                            child: Text(
                                                              "Konfirmasi",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                20.verticalSpace,
                                              ],
                                            ).paddingSymmetric(
                                                horizontal: 20.w,
                                                vertical: 10.h),
                                          ),
                                        ),
                                      )
                                    : Get.snackbar(
                                        "Keranjang Kosong",
                                        "Silahkan Tambahkan Pesanan",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                        margin: const EdgeInsets.all(10),
                                      );
                              },
                              child: const Text('Lanjutkan Pesanan'),
                            ),
                          ),
                        ),
                      ],
                    ).paddingOnly(
                        top: 20.h, bottom: 10.h, left: 20.w, right: 20.w),
                  )
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.shopping_bag_rounded),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: AppBar(
          flexibleSpace: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //search bar
              children: [
                Text(
                  "Easy Topup",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ).paddingOnly(right: 10.w),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      Get.snackbar(
                        "Belum Tersedia",
                        "Fitur yang dipilih Belum Tersedia",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(10),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(10),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 18.r,
                              color: Colors.grey[500],
                            ),
                            20.horizontalSpace,
                            Text(
                              "Search",
                              style: TextStyle(fontSize: 12.sp),
                            )
                          ],
                        ).paddingAll(10.r),
                      ),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          20.verticalSpace,
          Text("Pilih Menu Disini",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
          Row(
            children: [
              ...List.generate(
                controller.buttonText.length,
                (index) => button(
                  index: index,
                  text: controller.buttonText[index],
                  image: controller.iconButton[index],
                ).paddingOnly(right: 10.w),
              )
            ],
          ).paddingSymmetric(vertical: 10.h),
          10.verticalSpace,
          Flexible(
            child: Obx(
              () => StreamBuilder<List<Menu>>(
                  stream: controller.readMenu(controller
                      .buttonText[controller.selectedValueIndex.value]),
                  builder: (context, snapshot) {
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.h,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          final jumlah = 1.obs;
                          Get.bottomSheet(
                            Container(
                              height: 1.sh,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  ScreenUtil().setWidth(10),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  20.verticalSpace,
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        ScreenUtil().setWidth(10),
                                      ),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          snapshot.data?[index].images ?? "",
                                      width: 1.sw,
                                      height: 200.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  20.verticalSpace,
                                  Text(
                                    snapshot.data?[index].nama ?? "",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(18),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  15.verticalSpace,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Rp ${controller.getCurrency(snapshot.data?[index].harga.toDouble() ?? 0)}",
                                        style: TextStyle(
                                          fontSize: ScreenUtil().setSp(18),
                                        ),
                                      ),
                                      Obx(
                                        () => Row(
                                          children: [
                                            jumlah.value > 1
                                                ? IconButton(
                                                    onPressed: () =>
                                                        jumlah.value =
                                                            jumlah.value - 1,
                                                    icon: const Icon(
                                                        Icons.remove))
                                                : const SizedBox(),
                                            10.horizontalSpace,
                                            Text(
                                              jumlah.value.toString(),
                                              style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(18),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            10.horizontalSpace,
                                            IconButton(
                                                onPressed: () => jumlah.value++,
                                                icon: const Icon(Icons.add)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  30.verticalSpace,
                                  Center(
                                    child: SizedBox(
                                      height: ScreenUtil().setHeight(40),
                                      width: 0.8.sw,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.carts.addItem(
                                            snapshot.data![index].id,
                                            snapshot.data![index].nama,
                                            snapshot.data![index].harga,
                                            snapshot.data![index].images,
                                            jumlah.value,
                                            snapshot.data![index].jenis,
                                          );
                                          Get.back();
                                          Get.snackbar(
                                            "Berhasil",
                                            "Pesanan Telah Masuk Ke Keranjang Anda",
                                            duration: const Duration(
                                                milliseconds: 500),
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white,
                                            snackPosition: SnackPosition.BOTTOM,
                                            margin: EdgeInsets.all(10.r),
                                          );
                                        },
                                        child: const Text('Masuk Keranjang'),
                                      ),
                                    ),
                                  ),
                                ],
                              ).paddingAll(20.r),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              ScreenUtil().setWidth(10),
                            ),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1.h,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    ScreenUtil().setWidth(10),
                                  ),
                                  topRight: Radius.circular(
                                    ScreenUtil().setWidth(10),
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data?[index].images ?? "",
                                  height: 100.h,
                                  width: 200.w,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      snapshot.data?[index].nama ?? "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Rp ${controller.getCurrency(snapshot.data?[index].harga.toDouble() ?? 0)}",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Icon(
                                          Icons.add_shopping_cart_rounded,
                                          color: Colors.red,
                                          size: 20.sp,
                                        ),
                                      ],
                                    ),
                                    15.verticalSpace,
                                  ],
                                ).paddingOnly(
                                    top: 10.h, left: 10.w, right: 10.w),
                              ),
                            ],
                          ),
                        ),
                      ),
                      itemCount: snapshot.data?.length,
                    );
                  }),
            ),
          )
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }

  Widget button(
      {required String text, required int index, required String image}) {
    return Obx(
      () => InkWell(
        splashColor: Colors.cyanAccent,
        onTap: () {
          controller.selectedValueIndex.value = index;
        },
        child: Container(
          height: 40.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: controller.selectedValueIndex.value == index
                ? Colors.red
                : Colors.white,
            borderRadius: BorderRadius.circular(
              ScreenUtil().setWidth(10),
            ),
            border: Border.all(
              color: Colors.red,
              width: 1.h,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  width: 20.w,
                  height: 20.h,
                  fit: BoxFit.cover,
                ),
                5.horizontalSpace,
                Text(
                  text,
                  style: TextStyle(
                    color: controller.selectedValueIndex.value == index
                        ? Colors.white
                        : Colors.black,
                    fontSize: ScreenUtil().setSp(12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
