import 'package:flutter/material.dart';

/// Provides a curated list of Material icons commonly used for categories
class CategoryIcons {
  CategoryIcons._();

  /// Returns a list of commonly used icons for budget categories
  static List<IconData> get all => [
    // Food & Dining
    Icons.restaurant,
    Icons.fastfood,
    Icons.local_cafe,
    Icons.local_pizza,
    Icons.local_bar,
    Icons.lunch_dining,
    Icons.bakery_dining,
    Icons.ramen_dining,
    Icons.icecream,

    // Shopping
    Icons.shopping_cart,
    Icons.shopping_bag,
    Icons.storefront,
    Icons.local_mall,
    Icons.card_giftcard,

    // Transportation
    Icons.directions_car,
    Icons.local_gas_station,
    Icons.directions_bus,
    Icons.train,
    Icons.flight,
    Icons.directions_bike,
    Icons.electric_scooter,
    Icons.local_taxi,
    Icons.subway,

    // Home & Utilities
    Icons.home,
    Icons.electric_bolt,
    Icons.water_drop,
    Icons.local_fire_department,
    Icons.wifi,
    Icons.phone,
    Icons.router,
    Icons.cleaning_services,

    // Entertainment
    Icons.movie,
    Icons.sports_esports,
    Icons.music_note,
    Icons.theater_comedy,
    Icons.sports_soccer,
    Icons.fitness_center,
    Icons.pool,
    Icons.nightlife,

    // Health & Medical
    Icons.local_hospital,
    Icons.medical_services,
    Icons.medication,
    Icons.health_and_safety,
    Icons.favorite,
    Icons.psychology,
    Icons.spa,

    // Finance
    Icons.account_balance,
    Icons.savings,
    Icons.credit_card,
    Icons.attach_money,
    Icons.trending_up,
    Icons.account_balance_wallet,
    Icons.receipt_long,
    Icons.request_quote,

    // Education
    Icons.school,
    Icons.menu_book,
    Icons.auto_stories,
    Icons.laptop_chromebook,
    Icons.science,

    // Work & Business
    Icons.work,
    Icons.business,
    Icons.computer,
    Icons.print,
    Icons.meeting_room,
    Icons.mail,
    Icons.article,

    // Personal Care
    Icons.face,
    Icons.checkroom,
    Icons.dry_cleaning,
    Icons.content_cut,
    Icons.self_improvement,

    // Family & Kids
    Icons.child_care,
    Icons.toys,
    Icons.stroller,
    Icons.pets,
    Icons.cake,

    // Travel & Vacation
    Icons.beach_access,
    Icons.hotel,
    Icons.luggage,
    Icons.camera_alt,
    Icons.hiking,
    Icons.terrain,

    // Other
    Icons.category,
    Icons.more_horiz,
    Icons.star,
    Icons.build,
    Icons.handyman,
    Icons.volunteer_activism,
    Icons.celebration,
  ];

  /// Returns a map of category names to suggested icons
  static Map<String, IconData> get suggestions => {
    'Food': Icons.restaurant,
    'Groceries': Icons.local_grocery_store,
    'Coffee': Icons.local_cafe,
    'Fast Food': Icons.fastfood,
    'Transport': Icons.directions_car,
    'Gas': Icons.local_gas_station,
    'Public Transit': Icons.directions_bus,
    'Shopping': Icons.shopping_bag,
    'Entertainment': Icons.movie,
    'Gaming': Icons.sports_esports,
    'Health': Icons.local_hospital,
    'Gym': Icons.fitness_center,
    'Bills': Icons.receipt_long,
    'Utilities': Icons.electric_bolt,
    'Rent': Icons.home,
    'Phone': Icons.phone,
    'Internet': Icons.wifi,
    'Education': Icons.school,
    'Books': Icons.menu_book,
    'Work': Icons.work,
    'Salary': Icons.account_balance_wallet,
    'Investment': Icons.trending_up,
    'Savings': Icons.savings,
    'Kids': Icons.child_care,
    'Pets': Icons.pets,
    'Travel': Icons.flight,
    'Hotel': Icons.hotel,
    'Insurance': Icons.health_and_safety,
    'Taxes': Icons.request_quote,
    'Gifts': Icons.card_giftcard,
    'Donations': Icons.volunteer_activism,
    'Other': Icons.more_horiz,
  };
}
