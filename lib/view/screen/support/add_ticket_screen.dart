import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/body/support_ticket_body.dart';
import 'package:sixvalley_ui_kit/provider/support_ticket_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/string_resources.dart';
import 'package:sixvalley_ui_kit/view/basewidget/button/custom_button.dart';
import 'package:sixvalley_ui_kit/view/basewidget/show_custom_snakbar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_expanded_app_bar.dart';
import 'package:sixvalley_ui_kit/view/basewidget/textfield/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddTicketScreen extends StatefulWidget {
  final String type;
  AddTicketScreen({@required this.type});

  @override
  _AddTicketScreenState createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  final TextEditingController _subjectController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final FocusNode _subjectNode = FocusNode();

  final FocusNode _descriptionNode = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CustomExpandedAppBar(
      title: Strings.support_ticket,
      isGuestCheck: true,
      child: ListView( physics: BouncingScrollPhysics(), padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE), children: [

      Text(Strings.add_new_ticket, style: titilliumSemiBold.copyWith(fontSize: 20)),
      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

      Container(
        color: ColorResources.LOW_GREEN,
        margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
        child: ListTile(
          leading: Icon(Icons.query_builder, color: ColorResources.COLOR_PRIMARY),
          title: Text(widget.type, style: robotoBold),
          onTap: () {},
        ),
      ),

      CustomTextField(
        focusNode: _subjectNode,
        nextNode: _descriptionNode,
        textInputAction: TextInputAction.next,
        hintText: Strings.write_your_subject,
        controller: _subjectController,
      ),
      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

      CustomTextField(
        focusNode: _descriptionNode,
        textInputAction: TextInputAction.done,
        hintText: Strings.issue_description,
        textInputType: TextInputType.multiline,
        controller: _descriptionController,
        maxLine: 5,
      ),
      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

      Provider.of<SupportTicketProvider>(context).isLoading
          ? Center(child: CircularProgressIndicator())
          : Builder(
        key: _scaffoldKey,
        builder: (context) => CustomButton(
            buttonText: Strings.submit,
            onTap: () {
              if (_subjectController.text.isEmpty) {
                showCustomSnackBar('Subject box should not be empty', context);
              } else if (_descriptionController.text.isEmpty) {
                showCustomSnackBar('Description box should not be empty', context);
              } else {
                SupportTicketBody supportTicketModel = SupportTicketBody(widget.type, _subjectController.text, _descriptionController.text);
                Provider.of<SupportTicketProvider>(context, listen: false).sendSupportTicket(supportTicketModel, callback);
              }
            }),
      ),

    ]),
    );
  }

  void callback (bool isSuccess, String message) {
    print(message);
    if (isSuccess) {
      _subjectController.text = '';
      _descriptionController.text = '';
      Navigator.of(context).pop();
    } else {}
  }
}
