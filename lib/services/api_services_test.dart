import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:gkm_mobile/services/api_services.dart';

@GenerateMocks([http.Client])
void main() {
  group('ApiService Tests', () {
    late ApiService apiService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      apiService = ApiService();
    });

    test('getData returns list of items on success', () async {
      when(mockClient.get(
        Uri.parse('${apiService.baseUrl}/test'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          '{"data": [{"id": 1, "name": "Test"}]}', 200));

      final result = await apiService.getData(
          (json) => TestModel.fromJson(json), 'test');
      
      expect(result, isA<List>());
      expect(result.length, 1);
    });

    test('postData returns item on success', () async {
      when(mockClient.post(
        Uri.parse('${apiService.baseUrl}/test'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async =>
          http.Response('{"id": 1, "name": "Test"}', 201));

      final result = await apiService.postData(
          (json) => TestModel.fromJson(json),
          {"name": "Test"},
          'test');
          
      expect(result, isA<TestModel>());
    });

    test('updateData returns updated item', () async {
      when(mockClient.put(
        Uri.parse('${apiService.baseUrl}/test/1'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => 
          http.Response('{"id": 1, "name": "Updated"}', 200));

      final result = await apiService.updateData(
          (json) => TestModel.fromJson(json),
          1,
          {"name": "Updated"},
          'test');
          
      expect(result, isA<TestModel>());
    });

    test('deleteData succeeds', () async {
      when(mockClient.delete(
        Uri.parse('${apiService.baseUrl}/test/1'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('', 200));

      expect(
        () async => await apiService.deleteData(1, 'test'),
        returnsNormally
      );
    });
  });
}

class TestModel {
  final int id;
  final String name;

  TestModel({required this.id, required this.name});

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'],
      name: json['name'], 
    );
  }
}