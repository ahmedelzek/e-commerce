import 'dart:io';

String extractDate(String? createdAt) {
  if (createdAt == null) return '';
  try {
    final dateTime = HttpDate.parse(createdAt);
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();
    return '$day/$month/$year';
  } catch (e) {
    return '';
  }
}

String extractTime(String? createdAt) {
  if (createdAt == null) return '';
  try {
    final dateTime = HttpDate.parse(createdAt);
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return '${hour12.toString().padLeft(2, '0')}:$minute $period';
  } catch (e) {
    return '';
  }
}