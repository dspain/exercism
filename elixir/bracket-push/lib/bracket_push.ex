defmodule BracketPush do
  @opening_braces "{[("
  @braces "{[()]}"
  @brace_map %{
    "{" => "}",
    "[" => "]",
    "(" => ")"
  }

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    do_check_brackets("", str)
  end

  defp do_check_brackets("", ""), do: true
  defp do_check_brackets(stack, ""), do: false

  defp do_check_brackets(stack, string) do
    string_head = String.first(string)
    string_tail = String.slice(string, 1..-1)

    cond do
      !String.contains?(@braces, string_head) ->
        do_check_brackets(stack, string_tail)

      @brace_map[String.last(stack)] == string_head ->
        do_check_brackets(String.slice(stack, 0..-2), string_tail)

      String.contains?(@opening_braces, string_head) ->
        do_check_brackets(stack <> string_head, string_tail)

      true ->
        false
    end
  end
end
