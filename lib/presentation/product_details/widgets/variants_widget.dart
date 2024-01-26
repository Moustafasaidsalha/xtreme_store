import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:extreme_store/data/models/product.dart';
import 'package:extreme_store/data/models/variant.dart';
import 'package:extreme_store/app/utilities/extension.dart';

import '../../../app/constants/colors_constants.dart';
import '../../../app/constants/fonts_constants.dart';
import '../model_view/product_details_bloc.dart';
import '../model_view/product_details_event.dart';

class VariantsWidget extends StatelessWidget {
  VariantsWidget({
    super.key,
    required this.variantNameAr,
    required this.variantNameEn,
    required this.variantValues,
    required this.variants,
    required this.productCode,
    required this.variant,
    required this.currentVariantId,
  });
  final String variantNameAr;
  final String variantNameEn;
  final String productCode;
  final List<VariantValuesModel> variantValues;
  final List<VariantsModel>? variants;
  List<String> variantValuesId=[];
  final List<VariantDetailsModel> variant;
  final int currentVariantId;
  @override
  Widget build(BuildContext context) {
    bool isAr = context.locale == const Locale("ar", "EG");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(isAr ? variantNameAr : variantNameEn,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w600)),
        variantNameEn == "color"
            ? Row(
          children: List.generate(
              variantValues.length,
                  (index) => GestureDetector(

                onTap: () {
                  variantValuesId=[];

                  for (var element in variant) {
                    if(element.id==currentVariantId){
                      variantValuesId.add(
                          variantValues[index].id.toString()
                      );
                    }else{
                      element.variantValues?.forEach((e) {
                        if(e.isSelected??false){
                          variantValuesId.add(e.id.toString()
                          );
                        }

                      }

                      );
                    }
                  }


                  ProductDetailsBloc.get(context).add(GetChangeProductsVariants(int.parse(productCode),variantValuesId,context: context ));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15.h,bottom: 15.h,right: isAr?0.h:15.h,left: isAr?15.h:0.h),
                  child: CircleAvatar(
                    backgroundColor:
                    variantValues[index].valueEn?.toColor() ??
                        ColorsConstants.lightGrey
                    ,

                    radius: 25.r,

                    child: variantValues[index].isSelected??false?const Icon(Icons.check,color: ColorsConstants.white,):const Text(""),

                  ),
                ),
              )),
        )
            : Wrap(
          children: List.generate(
              variantValues.length,
                  (index) => GestureDetector(
                onTap: () {
                  for (var element in variant) {
                    if(element.id==currentVariantId){
                      variantValuesId.add(
                          variantValues[index].id.toString()
                      );
                    }else{
                      element.variantValues?.forEach((e) {
                        if(e.isSelected??false){
                          variantValuesId.add(e.id.toString()
                          );
                        }

                      }

                      );
                    }
                  }

                  ProductDetailsBloc.get(context).add(GetChangeProductsVariants(int.parse(productCode),variantValuesId ,context: context));
                },
                child: Container(
                    height: 39.h,
                    margin: EdgeInsets.only(top: 10.h, right: 12.w),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.h, horizontal: 15.w),
                    decoration: ShapeDecoration(
                      color:  variantValues[index].isSelected??false?ColorsConstants.black:ColorsConstants.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.50, color: Color(0xFF7F7F7F)),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      isAr
                          ? variantValues[index].valueAr ?? ""
                          : variantValues[index].valueEn ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(

                          fontSize: FontSize.s14.sp,color: variantValues[index].isSelected??false?ColorsConstants.white:ColorsConstants.black),
                    )),
              )),
        )
      ],
    );
  }
}
