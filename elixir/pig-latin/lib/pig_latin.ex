defmodule PigLatin do
  @vowels ~w(a e i o u)
  @tricky_consonants ~w(qu squ)
  @tricky_vowels ~w(x y)
  # @consonants ~w(ch qu squ th thr sch str)
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(""), do: ""

  def translate(phrase) do
    [first | rest] = String.split(phrase)

    cond do
      begins_with(first, @vowels) ->
        String.trim(vowel_split(first) <> translate(Enum.join(rest, " ")))

      begins_with(first, @tricky_vowels) ->
        String.trim(tricky_vowel_split(first) <> translate(Enum.join(rest, " ")))

      prefix = begins_with(first, @tricky_consonants) ->
        String.trim(tricky_consonant_split(first, prefix) <> translate(Enum.join(rest, " ")))

      true ->
        String.trim(consonant_split(first) <> translate(Enum.join(rest, " ")))
    end
  end

  defp begins_with(word, sounds) do
    Enum.find(sounds, false, &String.starts_with?(word, &1))
  end

  defp vowel_split(word) do
    word <> "ay "
  end

  defp tricky_vowel_split(word) do
    if String.at(word, 1) in @vowels do
      consonant_split(word)
    else
      vowel_split(word)
    end
  end

  defp consonant_split(word) do
    parts = String.split(word, ~r/[aeiou]/, parts: 2, include_captures: true)
    Enum.at(parts, 1) <> Enum.at(parts, 2) <> Enum.at(parts, 0) <> "ay "
  end

  defp tricky_consonant_split(word, prefix) do
    word
    |> String.replace_prefix(prefix, "")
    |> Kernel.<>(prefix <> "ay ")
  end
end
