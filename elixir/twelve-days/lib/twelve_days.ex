defmodule TwelveDays do
  @days ~w(first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth)
  @gifts [
    "and a Partridge in a Pear Tree.",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the #{Enum.at(@days, number - 1)} day of Christmas my true love gave to me: #{
      join_days(number)
    }"
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    verses_list = for n <- starting_verse..ending_verse, do: verse(n)
    Enum.join(verses_list, "\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end

  defp join_days(1), do: "a Partridge in a Pear Tree."

  defp join_days(number) do
    @gifts
    |> Enum.slice(0..(number - 1))
    |> Enum.reverse()
    |> Enum.join(", ")
  end
end
