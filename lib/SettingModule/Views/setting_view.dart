import 'package:flutter/material.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/text_view.dart';
import 'Components/setting_list_item.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  int pageIdx = 0;
  List settings = [
    {
      "title": "Profile",
      "icon": "assets/profile.png",
    },
    {
      "title": "Tax Rates",
      "icon": "assets/taxes.png",
    },
    {
      "title": "Contact Us",
      "icon": "assets/telephone.png",
    },

    {
      "title": "Rating",
      "icon": "assets/star.png",
    },

    {
      "title": "Log out",
      "icon": "assets/logout.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.litegreen,
      appBar: AppBar(
        backgroundColor:AppColors.appgreen ,
        title: TextView(text: "Settings"),
      ),
      body: ListView.builder(
        itemCount: settings.length,
        itemBuilder: (context, index) {
          return SettingListItem(itemData: settings[index]);
        },
      ),
    );
  }
}
