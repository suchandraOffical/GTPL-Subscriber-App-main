import 'package:flutter/material.dart';
import 'package:gtpl/provider/login.dart';
import 'package:gtpl/query/broadband/generate_otp.dart';
import 'package:gtpl/query/broadband/renew_broadband.dart';
import 'package:gtpl/query/const.dart';
import 'package:gtpl/query/gateway/ccavenue.dart';
import 'package:gtpl/query/get_broad_details.dart';
import 'package:gtpl/query/global_handler.dart';
import 'package:gtpl/view/login/login.dart';
import 'package:gtpl/view/quick_pay/confirmation.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../const/const.dart';

class RechargeBroadband extends StatefulWidget {

  final String? userID;
  const RechargeBroadband({Key? key,this.userID}) : super(key: key);

  @override
  State<RechargeBroadband> createState() => _RechargeBroadbandState();
}

class _RechargeBroadbandState extends State<RechargeBroadband> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController planName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController mNumber = TextEditingController();
  TextEditingController name = TextEditingController();
  dynamic dsBroadband;

  String? mesage = "";





  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          dsBroadband != null &&
          dsBroadband!.status ==200?
              Container():
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Subcriber Details", style: TextStyle(color: greyColor)),
                  const SizedBox(
                    height: 8,
                  ),

                  TextField(
                    controller: userIdController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText:
                      'Enter Your User Id / Registered Phone no. / Customer Id',
                      hintStyle: TextStyle(color: greycolor, fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),

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
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20 ),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                        child: Text("Subcriber Details", style: TextStyle(color: greyColor))),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex: 2,
                                        child: Text("${userIdController.text}", style: TextStyle(color: blackColor))),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex:1,
                                        child: Text("Status", style: TextStyle(color: greyColor))),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text("${ dsBroadband!.resultUserDetail!.status
                                          .toString()}", style: TextStyle(color: blackColor)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex:1,
                                        child: Text("Your Name", style: TextStyle(color: greyColor))),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex: 2,
                                        child: Text("${ name.text}", style: TextStyle(color: blackColor))),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex:1,
                                        child: Text("Your Curent Plan", style: TextStyle(color: greyColor))),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        flex:2,
                                        child: Text("${ planName.text}", style: TextStyle(color: blackColor))),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex:1,
                                        child: Text("Plan Price", style: TextStyle(color: greyColor))),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        flex:2,
                                        child: Text("${ price.text}", style: TextStyle(color: blackColor))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),



                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Enter Your Phone Number",
                          style: TextStyle(color: greyColor),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: mNumber,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter Your Phone Number',
                            hintStyle: TextStyle(color: greycolor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              dsBroadband == null
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          context.loaderOverlay.show();

                          setState(() {
                            dsBroadband = null;
                          });
                          price.clear();
                          planName.clear();
                          name.clear();

                          getBroadbandUserDetails(
                            context,
                            userIdController.text,
                          ).then((value) {
                            context.loaderOverlay.hide();

                            setState(() {
                              dsBroadband = value;
                            });

                            if (dsBroadband != null) {
                              if (dsBroadband!.status == 200) {
                                userIdController.text =
                                    dsBroadband!.resultUserDetail!.userId!;
                                price.text =
                                    dsBroadband!.getSubscriberDetail!.amount!;
                                name.text =
                                    dsBroadband!.resultUserDetail!.name!;
                                planName.text = dsBroadband!
                                    .resultUserDetail!.currentPlanName!;
                              } else {
                                mesage = "User Id Not Found";
                              }
                            }
                          }).catchError((error) {
                            context.loaderOverlay.hide();

                            print(error);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    color: primaryColor.withOpacity(0.5))
                              ],
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            "Renew",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : dsBroadband != null || dsBroadband!.status == 200
                      ? Row(
                          children: [
                          /*  Center(
                                child: InkWell(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (contxt) {
                                      return AlertDialog(
                                        title: const Text("Are you sure?"),
                                        content: const Text(
                                          "You want to change your plan Login to Continue",
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.of(contxt).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Go"),
                                            onPressed: () {
                                              Provider.of<LoginProvider>(
                                                context,
                                                listen: false,
                                              ).onChanged("Broadband");

                                              GlobalHandler
                                                  .navigatorPushReplacement(
                                                      context, LoginScreen());
                                            },
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                          color: primaryColor.withOpacity(0.5))
                                    ],
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  "Change the Plan",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            )),
                            SizedBox(
                              width: 20,
                            ),*/
                            Center(
                                child: InkWell(
                              onTap: () async {
                                if (mNumber.text.length == 10) {
                                    if(dsBroadband.getSubscriberDetail.returnCode=="5000356"){
                                      errorDialog(context,
                                          "${dsBroadband.getSubscriberDetail.returnMessage}");
                                    }
                                    else{
                                      generateOtpBroadband(context, mNumber.text)
                                          .then((generateData) {
                                        if (generateData!.status == 200) {
                                          TextEditingController otpController =
                                          TextEditingController();

                                          showDialog(
                                              context: context,
                                              builder: (contxt) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Please Enter OTP"),
                                                  content: TextField(
                                                    controller: otpController,
                                                    keyboardType:
                                                    TextInputType.number,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: 'Enter OTP',
                                                      hintStyle: TextStyle(
                                                          color: greycolor),
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                      ),
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          var isTrue = (generateData
                                                              .otp
                                                              .toString() ==
                                                              otpController.text);

                                                          if (isTrue) {
                                                            GlobalHandler.navigatorPushReplacement(context,  PlanConfirmation(
                                                              dsBroadband: dsBroadband,mobileNo: mNumber.text,
                                                            ));


                                                          } else {
                                                            errorDialog(context,
                                                                "Invalid OTP");
                                                          }
                                                        },
                                                        child: Text("Verify")),
                                                  ],
                                                );
                                              });
                                        } else {
                                          errorDialog(
                                              context, "Please Try Again Later");
                                        }
                                      });
                                    }



                                } else {
                                  errorDialog(context,
                                      "Please Enter Valid Mobile Number");
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                          color: primaryColor.withOpacity(0.5))
                                    ],
                                    color: greenColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  "Recharge",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ),
                            )),
                          ],
                        )
                      : Container(),
              SizedBox(
                height: 50,
              )
            ],
          )
        ],
      ),
    );
  }

  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    getBroadbandUserDetails(
      context,
      widget.userID!,
    ).then((value) {
      context.loaderOverlay.hide();

      setState(() {
        dsBroadband = value;
      });

      if (dsBroadband != null) {
        if (dsBroadband!.status == 200) {
          userIdController.text =
          dsBroadband!.resultUserDetail!.userId!;
          price.text =
          dsBroadband!.getSubscriberDetail!.amount!;
          name.text =
          dsBroadband!.resultUserDetail!.name!;
          planName.text = dsBroadband!
              .resultUserDetail!.currentPlanName!;
        } else {
          mesage = "User Id Not Found";
        }
      }
    }).catchError((error) {
      context.loaderOverlay.hide();

      print(error);
    });
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
      'amount': num.parse(price.text) * 100,
      'name': name.text,
      'description': "Renew Plan Contact Number : " + mNumber.text,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': mNumber.text, 'email': ''},
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
        context: context, amount: price.text, name: name.text);
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
          mobileNumber: mNumber.text,
          activityName: "Current Plan",
          userId: userIdController.text,
          planName: planName.text,
          amount: price.text,
          description: "renew plan contact number : " + mNumber.text,
          paymentGatewayName: gatewayName,
          pGTransId: transactionId,
        ));
    context.loaderOverlay.hide();
    // Logger().d(value!.toJson());
    if (value != null) {
      if (value.status == 200) {
        price.clear();
        planName.clear();
        name.clear();
        userIdController.clear();
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
