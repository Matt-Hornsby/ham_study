defmodule HamStudy do
  require Logger

  @moduledoc """
  Documentation for HamStudy.
  """

  @doc """
  List all questions

  ## Examples

      iex> HamStudy.all_questions()
  """
  def all_questions do
    extra_questions() ++ general_questions()
  end

  def extra_questions do
    "priv/extra_questions.txt" |> File.read!() |> parse_questions
  end

  def general_questions do
    "priv/general_questions.txt" |> File.read!() |> parse_questions
  end

  defp parse_questions(string) do
    parsed_questions =
      string
      |> String.split("\n")
      |> Stream.chunk(6)
      |> Enum.map(&parse_entry/1)

    parsed_questions
  end

  defp parse_entry(question_lines) do
    [question_details, question_text, a, b, c, d] = question_lines
    #Logger.debug(question_details)
    <<subelement::binary-size(2), group::binary-size(1), number::binary-size(2), 0x20, "(",
      correct_answer::binary-size(1), ")", other::binary>> = question_details

    exam_question = %ExamQuestion{}
    exam_question = %{exam_question | question_number: subelement <> group <> number}
    exam_question = %{exam_question | subelement: subelement}
    exam_question = %{exam_question | group: group}
    exam_question = %{exam_question | number: number}
    exam_question = %{exam_question | other: String.trim(other)}
    exam_question = %{exam_question | text: question_text |> String.trim("\r")}
    exam_question = %{exam_question | answer_a: a |> String.trim("\r")}
    exam_question = %{exam_question | answer_b: b |> String.trim("\r")}
    exam_question = %{exam_question | answer_c: c |> String.trim("\r")}
    exam_question = %{exam_question | answer_d: d |> String.trim("\r")}

    exam_question = %{
      exam_question
      | correct_answer: correct_answer |> convert_correct_answer_to_atom
    }

    exam_question
  end

  defp convert_correct_answer_to_atom("A"), do: :answer_a
  defp convert_correct_answer_to_atom("B"), do: :answer_b
  defp convert_correct_answer_to_atom("C"), do: :answer_c
  defp convert_correct_answer_to_atom("D"), do: :answer_d

  @doc """
  Get a random question

  ## Examples

      iex> HamStudy.random_question
  """
  def random_question() do
    all_questions() |> Enum.take_random(1) |> hd
  end

  @doc """
  Converts the question into a copy/paste-able question
  """
  def to_copy_pasta(%ExamQuestion{} = map) do
    IO.puts(
      "#{map.subelement <> map.group <> map.number}\n#{map.text}\n#{map.answer_a}\n#{map.answer_b}\n#{
        map.answer_c
      }\n#{map.answer_d}"
    )
  end
end
