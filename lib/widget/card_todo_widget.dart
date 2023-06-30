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
    //buat ngambil data ke card
    final rentData = ref.watch(fetchDataProvider);
    return rentData.when(
      data: (rentData) {
        Color categoryColor = Colors.white;

        final getCategory = rentData[getIndex].category;
        //set warna untuk tiap kategori
        switch (getCategory) {
          case 'Pinjam':
            categoryColor = Colors.green;
            break;

          case 'Keliling':
            categoryColor = Colors.blue.shade700;
            break;

          case 'Foto':
            categoryColor = Colors.amber.shade700;
            break;
        }
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: [
            Container(
              decoration: BoxDecoration(
                //memanggil warna dari categoryColor
                color: categoryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              width: 20,
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
                        icon: Icon(CupertinoIcons.delete),
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
                                : null),
                      ),

                      //text deksripsi
                      subtitle: Text(
                        //menerima data dan dekorasi coret data
                        rentData[getIndex].description,
                        maxLines: 1,
                        style: TextStyle(
                            decoration: rentData[getIndex].isDone
                                ? TextDecoration.lineThrough
                                : null),
                      ),
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
                      offset: const Offset(0, -12),
                      child: Container(
                        child: Column(
                          children: [
                            Divider(
                              thickness: 1.5,
                              color: Colors.grey.shade200,
                            ),
                            Row(
                              children: [
                                const Text('Today'),
                                const Gap(12),
                                Text(rentData[getIndex].timeRent)
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
