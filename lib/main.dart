// ignore_for_file: avoid_print, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:typed_data';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BluetoothControlPage(),
    );
  }
}

class BluetoothControlPage extends StatefulWidget {
  const BluetoothControlPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BluetoothControlPageState createState() => _BluetoothControlPageState();
}

class _BluetoothControlPageState extends State<BluetoothControlPage> {
  BluetoothConnection? connection;
  String sensorData = "Aguardando dados...";
  String commandSent = "Nenhum comando enviado";
  bool isConnected = false;

  // Função para conectar ao Bluetooth
  void connectToBluetooth() async {
    try {
      // Escaneia dispositivos Bluetooth disponíveis
      final BluetoothDevice device = await FlutterBluetoothSerial.instance
          .getBondedDevices()
          .then((devices) => devices.firstWhere((device) => device.name == 'HC-05'));

      // Estabelece conexão com o dispositivo
      connection = await BluetoothConnection.toAddress(device.address);
      setState(() {
        isConnected = true;
        print('Conectado ao dispositivo ${device.name}');
      });

      // Inicia leitura dos sensores
      listenToSensors();
    } catch (e) {
      print("Erro ao conectar: $e");
    }
  }

  // Função para ler os dados dos sensores
  void listenToSensors() {
    connection!.input!.listen((Uint8List data) {
      setState(() {
        sensorData = String.fromCharCodes(data).trim();
      });

      List<String> sensors = sensorData.split(',');

      int sensorEsquerda = int.parse(sensors[0]);
      int sensorDireita = int.parse(sensors[1]);

      // Decidir o movimento com base nos dados
      if (sensorEsquerda > 500 && sensorDireita > 500) {
        sendCommandToArduino('F'); // Mover reto
      } else if (sensorEsquerda < 500) {
        sendCommandToArduino('L'); // Virar esquerda
      } else if (sensorDireita < 500) {
        sendCommandToArduino('R'); // Virar direita
      }
    }).onDone(() {
      // ignore: avoid_print
      print('Desconectado do Bluetooth');
    });
  }

  // Função para enviar comando ao Arduino
  void sendCommandToArduino(String command) {
    connection!.output.add(Uint8List.fromList(command.codeUnits));
    setState(() {
      commandSent = "Comando enviado: $command";
    });
  }

  @override
  void dispose() {
    connection?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle Bluetooth'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: isConnected ? null : connectToBluetooth,
              child: Text(isConnected ? 'Conectado' : 'Conectar ao HC-05'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Dados dos Sensores:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              sensorData,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Último comando enviado:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              commandSent,
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

