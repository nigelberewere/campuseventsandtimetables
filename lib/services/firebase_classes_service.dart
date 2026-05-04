import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore, FieldValue;

class FirebaseClassesService {
  static const String _collectionName = 'classes';
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Add a new class to Firestore
  Future<String> addClass(Map<String, dynamic> classData) async {
    try {
      final docRef = await _firestore
          .collection(_collectionName)
          .add({
            ...classData,
            'createdAt': FieldValue.serverTimestamp(),
          });
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add class: $e');
    }
  }

  /// Get all classes for a specific user
  Future<List<Map<String, dynamic>>> getClasses(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: userId)
          .orderBy('day')
          .orderBy('startTime')
          .get();

      return querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data(),
              })
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch classes: $e');
    }
  }

  /// Get all classes for a specific day
  Future<List<Map<String, dynamic>>> getClassesForDay(
    String userId,
    String day,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: userId)
          .where('day', isEqualTo: day)
          .orderBy('startTime')
          .get();

      return querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data(),
              })
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch classes for day: $e');
    }
  }

  /// Update an existing class
  Future<void> updateClass(String classId, Map<String, dynamic> classData) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(classId)
          .update({
            ...classData,
            'updatedAt': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      throw Exception('Failed to update class: $e');
    }
  }

  /// Delete a class
  Future<void> deleteClass(String classId) async {
    try {
      await _firestore.collection(_collectionName).doc(classId).delete();
    } catch (e) {
      throw Exception('Failed to delete class: $e');
    }
  }

  /// Stream of classes for real-time updates
  Stream<List<Map<String, dynamic>>> streamClasses(String userId) {
    try {
      return _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: userId)
          .orderBy('day')
          .orderBy('startTime')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => {
                    'id': doc.id,
                    ...doc.data(),
                  })
              .toList());
    } catch (e) {
      throw Exception('Failed to stream classes: $e');
    }
  }
}
