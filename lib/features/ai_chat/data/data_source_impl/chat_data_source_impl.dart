import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:trait_lens/core/errors/exceptions.dart' as exceptions;
import 'package:trait_lens/features/ai_chat/data/models/gemini_response_model.dart';

import '../data_source/chat_data_source.dart';

@Singleton(as: ChatDataSource)
class ChatDataSourceImpl implements ChatDataSource {
  @override
  Future<Either<exceptions.ServerException, MessageModel>> getGeminiResponse({
    String? message,
  }) async {
    try {
      if (message == null || message.isEmpty) {
        return const Left(
            exceptions.ServerException('Message cannot be empty'));
      }

      final apiKey = dotenv.env['geminiApiKey'];

      if (apiKey == null || apiKey.isEmpty) {
        return const Left(exceptions.ServerException(
          'Gemini API Key not found in configuration',
        ));
      }

      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        systemInstruction: Content.system(
          'Your name is Lens Bot. You are a professional therapist specializing in mental health and personality analysis based on the Big Five model and MBTI. '
          'Respond to questions about mental health (e.g., stress, anxiety, depression, confidence), well-being, or personality analysis (e.g., describing traits or characteristics based on Big Five or MBTI). '
          'Support both English and Arabic questions. '
          'If the question is unrelated to mental health or personality analysis, reply with: "As Lens Bot, I cannot respond to your message \'$message\' because I am programmed to assist only with mental health and personality-related questions."',
        ),
      );

      final response = await model.generateContent([Content.text(message)]);
      log('Raw response from Gemini: ${response.text}');

      if (response.text == null || response.text!.isEmpty) {
        return const Left(exceptions.ServerException(
          'No response received from Gemini API',
        ));
      }

      return Right(MessageModel(
        text: response.text!,
        isUser: false,
      ));
    } on GenerativeAIException catch (e) {
      return Left(exceptions.ServerException('Gemini API error: ${e.message}'));
    } on Exception catch (error) {
      return Left(
        exceptions.ServerException('An unexpected error occurred: $error'),
      );
    }
  }
}
