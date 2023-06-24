import 'package:multi_quiz_s_t_tt9/modules/multipe_choice/questionMultiple.dart';

class QuizBrainMulti {
  int _questionNumber = 0;

  final List<QuestionMultiple> _questionBank = [
    QuestionMultiple('You can lead a cow down stairs but not up stairs.', 1,
        ['Always', 'Never', 'Sometimes']),
    QuestionMultiple(
      'Approximately one quarter of human bones are in the feet.',
      0,
      ['Agree', 'Disagree', 'Not sure'],
    ),
    QuestionMultiple('Which of these countries ISN’T landlocked?', 1,
        ['Nepal', 'Turkey', 'Armenia']),
    QuestionMultiple(
        'Which two countries in South America are the Iguazu Falls part of?',
        2, [
      'Ethiopia and Kenya',
      'Switzerland and Italy',
      'Brazil and Argentina',
    ]),
  ];

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  int getQuestiosNumber() {
    return _questionBank.length;
  }

  int getCurrentQNumber() {
    return _questionNumber + 1;
  }

  int getQuestionAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  List<String> getOptions() {
    return _questionBank[_questionNumber].options;
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
