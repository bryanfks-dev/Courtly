import 'package:courtly/core/config/app_color_extension.dart';
import 'package:courtly/core/constants/constants.dart';
import 'package:courtly/domain/props/team_member_props.dart';
import 'package:courtly/presentation/widgets/about_us/about_us_card.dart';
import 'package:courtly/presentation/widgets/backable_centered_app_bar.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  AboutUsPage({super.key});

  /// [_teamMembers] is the list of team members to be shown in the page.
  final List<TeamMemberProps> _teamMembers = [
    TeamMemberProps(
        imagePath: "assets/images/team/bryan.jpg",
        name: "Bryan F. K. S.",
        role: "Project Lead"),
    TeamMemberProps(
        imagePath: "assets/images/team/lin_dan.jpg",
        name: "Lin Dan C.",
        role: "Application Dev"),
    TeamMemberProps(
        imagePath: "assets/images/team/syam.jpg",
        name: "Tsalasa K. S. M.",
        role: "Application Dev"),
    TeamMemberProps(
        imagePath: "assets/images/team/patrick.jpg",
        name: "Patrick Lere D.",
        role: "Application Dev"),
  ];

  @override
  Widget build(BuildContext context) {
    /// [colorExt] is the extension of the color scheme of the application.
    final AppColorsExtension colorExt =
        Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      appBar: BackableCenteredAppBar(title: "About Us"),
      backgroundColor: colorExt.background,
      body: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: PAGE_PADDING_MOBILE),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text("Meet People Behind the Project!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: colorExt.primary,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final TeamMemberProps currentMemberProp =
                          _teamMembers[index];

                      return AboutUsCard(
                          imagePath: currentMemberProp.imagePath,
                          name: currentMemberProp.name,
                          position: currentMemberProp.role);
                    },
                  ),
                ],
              ))),
    );
  }
}
