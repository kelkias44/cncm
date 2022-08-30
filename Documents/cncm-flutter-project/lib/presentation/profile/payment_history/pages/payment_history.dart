import 'package:cncm_flutter_new/core/colors.dart';
import 'package:cncm_flutter_new/presentation/profile/payment_history/bloc/payment_history_bloc.dart';
import 'package:cncm_flutter_new/presentation/profile/widgets/PaymentHistoryCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({Key? key}) : super(key: key);
  static const String paymentHistoryPageRouteName = 'payment_history_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Payment History"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<PaymentHistoryBloc, PaymentHistoryState>(
            builder: (context, state) {
              if(state is PaymentHistoryLoading){
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (ctx,i){
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor:Colors.grey[100]!,
                          child: Container(
                            height: 130,
                            color: Colors.white,
                          ),                 
                        ),
                      );
                    }
                  ),
                );
              }else if(state is PaymentHistoryLoaded){
                if(state.payments.isNotEmpty){
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: state.payments.length,
                  itemBuilder: (cxt, i) {
                    return PaymentHistoryCard(payment: state.payments[i]);
                  },
                ),
              );}else{
                return const Center(child: Text('No Payment History Yet',style: TextStyle(fontSize: 20,),));
              }
              }else if(state is PaymentHistoryError){
                return Text(state.message);
              }else{
                return const SizedBox();
              }
            },
          ),
      ),
      // ),
    );
  }
}
