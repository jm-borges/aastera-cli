import '../config/config.dart';
import '../providers/user_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

void connectWebsocket(
  WebsocketManager websocketManager,
  UserProvider userProvider,
  void Function(dynamic) onNewMessage,
) {
  websocketManager.connect(
    url: Config.websocketUrl,
    authToken: Config.websocketAuthToken,
    onConnect: () => _onConnect(websocketManager, userProvider),
    onError: (err) => print("⚠️ Erro WebSocket: $err"),
    onDisconnect: (_) => print("❌ Desconectado WebSocket"),
  );

  websocketManager.on('message', onNewMessage);
}

void _onConnect(WebsocketManager websocketManager, UserProvider userProvider) {
  print("✅ Conectado via WebSocket");
  websocketManager.emit('joinRoom', userProvider.id);
}

class WebsocketManager {
  static final WebsocketManager _instance = WebsocketManager._internal();
  late io.Socket _socket;
  bool _connected = false;

  factory WebsocketManager() => _instance;

  WebsocketManager._internal();

  void connect({
    required String url,
    required String authToken,
    required Function()? onConnect,
    required Function(dynamic)? onError,
    required Function(dynamic)? onDisconnect,
  }) {
    if (_connected) return;

    _initializeSocket(url: url, authToken: authToken);
    _registerEventHandlers(
      onConnect: onConnect,
      onError: onError,
      onDisconnect: onDisconnect,
    );

    _socket.connect();
  }

  void _initializeSocket({required String url, required String authToken}) {
    _socket = io.io(
      url,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({'token': authToken})
          .build(),
    );
  }

  void _registerEventHandlers({
    Function()? onConnect,
    Function(dynamic)? onError,
    Function(dynamic)? onDisconnect,
  }) {
    _socket.onConnect((_) {
      _connected = true;
      onConnect?.call();
    });

    _socket.onError((data) {
      onError?.call(data);
    });

    _socket.onDisconnect((data) {
      _connected = false;
      onDisconnect?.call(data);
    });
  }

  void emit(String event, dynamic data) {
    if (_connected) {
      _socket.emit(event, data);
    }
  }

  void on(String event, Function(dynamic) callback) {
    _socket.on(event, callback);
  }

  void off(String event) {
    _socket.off(event);
  }

  void disconnect() {
    if (_connected) {
      _socket.disconnect();
      _connected = false;
    }
  }

  bool get isConnected => _connected;
}
