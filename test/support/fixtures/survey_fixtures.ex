defmodule Pento.SurveyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.Survey` context.
  """

  @doc """
  Generate a demographic.
  """
  def demographic_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        gender: "some gender",
        year_of_birth: 42
      })

    {:ok, demographic} = Pento.Survey.create_demographic(scope, attrs)
    demographic
  end

  @doc """
  Generate a rating.
  """
  def rating_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        stars: 42
      })

    {:ok, rating} = Pento.Survey.create_rating(scope, attrs)
    rating
  end
end
