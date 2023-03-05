import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gtpl/query/const.dart';
import 'package:gtpl/query/get_broad_details.dart';
import 'package:gtpl/query/get_cable_detail.dart';
import 'package:gtpl/query/global_handler.dart';
import 'package:gtpl/view/login/login.dart';
import 'package:provider/provider.dart';

import '../../../provider/login.dart';

class ManagePlan extends StatefulWidget {
  const ManagePlan({Key? key}) : super(key: key);

  @override
  State<ManagePlan> createState() => _ManagePlanState();
}

class _ManagePlanState extends State<ManagePlan> {
  bool? accountNotFound;
  bool? accountBroadbandNotFound;
  GetUserDetailsModel? dsValue;
  dynamic dsBroadband;

  @override
  void initState() {
    GlobalHandler.getCustomerNo().then((value) {
      if (value != null) {
        setState(() {
          accountNotFound = true;
        });
        getUserDetails(context).then((value) {
          setState(() {
            dsValue = value;
          });
        });
      } else {
        setState(() {
          accountNotFound = false;
        });
      }
    });
    GlobalHandler.getBroadbandNo().then((value) async {
      if (value != null) {
        setState(() {
          accountBroadbandNotFound = true;
        });
        var getId = await GlobalHandler.getBroadbandNo();
        getBroadbandUserDetails(context, getId!).then((value) {
          setState(() {
            dsBroadband = value;
          });
        });
      } else {
        setState(() {
          accountBroadbandNotFound = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return dsValue == null && dsBroadband == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/Rectangle 181.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Manage Plan",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Showing devices connected with us ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: dsBroadband == null
                            ? () {
                                Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .onChanged("Broadband");
                                GlobalHandler.navigatorPushReplacement(
                                    context, const LoginScreen());
                              }
                            : null,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: primaryColor.withOpacity(0.1),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                MaterialIcons.live_tv,
                                color: primaryColor,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Broadband",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      dsBroadband == null
                          ? accountBroadbandNotFound == false
                              ? Column(
                                  children: const [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Add Broadband to see your devices",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                              : CircularProgressIndicator()
                          : Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Subscriber Code",
                                        style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: dsBroadband!.getSubscriberDetail!
                                                  .subscriberCode ==
                                              'nocode'
                                          ? Text(
                                              dsBroadband!
                                                  .resultUserDetail!.userId,
                                              style: TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            )
                                          : Text(
                                              dsBroadband!.getSubscriberDetail!
                                                  .subscriberCode!,
                                              style: TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Status",
                                        style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        dsBroadband!.resultUserDetail!.status!,
                                        style: TextStyle(
                                          color: blackColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Partner Code",
                                        style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        dsBroadband!
                                            .resultUserDetail!.partnerCode!,
                                        style: TextStyle(
                                          color: blackColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Current Plan",
                                        style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                          dsBroadband!.resultUserDetail!
                                              .currentPlanName!,
                                          style: TextStyle(
                                              color: blackColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text("Mobile Number",
                                          style: TextStyle(
                                              color: greyColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12)),
                                    ),
                                    Expanded(
                                      child: Text(
                                          dsBroadband!
                                              .resultUserDetail!.mobileNo!,
                                          style: TextStyle(
                                              color: blackColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text("Due Date",
                                          style: TextStyle(
                                              color: greyColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12)),
                                    ),
                                    Expanded(
                                      child: dsBroadband.getSubscriberDetail
                                                  .returnCode !=
                                              0
                                          ? Text(
                                              '0',
                                              style: TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            )
                                          : Text(
                                              dsBroadband!
                                                  .getSubscriberDetail!.dueDate!
                                                  .toString(),
                                              style: TextStyle(
                                                  color: blackColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text("Expire",
                                          style: TextStyle(
                                              color: greyColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12)),
                                    ),
                                    Expanded(
                                      child: Text(
                                          DateTime.parse(dsBroadband!
                                                      .resultUserDetail!
                                                      .expiryDate!
                                                      .toString())
                                                  .difference(DateTime.now())
                                                  .inDays
                                                  .toString() +
                                              " Days",
                                          style: TextStyle(
                                              color: blackColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text("Price",
                                          style: TextStyle(
                                              color: greyColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12)),
                                    ),
                                    Expanded(
                                      child: Text(
                                          "Rs: " +
                                              dsBroadband!
                                                  .getSubscriberDetail!.amount!
                                                  .toString(),
                                          style: TextStyle(
                                              color: blackColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text("Data left",
                                          style: TextStyle(
                                              color: greyColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12)),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "UL",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            // color: Color(0xFFE5312C),
                                            color: dsBroadband!
                                                        .resultUserDetail!
                                                        .status ==
                                                    "Active"
                                                ? Colors.green.withOpacity(0.7)
                                                : Colors.red.withOpacity(0.7),
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
