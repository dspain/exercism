defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    cond do
      (code &&& 16) == 16 -> Enum.reverse(commands(code - 16))
      (code &&& 1) == 1 -> ["wink" | commands(code - 1)]
      (code &&& 2) == 2 -> ["double blink" | commands(code - 2)]
      (code &&& 4) == 4 -> ["close your eyes" | commands(code - 4)]
      (code &&& 8) == 8 -> ["jump" | commands(code - 8)]
      true -> []
    end
  end
end
