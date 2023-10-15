import 'package:flutter/material.dart';
import 'package:pos_flutter/config/style/style.dart';

class KegiatanScreen extends StatefulWidget {
  const KegiatanScreen({super.key});

  @override
  State<KegiatanScreen> createState() => _KegiatanScreenState();
}

class _KegiatanScreenState extends State<KegiatanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kegiatan"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: verticalPadding / 3,
          ),
        ]),
      ),
    );
  }
}
