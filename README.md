# HamStudy

This will eventually be an app that gives easy access to the US ham radio
exam tests. The intent is to tie it into a slack/irc/whatever bot using
something like [Hedwig](https://github.com/hedwig-im).

Right now it just parses the extra exam questions into a struct. There's a couple of helper methods right now but not much else yet.

## List questions

```elixir

iex> HamStudy.questions()
[
  %ExamQuestion{
    answer_a: "A. The exact upper band edge",
    answer_b: "B. 300 Hz below the upper band edge",
    answer_c: "C. 1 kHz below the upper band edge",
    answer_d: "D. 3 kHz below the upper band edge",
    correct_answer: :answer_d,
    group: "A",
    number: "01",
    other: "[97.301, 97.305]",
    question_number: "E1A01",
    subelement: "E1",
    text: "When using a transceiver that displays the carrier frequency of phone signals, which of the following displayed frequencies represents the highest frequency at which a properly adjusted USB emission will be totally within the band?"
  },
  ...]
 ```

## Random question

```elixir

iex> HamStudy.random_question()
%ExamQuestion{
  answer_a: "A. Differential-mode current",
  answer_b: "B. Common-mode current",
  answer_c: "C. Reactive current only",
  answer_d: "D. Return current",
  correct_answer: :answer_b,
  group: "E",
  number: "16",
  other: "",
  question_number: "E4E16",
  subelement: "E4",
  text: "What current flows equally on all conductors of an unshielded multi-conductor cable?"
}
```