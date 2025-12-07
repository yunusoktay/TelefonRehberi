import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';
import '../../add_contact/add_contact_page.dart';

class ContactsHeader extends StatelessWidget {
  const ContactsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Contacts', style: AppTextStyles.displayLarge),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.grey,
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: const BoxDecoration(
                  color: Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: const AddContactPage(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(32),
          child: SvgPicture.asset(
            'assets/icons/add.svg',
            width: 32,
            height: 32,
          ),
        ),
      ],
    );
  }
}
