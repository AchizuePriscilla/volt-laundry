import 'dart:convert';
import 'package:volt/data/local/local_cache.dart';
import 'package:volt/data/remote/chat_apis/chat_repo.dart';
import 'package:volt/data/remote/chat_apis/chat_service.dart';
import 'package:volt/models/api/chat_responses.dart';
import 'package:volt/models/api/chat_requests.dart';
import 'package:volt/models/api/general_request.dart';

class ChatServiceImpl implements ChatService {
  final ChatRepository chatRepository;
  final LocalCache localCache;

  ChatServiceImpl({required this.chatRepository, required this.localCache});

  @override
  Future<SendChatResponse> sendMessage(SendChatRequest request) async {
    var res = await chatRepository.sendMessage(request);
    return res;
  }

  @override
  Future<GetChatResponse> getMessages(GeneralRequest request) async {
    var res = await chatRepository.getMessages(request);
    if (res.success) {
      await localCache.cacheUserData(value: json.encode(res.chat!.toMap()));
    }
    return res;
  }
}
