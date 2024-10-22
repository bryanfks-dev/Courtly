import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/domain/entities/payment_method_props.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key, required this.paymentMethods});

  /// [paymentMethods] is a list of [PaymentMethodProps] that contains the payment methods.
  final List<PaymentMethodProps> paymentMethods;

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is an instance of [AppColorsExtension] that contains the color values.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    /// [paymentMethod] is a function that returns a [InkWell] widget.
    /// This widget contains the payment method image and name.
    ///
    /// - Parameters:
    ///    - [prop] is an instance of [PaymentMethodProps] that contains the payment method properties.
    ///
    /// - Returns: [InkWell]
    InkWell paymentMethod(PaymentMethodProps prop) {
      return InkWell(
        onTap: () {},
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: SvgPicture(
                      AssetBytesLoader(prop.paymentImgSrc),
                      semanticsLabel: prop.paymentName,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    prop.paymentName,
                    style: TextStyle(
                      color: colorExt.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              HeroIcon(HeroIcons.chevronRight,
                  size: 18, color: colorExt.highlight),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: colorExt.outline!),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return paymentMethod(paymentMethods[index]);
        },
        itemCount: paymentMethods.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
            thickness: 1,
          );
        },
      ),
    );
  }
}
