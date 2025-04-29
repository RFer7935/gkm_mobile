import 'package:gkm_mobile/models/dosen_praktisi.dart';
import 'package:gkm_mobile/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Mock SharedPreferences for testing
  SharedPreferences.setMockInitialValues({}); // Mock empty SharedPreferences
  var currentId = 0;

  final apiService = ApiService();
  const String apiToken = "bmFydXRvY2h1YWs5QGdtYWlsLmNvbTpoYWxvaGFsb2JhbmR1bmcxMjM="; // Replace with your actual token

  // Save API token to shared preferences (if needed)
  Future<void> saveApiToSharedPrefs() async {
    print("Menyimpan API Token ...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', apiToken);
    print("API Token disimpan\n\n");
  }

  // Fetch data
  Future<void> fetchDosenPraktisi() async {
    print("Ambil data Dosen Praktisi ...");
    try {
      final data = await apiService.getData<DosenPraktisi>(
        DosenPraktisi.fromJson,
        "dosen-praktisi",
      );
      print("Data Dosen Praktisi berhasil diambil:");
      print("Jumlah data: ${data.length}");
      print("Data Dosen Praktisi: ${data}");
      int i = 1;
      for (var dosen in data) {
        print("ID ${i}: ${dosen})");
        i++;
      }
      print("Data Dosen Praktisi berhasil diambil\n\n");
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  // Add data
  Future<void> addDosenPraktisi() async {
    print("Adding a new Dosen Praktisi...");
    final body = {
      "nama_dosen": "John Doe",
      "nidk": "123456",
      "perusahaan": "Tech Corp",
      "user_id": 1,
      "tahun_ajaran_id": 1,
      "pendidikan_tertinggi": "S2",
      "bidang_keahlian": "Teknik Informatika",
      "sertifikat_kompetensi": "Sertifikat",
      "mk_diampu": "5",
      "bobot_kredit_sks": 3.0,
    };

    try {
      var ret = await apiService.postData<DosenPraktisi>(
        DosenPraktisi.fromJson,
        body,
        "dosen-praktisi",
      );
      currentId = ret.id;
      print("Data berhasil ditambahkan dengan ID: ${ret.id}\n\n");
    } catch (e) {
      print("Error adding data: $e");
    }
  }

  // Update data
  Future<void> updateDosenPraktisi(int id) async {
    print("Updating Dosen Praktisi with ID $id...");
    final body = {
      "nama_dosen": "Jane Doe",
      "nidk": "654321",
      "perusahaan": "New Tech Corp",
      "user_id": 1,
      "tahun_ajaran_id": 1,
      "pendidikan_tertinggi": "S3",
      "bidang_keahlian": "Data Science",
      "sertifikat_kompetensi": "Advanced Certificate",
      "mk_diampu": "3",
      "bobot_kredit_sks": 4.0,
    };

    try {
      await apiService.updateData<DosenPraktisi>(
        DosenPraktisi.fromJson,
        id,
        body,
        "dosen-praktisi",
      );
      print("Data berhasil diupdate.\n\n");
    } catch (e) {
      print("Error updating data: $e");
    }
  }

  // Delete data
  Future<void> deleteDosenPraktisi(int id) async {
    print("Deleting Dosen Praktisi with ID $id...");
    try {
      await apiService.deleteData<DosenPraktisi>(
        id,
        "dosen-praktisi",
      );
      print("Data berhasil dihapus.\n\n");
    } catch (e) {
      print("Error deleting data: $e");
    }
  }

  // Run tests
  await saveApiToSharedPrefs(); // Simpan API token ke SharedPreferences
  await fetchDosenPraktisi(); // Ambil data Dosen Praktisi
  await addDosenPraktisi(); // Tambah data Dosen Praktisi dan simpan id
  await fetchDosenPraktisi(); // Ambil data Dosen Praktisi lagi
  await updateDosenPraktisi(
      currentId); // Edit data Dosen Praktisi yang ditambahkan
  await fetchDosenPraktisi(); // Ambil data Dosen Praktisi lagi
  await deleteDosenPraktisi(
      currentId); // Hapus data Dosen Praktisi yang ditambahkan
  await fetchDosenPraktisi(); // Ambil data Dosen Praktisi lagi
}