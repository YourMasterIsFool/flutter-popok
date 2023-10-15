import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_bloc.dart';
import 'package:pos_flutter/features/donation/presentation/bloc/donasi_state.dart';

class DonasiDetailScreen extends StatefulWidget {
  const DonasiDetailScreen({super.key});

  @override
  State<DonasiDetailScreen> createState() => _DonasiDetailScreenState();
}

class _DonasiDetailScreenState extends State<DonasiDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DonasiBloc, DonasiState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Donasi Detail"),
          ),
          body: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
          ),
        );
      },
    );
  }
}
