import 'package:volt/data/config/base_api.dart';
import 'package:volt/data/remote/chat_apis/chat_repo.dart';
import 'package:volt/models/api/chat_responses.dart';
import 'package:volt/models/api/chat_requests.dart';
import 'package:volt/models/api/general_request.dart';

class ChatRepoImpl extends BaseApi implements ChatRepository {
  static const String sendText = 'support';
  static const String getTexts = 'support';

  ChatRepoImpl(String baseApi) : super(baseApi);
  @override
  Future<SendChatResponse> sendMessage(SendChatRequest request) async {
    var response = await post(sendText, data: request.toMap());
    return SendChatResponse.fromMap(response);
  }

  @override
  Future<GetChatResponse> getMessages(GeneralRequest request) async {
    var response = await get(getTexts);
    return GetChatResponse.fromMap(response);
  }
}
