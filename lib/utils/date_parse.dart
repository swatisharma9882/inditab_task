DateTime? parseDate(String dateString) {
  // Regular expression to match the date format and pad single digits
  final RegExp regExp = RegExp(r'(\d{4})-(\d{1,2})-(\d{1,2})');

  // Match the regex with the date string
  final match = regExp.firstMatch(dateString);

  if (match != null) {
    // Extract components and pad with leading zeros if necessary
    final year = match.group(1);
    final month = match.group(2)?.padLeft(2, '0');
    final day = match.group(3)?.padLeft(2, '0');

    // Create the properly formatted date string
    final formattedDateString = '$year-$month-$day';

    try {
      return DateTime.parse(formattedDateString); // Parse the formatted date
    } catch (e) {
      return null; // Return null if parsing fails
    }
  }

  return null; // Return null if no match is found
}
