import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/keranjang_controller.dart';

class KeranjangView extends GetView<KeranjangController> {
  const KeranjangView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        child: SizedBox(
          height: 0.3.sh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Rincian Harga",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Subtotal'),
                  Text('Rp. 97.000'),
                ],
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Pajak (11%)'),
                  Text('Rp. 9700'),
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
                          fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  Text('Rp. 106.700',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold)),
                ],
              ),
              20.verticalSpace,
              Center(
                child: SizedBox(
                  height: ScreenUtil().setHeight(40),
                  width: 0.8.sw,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/appIcon.png',
                                  height: 100.h,
                                  width: 100.w,
                                ),
                                10.verticalSpace,
                                Text(
                                  'Silahkan Isi Form Berikut Untuk Memproses Pesanan',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                20.verticalSpace,
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Nama Lengkap',
                                    labelStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                20.verticalSpace,
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'No Handphone',
                                    labelStyle: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                40.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        height: ScreenUtil().setHeight(40),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 1,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Cek ulang pesanan",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                    ),
                                    20.horizontalSpace,
                                    Flexible(
                                      child: Container(
                                        height: ScreenUtil().setHeight(40),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blue,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Konfirmasi",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                20.verticalSpace,
                              ],
                            ).paddingSymmetric(
                                horizontal: 20.w, vertical: 10.h),
                          ),
                        ),
                      );
                    },
                    child: const Text('Lanjutkan Pesanan'),
                  ),
                ),
              ),
            ],
          ).paddingOnly(top: 20.h, bottom: 10.h, left: 20.w, right: 20.w),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pesanan Anda', style: TextStyle(fontSize: 20)),
                20.verticalSpace,
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Shrimp Tempura'),
                      subtitle: Text('1 item'),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/shrimpball.png',
                          height: 50.h,
                          width: 50.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      trailing: Text('Rp. 10.000'),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 2.h,
                    );
                  },
                ),
              ],
            ).paddingAll(20.r),
          ),
        ),
      ),
    );
  }
}
