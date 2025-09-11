import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_finance_tracker/constants/app_constants.dart';

class RecentBookings extends StatefulWidget {
  const RecentBookings({super.key});

  @override
  State<RecentBookings> createState() => _RecentBookingsState();
}

class _RecentBookingsState extends State<RecentBookings> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(10),
      height: size.height * 0.11,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusMain),
        border: Border.all(
          width: 0.08,
          color: CupertinoColors.black
        )
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Icon(CupertinoIcons.person, color: Colors.black,size: 15,),
                    Text('Joseph Kamau',style: TextStyle(fontWeight: FontWeight.w600),),
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      height: size.height * 0.032,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadiusMain),
                        border: Border.all(
                          width: 0.08,
                          color: Colors.black
                        ),
                      ),
                      child: Text('referral',style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Icon(Icons.pin_drop_outlined,color: Colors.black,size: 15,),
                    Text('City Oasis')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('8 Sept - 12 Sept')
                  ],
                )
              ],

            ),
          ),
          Column(
            children: [
              Text('ksh. 20000'),
              Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                height: size.height * 0.032,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadiusMain),
                  color: Colors.green[500],
                ),
                child: Text('Confirmed',style: TextStyle(fontWeight: FontWeight.w500),),
              )
            ],

                    )
        ],
      ),
    );
  }
}
