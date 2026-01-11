defmodule Pento.Questions.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :question, :string
    field :answer, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(question, attrs, user_scope) do
    question
    |> cast(attrs, [:question, :answer])
    |> validate_required([:question, :answer])
    |> put_change(:user_id, user_scope.user.id)
  end
end
