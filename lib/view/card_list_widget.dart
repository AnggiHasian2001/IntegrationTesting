import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:rentbike/provider/service_provider.dart';

class CardListWidget extends ConsumerWidget {
  const CardListWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ngambil dari service_provider
    //buat ngambil data ke card
    final rentData = ref.watch(fetchDataProvider);
    return rentData.when(
      data: (rentData) {
        Colors.white;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: [
            Container(
              decoration: const BoxDecoration(
                //memanggil warna dari categoryColor
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              width: 5,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      //fungsi delete
                      leading: IconButton(
                        icon: const Icon(CupertinoIcons.delete),
                        onPressed: () => ref
                            .read(serviceProvider)
                            .deleteRent(rentData[getIndex].docID),
                      ),

                      //text nama penyewa
                      title: Text(
                        //menerima data dan dekorasi coret data
                        rentData[getIndex].nameRent,
                        maxLines: 1,
                        style: TextStyle(
                            decoration: rentData[getIndex].isDone
                                ? TextDecoration.lineThrough
                                : null,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),

                      //text deksripsi
                      subtitle: Text(
                        //menerima data dan dekorasi coret data
                        rentData[getIndex].description,
                        maxLines: 3,
                        style: TextStyle(
                            decoration: rentData[getIndex].isDone
                                ? TextDecoration.lineThrough
                                : null,
                            fontWeight: FontWeight.w500),
                      ),

                      //button check
                      trailing: Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          activeColor: Colors.blue.shade800,
                          shape: const CircleBorder(),
                          value: rentData[getIndex].isDone,
                          onChanged: (value) => ref
                              .read(serviceProvider)
                              .updateRent(rentData[getIndex].docID, value),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, 20),
                      child: Container(
                        child: Column(
                          children: [
                            Divider(
                              thickness: 1.2,
                              color: Colors.grey.shade200,
                            ),
                            const Gap(5),
                            Row(
                              children: [
                                const Text(
                                  'Today :',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Gap(5),
                                Text(rentData[getIndex].timeRent,
                                    style: TextStyle(
                                        decoration: rentData[getIndex].isDone
                                            ? TextDecoration.lineThrough
                                            : null,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: Colors.amber)),
                                const Gap(10),
                                const Text(
                                  'Kategori :',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Gap(5),
                                Text(rentData[getIndex].category,
                                    style: TextStyle(
                                        decoration: rentData[getIndex].isDone
                                            ? TextDecoration.lineThrough
                                            : null,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: Colors.green)),
                                const Gap(10),
                                const Text(
                                  'Date :',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Gap(5),
                                Text(rentData[getIndex].dateRent,
                                    style: TextStyle(
                                        decoration: rentData[getIndex].isDone
                                            ? TextDecoration.lineThrough
                                            : null,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: Colors.lightBlue)),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
            ))
          ]),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(stackTrace.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
