import 'package:flutter/material.dart';
import 'package:local_restaurant_2/api/api_service.dart';
import 'package:local_restaurant_2/json/restaurant.dart';
import 'package:local_restaurant_2/ui/detail_page.dart';

class AddReview extends StatefulWidget {
  final String id;
  final Restaurantz restaurantz;
  const AddReview({Key? key, required this.id, required this.restaurantz})
      : super(key: key);

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  TextEditingController name = TextEditingController();
  TextEditingController review = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    review.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Review"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(hintText: "Nama"),
                ),
                TextField(
                  controller: review,
                  decoration: const InputDecoration(hintText: "Review"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ApiService().sendReview(widget.id, name.text, review.text);
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          title: const Text('Pengiriman review berhasil'),
                          content: const Text('Silahkan kembali'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Tambah komentar'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Detail(
                                    id: widget.id,
                                    restaurantz: widget.restaurantz,
                                  );
                                },
                              )),
                              child: const Text('Kembali'),
                            ),
                          ]),
                    );
                  },
                  child: const Text("Kirim"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
