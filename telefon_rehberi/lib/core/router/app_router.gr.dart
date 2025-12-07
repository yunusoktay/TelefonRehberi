// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:telefon_rehberi/screens/add_contact/add_contact_page.dart'
    as _i1;
import 'package:telefon_rehberi/screens/add_contact/widgets/success_animation_screen.dart'
    as _i3;
import 'package:telefon_rehberi/screens/contacts/contacts_page.dart' as _i2;

/// generated route for
/// [_i1.AddContactPage]
class AddContactRoute extends _i4.PageRouteInfo<void> {
  const AddContactRoute({List<_i4.PageRouteInfo>? children})
    : super(AddContactRoute.name, initialChildren: children);

  static const String name = 'AddContactRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddContactPage();
    },
  );
}

/// generated route for
/// [_i2.ContactsPage]
class ContactsRoute extends _i4.PageRouteInfo<void> {
  const ContactsRoute({List<_i4.PageRouteInfo>? children})
    : super(ContactsRoute.name, initialChildren: children);

  static const String name = 'ContactsRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.ContactsPage();
    },
  );
}

/// generated route for
/// [_i3.SuccessAnimationScreen]
class SuccessAnimationRoute extends _i4.PageRouteInfo<void> {
  const SuccessAnimationRoute({List<_i4.PageRouteInfo>? children})
    : super(SuccessAnimationRoute.name, initialChildren: children);

  static const String name = 'SuccessAnimationRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SuccessAnimationScreen();
    },
  );
}
