import 'package:flutter/material.dart';

class UI {
  // Colors
  static const primary = Color(0xFF3B6DFF);
  static const background = Color(0xFFFDF7FB);
  static const surface = Colors.white;
  static const muted = Color(0xFF6B7280);

  // Spacing
  static const s4 = 4.0;
  static const s8 = 8.0;
  static const s12 = 12.0;
  static const s16 = 16.0;
  static const s24 = 24.0;
  static const s32 = 32.0;

  // Radius
  static const r8 = 8.0;
  static const r12 = 12.0;
  static const r16 = 16.0;

  // Text styles
  static const title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const section = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: Colors.black87,
  );

  static const mutedText = TextStyle(
    fontSize: 13,
    color: muted,
  );
}
