import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rentbike/constants/app_style.dart';
import 'package:rentbike/widget/textfield_widget.dart';

class AddNewRentModel extends StatelessWidget {
  const AddNewRentModel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: double.infinity,
              child: Text(
                'New Rent',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          const Gap(6),
          const Text(
            'Nama Penyewa',
            style: AppStyle.headingOne,
          ),
          const Gap(6),
          TextFieldWidget(maxLine: 1, hintText: 'Masukkan Nama Penyewa'),
        ],
      ),
    );
  }
}
