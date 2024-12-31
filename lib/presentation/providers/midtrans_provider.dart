import 'package:courtly/core/config/midtrans_env.dart';
import 'package:courtly/core/constants/color_schemes.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';

/// [MidtransProvider] is the provider for the Midtrans SDK.
class MidtransProvider {
  /// [_midtransSDK] is the instance of the [MidtransSDK].
  static MidtransSDK? _midtransSDK;

  /// [midtransSDK] is the instance of the [MidtransSDK].
  /// It is used to interact with the Midtrans SDK.
  ///
  /// Returns the instance of the [MidtransSDK].
  static MidtransSDK? get midtransSDK => _midtransSDK;

  /// [initSDK] is a method to initialize the Midtrans SDK.
  /// It is used to initialize the Midtrans SDK.
  ///
  /// Returns a [Future] of [void].
  static Future<void> initSDK() async {
    // Initialize the Midtrans SDK
    _midtransSDK = await MidtransSDK.init(
        config: MidtransConfig(
            clientKey: MidtransEnv.clientKey,
            merchantBaseUrl: "",
            colorTheme: ColorTheme(
              colorPrimary: ColorSchemes.primaryLight,
              colorPrimaryDark: ColorSchemes.primaryDark,
            )));

    // Set the custom settings
    _midtransSDK?.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );
  }

  /// [startPayment] is a method to start the payment flow.
  /// It is used to start the payment flow.
  ///
  /// Parameters:
  ///   - [paymentToken] is the payment token to start the payment flow.
  ///
  /// Returns a [Future] of [void].
  static Future<void> startPayment({required String paymentToken}) async {
    _midtransSDK?.startPaymentUiFlow(token: paymentToken);
  }
}
