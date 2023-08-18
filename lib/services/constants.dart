import 'package:flutter/material.dart';

const firstChar = [" ", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "H"];

const midleChar = [" ", "mi", "maj"];
const lastChar = [" ", "4", "5", "6", "7", "9"];

const defaultBackgroundColor = Color.fromARGB(255, 161, 196, 224);

const primaryDarkestColor = Color(0xff1D1345);
const primaryDarkColor = Color(0xff392485);
const primaryColor = Color(0xff5D3BD9);
const primaryLightColor = Color(0xff7D59FF);
const primaryLightestColor = Color(0xff9B80FF);

const grey1Color = Color(0xff313033);
const grey2Color = Color(0xff626166);
const grey3Color = Color(0xffC4C2CC);
const grey4Color = Color(0xffE9E6F2);
const grey5Color = Color(0xffF3F0FC);

const whiteColor = Colors.white;

const alertErrorDarkColor = Color(0xff7A1400);
const alertErrorColor = Color(0xffFA2900);
const alertErrorLightColor = Color(0xffFFD4CC);

const alertWarningDarkColor = Color(0xff574504);
const alertWarningColor = Color(0xffD6AA0A);
const alertWarningLightColor = Color(0xffE3D9B6);

const alertSuccessDarkColor = Color(0xff005C37);
const alertSuccessColor = Color(0xff00DB84);
const alertSuccessLightColor = Color(0xffBAE8D5);

double fontSizeRatio = 1;

const h1DesktopTextStyle = TextStyle(fontFamily: 'SofiaSans', fontSize: 48.8, color: grey1Color, fontWeight: FontWeight.w700);
const h2DesktopTextStyle = TextStyle(fontFamily: 'SofiaSans', fontSize: 39, color: grey1Color, fontWeight: FontWeight.w700);
const h3DesktopTextStyle = TextStyle(fontFamily: 'SofiaSans', fontSize: 31.25, color: grey1Color, fontWeight: FontWeight.w700);
const h4DesktopTextStyle = TextStyle(fontFamily: 'SofiaSans', fontSize: 25, color: grey1Color, fontWeight: FontWeight.w700);
const h5DesktopTextStyle = TextStyle(fontFamily: 'SofiaSans', fontSize: 18, color: grey1Color, fontWeight: FontWeight.w700);
const pDesktopTextStyle = TextStyle(fontFamily: 'SofiaSansCondensed', fontSize: 16, color: grey1Color, fontWeight: FontWeight.w400);
const labelDesktopTextStyle = TextStyle(fontFamily: 'SofiaSansCondensed', fontSize: 19.2, color: grey1Color, fontWeight: FontWeight.w400);

const h1MobileTextStyle = TextStyle(fontFamily: 'SofiaSans', fontSize: 24, color: grey1Color, fontWeight: FontWeight.w700);
const h2MobileTextStyle = TextStyle(fontFamily: 'SofiaSans', fontSize: 22, color: grey1Color, fontWeight: FontWeight.w700);
const h3MobileTextStyle = TextStyle(fontFamily: 'SofiaSans', fontSize: 20, color: grey1Color, fontWeight: FontWeight.w700);
const h4MobileTextStyle = TextStyle(fontFamily: 'SofiaSans', fontSize: 18, color: grey1Color, fontWeight: FontWeight.w700);
const h5MobileTextStyle = TextStyle(fontFamily: 'SofiaSans', fontSize: 16, color: grey1Color, fontWeight: FontWeight.w700);
const pMobileTextStyle = TextStyle(fontFamily: 'SofiaSansCondensed', fontSize: 12, color: grey1Color, fontWeight: FontWeight.w400);
const labelMobileTextStyle = TextStyle(fontFamily: 'SofiaSansCondensed', fontSize: 14, color: grey1Color, fontWeight: FontWeight.w400);

dynamic h1TextStyle;
dynamic h2TextStyle;
dynamic h3TextStyle;
dynamic h4TextStyle;
dynamic h5TextStyle;
dynamic pTextStyle;
dynamic labelTextStyle;

void resizeFontsForDesktop() {
  h1TextStyle = h1DesktopTextStyle.copyWith(fontSize: h1DesktopTextStyle.fontSize! * fontSizeRatio);
  h2TextStyle = h2DesktopTextStyle.copyWith(fontSize: h2DesktopTextStyle.fontSize! * fontSizeRatio);
  h3TextStyle = h3DesktopTextStyle.copyWith(fontSize: h3DesktopTextStyle.fontSize! * fontSizeRatio);
  h4TextStyle = h4DesktopTextStyle.copyWith(fontSize: h4DesktopTextStyle.fontSize! * fontSizeRatio);
  h5TextStyle = h5DesktopTextStyle.copyWith(fontSize: h5DesktopTextStyle.fontSize! * fontSizeRatio);
  pTextStyle = pDesktopTextStyle.copyWith(fontSize: pDesktopTextStyle.fontSize! * fontSizeRatio);
  labelTextStyle = labelDesktopTextStyle.copyWith(fontSize: labelDesktopTextStyle.fontSize! * fontSizeRatio);
}

void resizeFontsForMobile() {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

  h1TextStyle = h1MobileTextStyle;
  h2TextStyle = h2MobileTextStyle;
  h3TextStyle = h3MobileTextStyle;
  h4TextStyle = h4MobileTextStyle;
  h5TextStyle = h5MobileTextStyle;
  pTextStyle = pMobileTextStyle;
  labelTextStyle = labelMobileTextStyle;
}

void resizeFontsForWeb() {
  h1TextStyle = h1DesktopTextStyle;
  h2TextStyle = h2DesktopTextStyle;
  h3TextStyle = h3DesktopTextStyle;
  h4TextStyle = h4DesktopTextStyle;
  h5TextStyle = h5DesktopTextStyle;
  pTextStyle = pDesktopTextStyle;
  labelTextStyle = labelDesktopTextStyle;
}
