import 'package:flutter/material.dart';

import 'colors.dart';

TextStyle headingStyle(){
  return const TextStyle(
    color: AppColors.black,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
}

TextStyle titleStyle(){
  return const TextStyle(
    color: AppColors.grey,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}

TextStyle labelStyle(){
  return const TextStyle(
    color: AppColors.grey,
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );
}

TextStyle captionStyle(){
  return const TextStyle(
    color: AppColors.grey,
    fontSize: 9,
    fontWeight: FontWeight.w500,
  );
}

TextStyle descriptionStyle(){
  return const TextStyle(
    color: Colors.white,
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );
}