

import 'package:flutter/cupertino.dart';

Map<String,double> getSizesByMediaQ(MediaQueryData mediaQueryData)
{
  double height;
  double width;
  if(mediaQueryData.orientation==Orientation.landscape) {

     width= mediaQueryData.size.height;
     height=mediaQueryData.size.width;
  }
  else
    {
      height= mediaQueryData.size.height;
      width=mediaQueryData.size.width;
    }

  return {
  "maxHeight":height,
  "maxWidth":width,
};


}

Widget sizedBoxSpacer(
{
  double height=0,
  double width=0,
}
)
{

  return SizedBox(
    height: height,
    width: width,
  );
}
