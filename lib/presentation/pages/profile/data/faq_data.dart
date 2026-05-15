import 'package:flutter/material.dart';

enum FaqCategoryId {
  booking,
  profile,
  search,
  payment,
  reviews,
  support,
  about,
}

class FaqCategory {
  final FaqCategoryId id;
  final String nameKey;
  final IconData icon;
  final Color color;

  const FaqCategory({
    required this.id,
    required this.nameKey,
    required this.icon,
    required this.color,
  });
}

class FaqItem {
  final String id;
  final FaqCategoryId categoryId;
  final String questionKey;
  final String answerKey;

  const FaqItem({
    required this.id,
    required this.categoryId,
    required this.questionKey,
    required this.answerKey,
  });
}

const List<FaqCategory> faqCategories = [
  FaqCategory(
    id: FaqCategoryId.booking,
    nameKey: 'faq_cat_booking',
    icon: Icons.event_available_rounded,
    color: Color(0xFF3B82F6),
  ),
  FaqCategory(
    id: FaqCategoryId.profile,
    nameKey: 'faq_cat_profile',
    icon: Icons.person_outline_rounded,
    color: Color(0xFF8B5CF6),
  ),
  FaqCategory(
    id: FaqCategoryId.search,
    nameKey: 'faq_cat_search',
    icon: Icons.search_rounded,
    color: Color(0xFF10B981),
  ),
  FaqCategory(
    id: FaqCategoryId.payment,
    nameKey: 'faq_cat_payment',
    icon: Icons.credit_card_rounded,
    color: Color(0xFFF59E0B),
  ),
  FaqCategory(
    id: FaqCategoryId.reviews,
    nameKey: 'faq_cat_reviews',
    icon: Icons.star_rounded,
    color: Color(0xFFEC4899),
  ),
  FaqCategory(
    id: FaqCategoryId.support,
    nameKey: 'faq_cat_support',
    icon: Icons.support_agent_rounded,
    color: Color(0xFFEF4444),
  ),
  FaqCategory(
    id: FaqCategoryId.about,
    nameKey: 'faq_cat_about',
    icon: Icons.info_outline_rounded,
    color: Color(0xFF6366F1),
  ),
];

const List<FaqItem> faqItems = [
  FaqItem(
    id: 'make_booking',
    categoryId: FaqCategoryId.booking,
    questionKey: 'faq_make_booking_q',
    answerKey: 'faq_make_booking_a',
  ),
  FaqItem(
    id: 'view_bookings',
    categoryId: FaqCategoryId.booking,
    questionKey: 'faq_view_bookings_q',
    answerKey: 'faq_view_bookings_a',
  ),
  FaqItem(
    id: 'cancel_booking',
    categoryId: FaqCategoryId.booking,
    questionKey: 'faq_cancel_booking_q',
    answerKey: 'faq_cancel_booking_a',
  ),
  FaqItem(
    id: 'reschedule',
    categoryId: FaqCategoryId.booking,
    questionKey: 'faq_reschedule_q',
    answerKey: 'faq_reschedule_a',
  ),
  FaqItem(
    id: 'booking_status',
    categoryId: FaqCategoryId.booking,
    questionKey: 'faq_booking_status_q',
    answerKey: 'faq_booking_status_a',
  ),
  FaqItem(
    id: 'edit_profile',
    categoryId: FaqCategoryId.profile,
    questionKey: 'faq_edit_profile_q',
    answerKey: 'faq_edit_profile_a',
  ),
  FaqItem(
    id: 'change_phone',
    categoryId: FaqCategoryId.profile,
    questionKey: 'faq_change_phone_q',
    answerKey: 'faq_change_phone_a',
  ),
  FaqItem(
    id: 'change_language',
    categoryId: FaqCategoryId.profile,
    questionKey: 'faq_change_language_q',
    answerKey: 'faq_change_language_a',
  ),
  FaqItem(
    id: 'delete_account',
    categoryId: FaqCategoryId.profile,
    questionKey: 'faq_delete_account_q',
    answerKey: 'faq_delete_account_a',
  ),
  FaqItem(
    id: 'logout',
    categoryId: FaqCategoryId.profile,
    questionKey: 'faq_logout_q',
    answerKey: 'faq_logout_a',
  ),
  FaqItem(
    id: 'search',
    categoryId: FaqCategoryId.search,
    questionKey: 'faq_search_q',
    answerKey: 'faq_search_a',
  ),
  FaqItem(
    id: 'categories',
    categoryId: FaqCategoryId.search,
    questionKey: 'faq_categories_q',
    answerKey: 'faq_categories_a',
  ),
  FaqItem(
    id: 'find_best_master',
    categoryId: FaqCategoryId.search,
    questionKey: 'faq_find_best_master_q',
    answerKey: 'faq_find_best_master_a',
  ),
  FaqItem(
    id: 'add_card',
    categoryId: FaqCategoryId.payment,
    questionKey: 'faq_add_card_q',
    answerKey: 'faq_add_card_a',
  ),
  FaqItem(
    id: 'payment_history',
    categoryId: FaqCategoryId.payment,
    questionKey: 'faq_payment_history_q',
    answerKey: 'faq_payment_history_a',
  ),
  FaqItem(
    id: 'payment_methods',
    categoryId: FaqCategoryId.payment,
    questionKey: 'faq_payment_methods_q',
    answerKey: 'faq_payment_methods_a',
  ),
  FaqItem(
    id: 'leave_review',
    categoryId: FaqCategoryId.reviews,
    questionKey: 'faq_leave_review_q',
    answerKey: 'faq_leave_review_a',
  ),
  FaqItem(
    id: 'rate_service',
    categoryId: FaqCategoryId.reviews,
    questionKey: 'faq_rate_service_q',
    answerKey: 'faq_rate_service_a',
  ),
  FaqItem(
    id: 'contact_support',
    categoryId: FaqCategoryId.support,
    questionKey: 'faq_contact_support_q',
    answerKey: 'faq_contact_support_a',
  ),
  FaqItem(
    id: 'master_no_show',
    categoryId: FaqCategoryId.support,
    questionKey: 'faq_master_no_show_q',
    answerKey: 'faq_master_no_show_a',
  ),
  FaqItem(
    id: 'complain_master',
    categoryId: FaqCategoryId.support,
    questionKey: 'faq_complain_master_q',
    answerKey: 'faq_complain_master_a',
  ),
  FaqItem(
    id: 'bad_review',
    categoryId: FaqCategoryId.support,
    questionKey: 'faq_bad_review_q',
    answerKey: 'faq_bad_review_a',
  ),
  FaqItem(
    id: 'what_is_ustahub',
    categoryId: FaqCategoryId.about,
    questionKey: 'faq_what_is_ustahub_q',
    answerKey: 'faq_what_is_ustahub_a',
  ),
  FaqItem(
    id: 'how_it_works',
    categoryId: FaqCategoryId.about,
    questionKey: 'faq_how_it_works_q',
    answerKey: 'faq_how_it_works_a',
  ),
  FaqItem(
    id: 'data_safety',
    categoryId: FaqCategoryId.about,
    questionKey: 'faq_data_safety_q',
    answerKey: 'faq_data_safety_a',
  ),
  FaqItem(
    id: 'notifications',
    categoryId: FaqCategoryId.about,
    questionKey: 'faq_notifications_q',
    answerKey: 'faq_notifications_a',
  ),
];

FaqCategory faqCategoryFor(FaqCategoryId id) =>
    faqCategories.firstWhere((c) => c.id == id);
