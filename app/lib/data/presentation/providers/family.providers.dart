import 'package:app/data/presentation/providers/dio.provider.dart';
import 'package:app/data/models/family.models.dart';
import 'package:app/data/services/family.services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' hide Family;

// 1. Provider for the Dio instance (optional, but good for testing and global config)

// 2. Provider for your RemoteServiceMedicines instance
// It depends on dioProvider, so Riverpod manages the creation order.
final remoteServiceFamilyProvider = Provider<RemoteFamilyService>((ref) {
  final dioInstance = ref.watch(authenticatedDioProvider);
  return RemoteFamilyService(dio: dioInstance); // Pass it to your service
});

// 3. FutureProvider for fetching the Welcome data
// It depends on remoteServiceMedicinesProvider to get the service instance.
final familyDataProvider = FutureProvider<List<Family>>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  final service = ref.watch(remoteServiceFamilyProvider);
  return await service.getFamily(); // getWelcomeData returns Future<Welcome>
});
