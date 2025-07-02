import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/queue_item.dart';
import '../services/queue_service.dart';

class QueueProvider with ChangeNotifier {
  final QueueService _queueService;
  
  List<QueueItem> _queueItems = [];
  bool _isLoading = false;
  String? _error;
  Timer? _refreshTimer;

  QueueProvider(this._queueService) {
    _startPeriodicRefresh();
  }

  List<QueueItem> get queueItems => _queueItems;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _startPeriodicRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      refreshQueue();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> refreshQueue() async {
    try {
      final updatedQueue = await _queueService.getCurrentQueue();
      _queueItems = updatedQueue;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to refresh queue: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<QueueItem> joinQueue(String userId, String serviceId) async {
    try {
      final queueItem = await _queueService.joinQueue(userId, serviceId);
      _queueItems.add(queueItem);
      notifyListeners();
      return queueItem;
    } catch (e) {
      _error = 'Failed to join queue: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> leaveQueue(String queueItemId) async {
    try {
      await _queueService.leaveQueue(queueItemId);
      _queueItems.removeWhere((item) => item.id == queueItemId);
      notifyListeners();
    } catch (e) {
      _error = 'Failed to leave queue: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<QueueItem?> getUserQueuePosition(String userId) async {
    try {
      return await _queueService.getUserQueuePosition(userId);
    } catch (e) {
      _error = 'Failed to get queue position: ${e.toString()}';
      notifyListeners();
      return null;
    }
  }

  Future<void> updateQueueStatus(String queueItemId, bool isBeingServed) async {
    try {
      await _queueService.updateQueueStatus(queueItemId, isBeingServed);
      await refreshQueue();
    } catch (e) {
      _error = 'Failed to update queue status: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> removeFromQueue(String queueItemId) async {
    try {
      await _queueService.removeFromQueue(queueItemId);
      _queueItems.removeWhere((item) => item.id == queueItemId);
      notifyListeners();
    } catch (e) {
      _error = 'Failed to remove from queue: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<Duration> getEstimatedWaitingTime(String serviceId) async {
    try {
      return await _queueService.getEstimatedWaitingTime(serviceId);
    } catch (e) {
      _error = 'Failed to get estimated waiting time: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
