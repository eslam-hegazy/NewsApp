import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemSetting extends StatelessWidget {
  final IconData icon1;
  final String text;

  ItemSetting(this.icon1, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                icon1,
                size: 30,
                color: Color(0xFF54626F),
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(text, style: Theme.of(context).textTheme.body2),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 25,
                          color: Color(0xFF54626F),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
