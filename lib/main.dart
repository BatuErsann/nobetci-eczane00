import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Deneme',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedDistrict = 'Küçükçekmece';
  String _responseText = '';

  Future<void> fetchData() async {
    final Map<String, String> districtMap = {
      'Arnavutköy': 'Arnavutk\u00F6y',
      'Ataşehir': 'Ata\u015Fehir',
      'Avcılar': 'Avc\u0131lar',
      'Bağcılar': 'Ba\u011Fc\u0131lar',
      'Bahçelievler': 'Bah\u00E7elievler',
      'Bakırköy': 'Bak\u0131rk\u00F6y',
      'Başakşehir': 'Ba\u015Fak\u015Fehir',
      'Bayrampaşa': 'Bayrampa\u015Fa',
      'Beşiktaş': 'Be\u015Fikta\u015F',
      'Beykoz': 'Beykoz',
      'Beylikdüzü': 'Beylikd\u00FCz\u00FC',
      'Beyoğlu': 'Beyo\u011Flu',
      'Büyükçekmece': 'B\u00FCy\u00FCk\u00E7ekmece',
      'Çatalca': '\u00C7atalca',
      'Çekmeköy': '\u00C7ekmek\u00F6y',
      'Esenler': 'Esenler',
      'Esenyurt': 'Esenyurt',
      'Eyüpsultan': 'Ey\u00FCpsultan',
      'Fatih': 'Fatih',
      'Gaziosmanpaşa': 'Gaziosmanpa\u015Fa',
      'Güngören': 'G\u00FCng\u00F6ren',
      'Kadıköy': 'Kad\u0131k\u00F6y',
      'Kağıthane': 'Ka\u011F\u0131thane',
      'Kartal': 'Kartal',
      'Küçükçekmece': 'K\u00FC\u00E7\u00FCk\u00E7ekmece',
      'Maltepe': 'Maltepe',
      'Pendik': 'Pendik',
      'Sancaktepe': 'Sancaktepe',
      'Sarıyer': 'Sar\u0131yer',
      'Silivri': 'Silivri',
      'Sultanbeyli': 'Sultanbeyli',
      'Sultangazi': 'Sultangazi',
      'Şile': '\u015Eile',
      'Şişli': '\u015Ei\u015Fli',
      'Tuzla': 'Tuzla',
      'Ümraniye': '\u00DCmraniye',
      'Üsküdar': '\u00DCsk\u00FCdar',
      'Zeytinburnu': 'Zeytinburnu',
    };

    final String districtKey = districtMap[_selectedDistrict] ?? '';

    final String apiUrl =
        "https://api.collectapi.com/health/dutyPharmacy?ilce=$districtKey&il=Istanbul";
    final String authToken = "3iB4sBnuSDDe4FdGDAEmaF:0g3eBwiBepsCOpCWP45MZQ";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "content-type": "application/json",
          "authorization": "apikey $authToken",
        },
      );

      if (response.statusCode == 200) {
        // Başarılı yanıtın işlenmesi burada gerçekleştirilir
        final jsonData = jsonDecode(response.body);
        final List<dynamic> pharmacies = jsonData['result'];
        String formattedText = '';
        for (int i = 0; i < pharmacies.length; i++) {
          final pharmacy = pharmacies[i];
          formattedText +=
              'Eczane ${i + 1}:\nİsim: ${pharmacy['name']}\nAdres: ${pharmacy['address']}\nTelefon: ${pharmacy['phone']}\n\n';
        }
        setState(() {
          _responseText = formattedText;
        });
      } else {
        // Hata durumunda burası işlenir
        setState(() {
          _responseText = 'Request failed with status: ${response.statusCode}.';
        });
      }
    } catch (e) {
      // Hata durumunda burası işlenir
      setState(() {
        _responseText = 'Exception occurred: $e';
      });
    }
  }

  Future<void> _launchMaps(String address) async {
    String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}";
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Deneme'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedDistrict,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDistrict = newValue!;
                });
              },
              items: <String>[
                'Arnavutköy',
                'Ataşehir',
                'Avcılar',
                'Bağcılar',
                'Bahçelievler',
                'Bakırköy',
                'Başakşehir',
                'Bayrampaşa',
                'Beşiktaş',
                'Beykoz',
                'Beylikdüzü',
                'Beyoğlu',
                'Büyükçekmece',
                'Çatalca',
                'Çekmeköy',
                'Esenler',
                'Esenyurt',
                'Eyüpsultan',
                'Fatih',
                'Gaziosmanpaşa',
                'Güngören',
                'Kadıköy',
                'Kağıthane',
                'Kartal',
                'Küçükçekmece',
                'Maltepe',
                'Pendik',
                'Sancaktepe',
                'Sarıyer',
                'Silivri',
                'Sultanbeyli',
                'Sultangazi',
                'Şile',
                'Şişli',
                'Tuzla',
                'Ümraniye',
                'Üsküdar',
                'Zeytinburnu',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchData,
              child: Text('Veriyi Getir'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    _responseText,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
