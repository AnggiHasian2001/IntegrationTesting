import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentbike/services/rent_service.dart';

final serviceProvider = StateProvider<RentService>((ref) {
  return RentService();
});
