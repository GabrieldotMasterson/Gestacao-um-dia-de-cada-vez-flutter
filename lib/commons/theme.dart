import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Palette ────────────────────────────────────────────────────
const Color kPrimary = Color(0xFFE8849C);       // warm rose
const Color kPrimaryLight = Color(0xFFF5C6D3); // soft pink tint
const Color kPrimaryDark = Color(0xFFD45E7A);  // deeper rose
const Color kAccent = Color(0xFFFFB7C5);       // baby pink
const Color kSurface = Color(0xFFFFF8F9);      // off-white warm
const Color kCardBg = Color(0xFFFFFFFF);
const Color kTextDark = Color(0xFF3D2B35);     // warm dark
const Color kTextMid = Color(0xFF7A5C65);      // warm mid
const Color kTextLight = Color(0xFFA88896);    // warm light
const Color kPremiumGold = Color(0xFFD4A853);  // gold accent
const Color kPremiumGoldLight = Color(0xFFF5E6C8);

final theme = ThemeData(
  useMaterial3: true,

  colorScheme: ColorScheme.fromSeed(
    seedColor: kPrimary,
    primary: kPrimary,
    onPrimary: Colors.white,
    primaryContainer: kPrimaryLight,
    onPrimaryContainer: kTextDark,
    secondary: kAccent,
    onSecondary: kTextDark,
    tertiary: kPremiumGold,
    onTertiary: Colors.white,
    surface: kSurface,
    onSurface: kTextDark,
    surfaceVariant: kPrimaryLight,
    onSurfaceVariant: kTextMid,
    error: const Color(0xFFE06060),
    onError: Colors.white,
  ),

  textTheme: GoogleFonts.outfitTextTheme().copyWith(
    displayLarge: GoogleFonts.outfit(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: kTextDark,
    ),
    displayMedium: GoogleFonts.outfit(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: kTextDark,
    ),
    displaySmall: GoogleFonts.outfit(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: kTextDark,
    ),
    titleLarge: GoogleFonts.outfit(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: kTextDark,
    ),
    titleMedium: GoogleFonts.outfit(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: kTextDark,
    ),
    titleSmall: GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: kTextDark,
    ),
    bodyLarge: GoogleFonts.outfit(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: kTextMid,
    ),
    bodyMedium: GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: kTextLight,
    ),
    bodySmall: GoogleFonts.outfit(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: kTextLight,
    ),
    labelLarge: GoogleFonts.outfit(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    labelMedium: GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: kSurface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: GoogleFonts.outfit(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: kTextDark,
    ),
    toolbarHeight: 64,
  ),

  cardTheme: CardThemeData(
    color: kCardBg,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    surfaceTintColor: Colors.transparent,
    margin: EdgeInsets.zero,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 15),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      elevation: 0,
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: kPrimary,
      side: const BorderSide(color: kPrimary, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 15),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kPrimaryLight.withValues(alpha: 0.4),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: kPrimary, width: 1.5),
    ),
    labelStyle: GoogleFonts.outfit(color: kTextLight, fontSize: 14),
    hintStyle: GoogleFonts.outfit(color: kTextLight, fontSize: 14),
  ),

  scaffoldBackgroundColor: kSurface,
  splashFactory: InkSplash.splashFactory,
);
