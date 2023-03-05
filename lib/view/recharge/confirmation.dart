import 'package:flutter/material.dart';
import 'package:gtpl/provider/login.dart';
import 'package:gtpl/query/broadband/generate_otp.dart';
import 'package:gtpl/query/broadband/renew_broadband.dart';
import 'package:gtpl/query/const.dart';
import 'package:gtpl/query/gateway/ccavenue.dart';
import 'package:gtpl/query/get_broad_details.dart';
import 'package:gtpl/query/global_handler.dart';
import 'package:gtpl/view/login/login.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../const/const.dart';

class PlanConfirmation extends StatefulWidget {
  dynamic dsBroadband;
  String? mobileNo;

  PlanConfirmation({Key? key, this.dsBroadband, this.mobileNo})
      : super(key: key);

  @override
  State<PlanConfirmation> createState() => _PlanConfirmationState();
}

class _PlanConfirmationState extends State<PlanConfirmation> {
  dynamic dsBroadband;

  String? mesage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: BackButton(
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Center(
              child: Text("Plan Summery",
                  style:
                  TextStyle(color: blackColor,fontSize: 20)),
            ),
            SizedBox(height: 10,),
            dsBroadband == null
                ? Container()
                : dsBroadband!.status == 200
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Card(
                            color: greycolorLight,
                            elevation: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text("Subcriber Details",
                                              style:
                                                  TextStyle(color: greyColor))),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                              "${dsBroadband!.resultUserDetail!.userId!}",
                                              style: TextStyle(
                                                  color: blackColor))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text("Status",
                                              style:
                                                  TextStyle(color: greyColor))),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                            "${dsBroadband!.resultUserDetail!.status.toString()}",
                                            style:
                                                TextStyle(color: blackColor)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text("Your Name",
                                              style:
                                                  TextStyle(color: greyColor))),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                              "${dsBroadband!.resultUserDetail!.name!}",
                                              style: TextStyle(
                                                  color: blackColor))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text("Your Curent Plan",
                                              style:
                                                  TextStyle(color: greyColor))),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                              "${dsBroadband!.resultUserDetail!.currentPlanName!}",
                                              style: TextStyle(
                                                  color: blackColor))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text("Plan Price",
                                              style:
                                                  TextStyle(color: greyColor))),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                              "${dsBroadband!.getSubscriberDetail!.amount!}",
                                              style: TextStyle(
                                                  color: blackColor))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text("Mobile No",
                                              style:
                                                  TextStyle(color: greyColor))),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Text("${widget.mobileNo!}",
                                              style: TextStyle(
                                                  color: blackColor))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ListTile(
                          tileColor: Colors.red,
                          textColor: Colors.white,
                          // trailing: Icon(Icons.close, color: Colors.white),
                          title: Text("Error",
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text("No Data Found",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 3, spreadRadius: 2),
        ], color: Colors.white),
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Please Select Payment Gateway",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      InkWell(
                        onTap: () {
                          ccAvenue();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "CCAvenue",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          razorpay();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "Razorpay",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ]),
                  );
                });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
            ),
            child: const Center(
              child: Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    dsBroadband = widget.dsBroadband;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void razorpay() async {
    var options = {
      'key': 'rzp_live_EzOfSBuBoB1d86',
      'amount': num.parse(dsBroadband!.getSubscriberDetail!.amount!) * 100,
      'name': dsBroadband!.resultUserDetail!.name!,
      'description': "Renew Plan Contact Number : " + widget.mobileNo!,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': widget.mobileNo!, 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    Navigator.pop(context);
    Navigator.pop(context);
    recharge(response.paymentId, "Razorpay");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    // Navigator.pop(context);
    // Navigator.pop(context);
    Navigator.pop(context);
    customDialog(context, "Payment unsuccessfully", "Error in Renewing Plan");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    // Navigator.pop(context);
    // Navigator.pop(context);
    Navigator.pop(context);
    customDialog(context, "Payment unsuccessfully", "Error in Renewing Plan");
  }

  Future<void> ccAvenue() async {
    Navigator.pop(context);
    var details = await payCCavenue(
        context: context,
        amount: dsBroadband!.getSubscriberDetail!.amount!,
        name: dsBroadband!.resultUserDetail!.name!);
    Logger().d(details);
    if (details != null) {
      if (details['order_status'] == 'Success') {
        Navigator.pop(context);
        context.loaderOverlay.show();
        recharge(details['details']['order_id'], "CCAvenue");
      }
    } else {
      customDialog(context, "Payment unsuccessfull", "Error in Renewing Plan");
    }
  }

  recharge(transactionId, gatewayName) async {
    var value = await renewPlan(
        context,
        ParamsRenewModel(
          mobileNumber: widget.mobileNo!,
          activityName: "Current Plan",
          userId: dsBroadband!.resultUserDetail!.userId!,
          planName: dsBroadband!.resultUserDetail!.currentPlanName!,
          amount: dsBroadband!.getSubscriberDetail!.amount!,
          description: "renew plan contact number : " + widget.mobileNo!,
          paymentGatewayName: gatewayName,
          pGTransId: transactionId,
        ));
    context.loaderOverlay.hide();
    // Logger().d(value!.toJson());
    if (value != null) {
      if (value.status == 200) {
        setState(() {
          dsBroadband = null;
        });

        customDialog(context, "Success ", "Plan Renewed Successfully");
      } else {
        errorDialog(context, "Error in Renewing Plan");
      }
    }
  }
}

void errorDialog(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("Done"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}

void customDialog(BuildContext context, String title, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("Done"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}
