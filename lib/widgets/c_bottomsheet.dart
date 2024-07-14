import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:jantari/utils/size_config.dart';
import 'package:jantari/utils/styles.dart';
import 'package:jantari/widgets/c_button.dart';

// blocs
import 'package:jantari/bloc/auth/bloc.dart';
import 'package:jantari/bloc/homePage/bloc.dart';

customOtpBottomSheet({
  required BuildContext context,
  required GlobalKey<FormState> pinCodeKey,
  required TextEditingController pinCodeController,
  required Map formControllers,
}) {
  bool showLoader = false;
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(SizeConfig.resizeWidth(5.42)),
                  topLeft: Radius.circular(SizeConfig.resizeWidth(5.42)),
                ),
              ),
              child: SingleChildScrollView(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    /*This method here will hide the soft keyboard.*/
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Form(
                    key: pinCodeKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.resizeWidth(3.5),
                          horizontal: SizeConfig.resizeWidth(3.7),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            // horizontal: 4,
                            vertical: SizeConfig.resizeWidth(1.7),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Verify OTP",
                                style: TextStyle(
                                  // fontSize: SizeConfig.resizeFont(20.95),
                                  fontSize: SizeConfig.resizeFont(
                                      CustomFonts.customHeadingTwo),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.resizeWidth(6.98),
                              ),
                              Text(
                                "A 6-digit code has been sent to your verified phone number and email address.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: SizeConfig.resizeFont(
                                      CustomFonts.customParagraph),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.resizeWidth(5.42),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: PinCodeTextField(
                                  controller: pinCodeController,
                                  appContext: context,
                                  length: 4,
                                  //TODO: change length to 6
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  textStyle: TextStyle(
                                    color: Color(0xFF014EA2),
                                    fontSize: SizeConfig.resizeFont(22),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  animationType: AnimationType.fade,
                                  cursorColor: Colors.white,
                                  pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(13),
                                      fieldHeight: SizeConfig.resizeWidth(14),
                                      fieldWidth: SizeConfig.resizeWidth(14),
                                      errorBorderColor: Colors.red,
                                      inactiveColor: CustomColors
                                          .customPrimaryLighterColor,
                                      selectedColor: CustomColors
                                          .customPrimaryLighterColor,
                                      inactiveFillColor: CustomColors
                                          .customPrimaryLighterColor,
                                      activeFillColor: CustomColors
                                          .customPrimaryLighterColor,
                                      activeColor: CustomColors
                                          .customPrimaryLighterColor,
                                      selectedFillColor: CustomColors
                                          .customPrimaryLighterColor),
                                  animationDuration:
                                      Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  onCompleted: (v) {
                                    print("Completed");
                                  },
                                  onChanged: (value) {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required';
                                    } else {
                                      return null;
                                    }
                                  },
                                  beforeTextPaste: (text) {
                                    print("Allowing to paste $text");
                                    //if you return true then it will show the paste confirmation dialog.
                                    // Otherwise if false, then nothing will happen.
                                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                    return true;
                                  },
                                  // underlinedInput: true
                                ),
                              ),
                              SizedBox(height: SizeConfig.resizeWidth(2.56)),
                              Text(
                                "Resend Code",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: SizeConfig.resizeFont(
                                      CustomFonts.customParagraph),
                                  decoration: TextDecoration.underline,
                                  color: CustomColors.customPrimaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: SizeConfig.resizeWidth(6.98)),
                              BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) {
                                  // if (state is OtpStateLoading) {
                                  //   setModalState(() {
                                  //     showLoader = true;
                                  //   });
                                  //   // setState(() {
                                  //   //   showLoader = true;
                                  //   // });
                                  // } else if (state is OtpStateLoaded) {
                                  //   print("phone verified :)");
                                  //   var finalFormValues = {};
                                  //   formControllers.forEach((key, val) {
                                  //     finalFormValues[key] = val.text;
                                  //   });
                                  //   finalFormValues["DOIsResident"] = context
                                  //       .read<HomePageBloc>()
                                  //       .state
                                  //       .isResident;
                                  //   finalFormValues["DOProductType"] = context
                                  //       .read<HomePageBloc>()
                                  //       .state
                                  //       .productType;
                                  //   print("finalFormValues: $finalFormValues");
                                  //   context.read<WorkflowBloc>().add(
                                  //         CreateWorkflow(
                                  //           StaticData.productCode,
                                  //           finalFormValues,
                                  //         ),
                                  //       );
                                  // }
                                },
                                builder: (context, state) {
                                  if (showLoader) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return CButton(
                                      text: "Continue",
                                      lightTheme: false,
                                      onPressed: () {
                                        if (pinCodeKey.currentState!
                                            .validate()) {
                                          // context.read<AuthBloc>().add(
                                          //       OtpSubmitted(
                                          //           pinCodeController.text),
                                          //     );
                                          // // print("validate");
                                          // // Navigator.of(context).pop();
                                          // // confirmedBottomSheet();
                                        }
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
