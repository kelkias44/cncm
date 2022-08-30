// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cncm_flutter_new/data/models/payment_history_model.dart';

import '../../../core/colors.dart';

class PaymentHistoryCard extends StatelessWidget {
  Payment payment;
  PaymentHistoryCard({
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  SizedBox(
        height: 130,
        child: Card(
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20,vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(payment.type.toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600,color:green),),
                      const SizedBox(height: 2),
                      Text(payment.trnxName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: greyText),),
                      const SizedBox(height: 2),
                      Text(payment.createdAt.toIso8601String(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: greyText),),
                      const SizedBox(height: 10,),
                      Text("-${payment.amount} ETB", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  width: 40,
                  height: 40,
                ),)
            ],
          ),
        ),
      ),
    );
  }
}

