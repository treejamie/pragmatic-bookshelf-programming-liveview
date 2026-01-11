defmodule Pento.QuestionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.Questions` context.
  """

  @doc """
  Generate a question.
  """
  def question_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        answer: "some answer",
        question: "some question"
      })

    {:ok, question} = Pento.Questions.create_question(scope, attrs)
    question
  end
end
