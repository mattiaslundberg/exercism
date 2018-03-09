defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &char_to_rna/1)
  end

  defp char_to_rna(c) do
    case c do
      67 -> 71
      71 -> 67
      84 -> 65
      65 -> 85
    end
  end
end
