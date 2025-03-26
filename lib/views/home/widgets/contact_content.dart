import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../providers/portfolio_provider.dart';
import '../../../utils/common.dart';
import '../../../widgets/title_header.dart';

class ContactContentWidget extends StatelessWidget {
  const ContactContentWidget({
    super.key,
    required this.nameC,
    required this.emailC,
    required this.msgC,
  });

  final TextEditingController nameC;
  final TextEditingController emailC;
  final TextEditingController msgC;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PortfolioProvider>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 800; // Define mobile breakpoint

    return Stack(
      children: [
        /// 🌟 **Background SVG**
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/svg/common-bg-5.svg", // Use your actual SVG asset
            fit: isMobile ? BoxFit.contain : BoxFit.cover,
          ),
        ),

        /// 🌟 **Main Contact Form Content**
        Container(
          color: Colors.white60,
          padding: EdgeInsets.symmetric(
            horizontal:
                isMobile ? 16 : 32, // Adjust padding for different screens
            vertical: isMobile ? 20 : 40,
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const TitleHeader(
                title: "CONTACT",
                color: Colors.black,
                content:
                    "Feel free to Contact me by submitting the form below and I will get back to you as soon as possible",
              ),
              ResponsiveWidget(
                child: Container(
                  padding: EdgeInsets.all(isMobile ? padding * 2 : padding * 3),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(controller: nameC, label: "Name"),
                      const SizedBox(height: kH20),
                      CustomTextField(controller: emailC, label: "Email"),
                      const SizedBox(height: kH20),
                      CustomTextField(
                        controller: msgC,
                        label: "Message",
                        maxLines: 5,
                      ),
                      const SizedBox(height: kH20),

                      /// **🌟 Submit Button**
                      Align(
                        alignment: isMobile
                            ? Alignment.center
                            : Alignment
                                .centerRight, // Center on mobile, Right on desktop
                        child: ElevatedButton(
                          onPressed: () async {
                            String? error = await provider.postMsg(
                                nameC.text, emailC.text, msgC.text);

                            if (error != null) {
                              showSnackbar(context,
                                  error); // Show error message in Snackbar
                            } else {
                              showSnackbar(
                                  context, "Message sent successfully!");
                            }

                            provider.postMsg(
                                nameC.text, emailC.text, msgC.text);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(isMobile ? 150 : 180, isMobile ? 50 : 60),
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16 : 20,
                              vertical: isMobile ? 12 : 15,
                            ),
                          ),
                          child: Text(
                            "SUBMIT",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: isMobile ? 14 : 16,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      ],
    );
  }
}
