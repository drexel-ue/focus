/// LLMs.
enum LLM {
  /// deepseek-r1-distill-qwen-1.5b.
  deekseekR1;

  /// Parses [value] into a [LLM]. Will return [LLM.deekseekR1] by default.
  static LLM fromJson(String value) {
    return LLM.values.firstWhere(
      (element) => element.name == value,
      orElse: () => LLM.deekseekR1,
    );
  }

  @override
  String toString() => name;
}
