import 'package:flutter/material.dart';
import '../../add_contact/add_contact_page.dart';

class ContactsHeader extends StatelessWidget {
  const ContactsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Contacts',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        IconButton.filled(
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFF007AFF),
            minimumSize: const Size(32, 32),
            fixedSize: const Size(32, 32),
            padding: EdgeInsets.zero,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder:
                  (context) => Container(
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
          icon: const Icon(Icons.add, size: 28),
        ),
      ],
    );
  }
}
