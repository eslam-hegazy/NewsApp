import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Cubit/CounterCubit.dart';
import 'package:newsapp/Cubit/CounterState.dart';
import 'package:newsapp/Widget/Item.dart';

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CounterCubit, CounterState>(
        builder: (context, index) {
          var data = CounterCubit.get(context).science;
          return Scaffold(
            body: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Item(data[index]);
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                );
              },
              itemCount: data.length,
            ),
          );
        },
        listener: (context, index) {},
      ),
    );
  }
}
