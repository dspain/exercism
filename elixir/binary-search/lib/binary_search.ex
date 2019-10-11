defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    do_search(numbers, key, 0)
  end

  defp do_search({}, _key, _index), do: :not_found

  defp do_search(numbers, key, index) do
    mid = div(tuple_size(numbers), 2)
    match = elem(numbers, mid)

    cond do
      key == match -> {:ok, index + mid}
      key > match -> do_search(higher(numbers, mid), key, index + mid + 1)
      key < match -> do_search(lower(numbers, mid), key, index)
    end
  end

  defp higher(numbers, index) do
    numbers
    |> Tuple.to_list()
    |> Enum.slice((index + 1)..-1)
    |> List.to_tuple()
  end

  defp lower(numbers, index) do
    numbers
    |> Tuple.to_list()
    |> Enum.slice(0..(index - 1))
    |> List.to_tuple()
  end
end
