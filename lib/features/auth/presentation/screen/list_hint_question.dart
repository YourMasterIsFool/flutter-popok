import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/features/lupa_password/model/hint_question_model.dart';
import 'package:pos_flutter/features/lupa_password/presentation/bloc/lupa_password_bloc.dart';
import 'package:pos_flutter/features/lupa_password/presentation/bloc/lupa_password_state.dart';

class ListHintQuestion extends StatefulWidget {
  const ListHintQuestion({super.key, this.question});
  final HintQuestionModel? question;

  @override
  State<ListHintQuestion> createState() => _ListHintQuestionState();
}

class _ListHintQuestionState extends State<ListHintQuestion> {
  late LupaPasswordBloc lupaPasswordBloc;

  @override
  void initState() {
    lupaPasswordBloc = context.read<LupaPasswordBloc>();
    lupaPasswordBloc.getListQuestionBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih hint"),
      ),
      body: Container(
        child: BlocConsumer<LupaPasswordBloc, LupaPasswordState>(
            builder: (context, state) {
          if (state is LoadingHintQuestion) {
            return Container(
              child: CircularProgressIndicator(),
              width: 30,
              height: 30,
            );
          }
          if (state is SuccessGetHintQuestion) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return tileQuestion(
                  model: state.listQuestion[index],
                  isSelected: state.listQuestion[index] == widget.question,
                );
              },
              itemCount: state.listQuestion.length,
            );
          }

          return Container();
        }, listener: (context, state) {
          print(state.toString());
        }),
        margin: EdgeInsets.only(top: verticalPadding / 2),
        // padding: EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
      ),
    );
  }
}

class tileQuestion extends StatelessWidget {
  const tileQuestion({
    super.key,
    required this.model,
    this.isSelected = false,
  });
  final HintQuestionModel model;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
          color:
              isSelected ? primaryColor.withOpacity(0.2) : Colors.transparent),
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context, model);
        },
        child: Row(children: [
          Expanded(child: Text(model.question)),
          SizedBox(
            width: 12.w,
          ),
          Icon(
            isSelected ? Icons.circle : Icons.circle_outlined,
            color: isSelected ? primaryColor : Colors.transparent,
          )
        ]),
      ),
    );
  }
}
