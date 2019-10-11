defmodule Bob do
  def hey(input) do
    cond do
      saying_nothing?(input) -> "Fine. Be that way!"
      yelling_question?(input) -> "Calm down, I know what I'm doing!"
      yelling?(input) -> "Whoa, chill out!"
      asking_question?(input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp saying_nothing?(input) do
    String.trim(input) == ""
  end

  defp yelling?(input) do
    String.upcase(input) == input and String.downcase(input) != input
  end

  defp yelling_question?(input) do
    yelling?(input) and String.ends_with?(input, "?")
  end

  defp asking_question?(input) do
    String.ends_with?(input, "?")
  end
end
