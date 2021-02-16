import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';

class TermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(title: "Terms And Condition"),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Privacy Policy",
                        style: titilliumBold.copyWith(
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 15)),
                  ),
                  Text(
                      """  These Terms of use (“Website Terms”) apply to your use of the exclusive website at www.exclusiveinn.com (the “Website”). You must read these Website Terms carefully, and we recommend that you print and keep a copy for your future reference. By accessing, browsing, using or registering with the Website, you confirm that you have read, understood and agreed to these Website Terms in their entirety. If you do not agree to these Website Terms in their entirety, you must not use this Website.
You must be at least thirteen (13) years of age to use our website. By using our website [and by agreeing to these terms and conditions] you confirm and represent that you are at least thirteen (13) years of age.

Use of this Website from outside Pakistan

Exclusive may accept orders for delivery to locations outside of Pakistan subject to customs, legal, regulatory and certain practical restrictions. Those who choose to access this Website from locations outside Pakistan or place orders for delivery to locations outside Pakistan are responsible for compliance with local laws if and to the extent local laws are applicable.

Currency used to be charged outside Pakistan

All prices are charged in USD, where USD means United States Dollar Currency.


Password / Account Security

You are responsible for maintaining the confidentiality of your password and account and any activities that occur under your account. We shall not be liable to any person for any loss or damage which may arise as a result of any failure by you to protect your password or account.

Ownership of Rights

All pages of this site, including all pictures and designs, are the property of Exclusive (Private) Limited. and are protected by the Copyright Protection Act. Copying and distribution require the written consent of Exclusive (Private) Limited. Any use of this Website or its contents, including copying or storing them in whole or part, other than for your own personal, non-commercial use is prohibited without the permission of Exclusive You may not modify, distribute or re-post something on this Website for any purpose

Accuracy of Content

To the extent permitted by applicable law, Exclusive disclaims all representations and warranties, express or implied, that content or information displayed in or on this Website is accurate, complete, up-to-date and/or does not infringe the rights of any third party.

Changes to these Terms

We reserve the right to change and update these Website Terms from time to time and recommend that you revisit this page regularly to keep informed of the current Website Terms that apply to your use of this Website. By continuing to access, browse and use of this Website, you will be deemed to have agreed to any changes or updates to our Website Terms.

Acceptance of your Order

Please note that completion of the online checkout process does not constitute our acceptance of your order. Our acceptance of your order will take place only when we dispatch the product(s) or commencement of the services that you ordered from us.

If you supplied us with your email address when entering your payment details (or if you have a registered account with us), we will notify you by email as soon as possible to confirm that we have received your order.
All products that you order through the Website will remain the property of Exclusive until we have received payment in full from you for those products.

If we cannot supply you with the product or service you ordered, we will not process your order. We will inform you of this in writing (including e-mail) and, if you have already paid for the product or service, refund you in full as soon as reasonably possible.

Delivery of your Orders

Exclusive products are sold on a delivery duty unpaid basis. The recipient may have to pay import duty or a formal customs entry fee prior to or on delivery. Additional taxes, fees or levies may apply according to local legislation and customers are required to check these details before placing an order for international delivery.

We will deliver to the home or office address indicated by you when you place an order.

We cannot deliver to PO boxes. All deliveries must be signed for upon receipt. We will try at least twice to deliver your order at the address indicated by you.

We reserve the right to cancel your purchase in the event nobody is available to sign for receipt.
You bear the risk for the products once delivery is completed.

Where possible, we try to deliver in one go. We reserve the right to split the delivery of your order, for instance (but not limited to) if part of your order is delayed or unavailable. In the event that we split your order, we will notify you of our intention to do so by sending you an e-mail to the e-mail address provided by you at the time of purchase. You will not be charged for any additional delivery costs.

Charges

Delivery charges vary depending on the type of products ordered and the delivery address. You can calculate delivery charges by using our Online shipping calculator. Delivery charges are calculated on estimation and based upon your product selection. Please note that it may vary from the actual. """,
                      style: titilliumSemiBold.copyWith(
                          color: Colors.black54,
                          fontSize:
                              MediaQuery.textScaleFactorOf(context) * 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
