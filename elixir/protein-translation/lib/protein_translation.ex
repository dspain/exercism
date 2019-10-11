defmodule ProteinTranslation do
  @codon_map %{
    "UGU" => {:ok, "Cysteine"},
    "UGC" => {:ok, "Cysteine"},
    "UUA" => {:ok, "Leucine"},
    "UUG" => {:ok, "Leucine"},
    "AUG" => {:ok, "Methionine"},
    "UUU" => {:ok, "Phenylalanine"},
    "UUC" => {:ok, "Phenylalanine"},
    "UCU" => {:ok, "Serine"},
    "UCC" => {:ok, "Serine"},
    "UCA" => {:ok, "Serine"},
    "UCG" => {:ok, "Serine"},
    "UGG" => {:ok, "Tryptophan"},
    "UAU" => {:ok, "Tyrosine"},
    "UAC" => {:ok, "Tyrosine"},
    "UAA" => {:ok, "STOP"},
    "UAG" => {:ok, "STOP"},
    "UGA" => {:ok, "STOP"}
  }
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    list = rna_list(rna)

    if List.last(list) == {:error, "invalid RNA"} do
      {:error, "invalid RNA"}
    else
      {:ok, list}
    end
  end

  defp rna_list(rna) do
    {first, rest} = String.split_at(rna, 3)

    cond do
      first == "" -> []
      of_codon(first) == {:error, "invalid codon"} -> [{:error, "invalid RNA"}]
      of_codon(first) == {:ok, "STOP"} -> []
      true -> [elem(of_codon(first), 1) | rna_list(rest)]
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    Map.get(@codon_map, codon, {:error, "invalid codon"})
  end
end
