defmodule ScaleGenerator do
  @doc """
  Find the note for a given interval (`step`) in a `scale` after the `tonic`.

  "m": one semitone
  "M": two semitones (full tone)
  "A": augmented second (three semitones)

  Given the `tonic` "D" in the `scale` (C C# D D# E F F# G G# A A# B C), you
  should return the following notes for the given `step`:

  "m": D#
  "M": E
  "A": F
  """
  @spec step(scale :: list(String.t()), tonic :: String.t(), step :: String.t()) ::
          list(String.t())
  def step([], _, _), do: :error

  def step([tonic | rst], tonic, step) do
    case step do
      "m" -> Enum.at(rst, 0)
      "M" -> Enum.at(rst, 1)
      "A" -> Enum.at(rst, 2)
    end
  end

  def step([_ | rst], tonic, step) do
    step(rst, tonic, step)
  end

  @doc """
  The chromatic scale is a musical scale with thirteen pitches, each a semitone
  (half-tone) above or below another.

  Notes with a sharp (#) are a semitone higher than the note below them, where
  the next letter note is a full tone except in the case of B and E, which have
  no sharps.

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C C# D D# E F F# G G# A A# B C)
  """
  @spec chromatic_scale(tonic :: String.t()) :: list(String.t())
  def chromatic_scale(tonic \\ "C") do
    ~w(C C# D D# E F F# G G# A A# B C C# D D# E F F# G G# A A# B C C#)
    |> Enum.drop_while(fn x -> x != String.upcase(tonic) end)
    |> Enum.take(13)
  end

  @doc """
  Sharp notes can also be considered the flat (b) note of the tone above them,
  so the notes can also be represented as:

  A Bb B C Db D Eb E F Gb G Ab

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C Db D Eb E F Gb G Ab A Bb B C)
  """
  @spec flat_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def flat_chromatic_scale(tonic \\ "C") do
    {h, t} = String.split_at(tonic, 1)
    t = String.upcase(h) <> t

    ~w(C Db D Eb E F Gb G Ab A Bb B C Db D Eb E F Gb G Ab A Bb B C)
    |> Enum.drop_while(fn x -> x != t end)
    |> Enum.take(13)
  end

  @doc """
  Certain scales will require the use of the flat version, depending on the
  `tonic` (key) that begins them, which is C in the above examples.

  For any of the following tonics, use the flat chromatic scale:

  F Bb Eb Ab Db Gb d g c f bb eb

  For all others, use the regular chromatic scale.
  """
  @spec find_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def find_chromatic_scale(tonic) do
    if tonic in ~w(F Bb Eb Ab Db Gb d g c f bb eb) do
      flat_chromatic_scale(tonic)
    else
      chromatic_scale(tonic)
    end
  end

  @doc """
  The `pattern` string will let you know how many steps to make for the next
  note in the scale.

  For example, a C Major scale will receive the pattern "MMmMMMm", which
  indicates you will start with C, make a full step over C# to D, another over
  D# to E, then a semitone, stepping from E to F (again, E has no sharp). You
  can follow the rest of the pattern to get:

  C D E F G A B C
  """
  @spec scale(tonic :: String.t(), pattern :: String.t()) :: list(String.t())
  def scale(tonic, pattern) do
    scale = find_chromatic_scale(tonic)

    should_take =
      pattern
      |> String.split("", trim: true)
      |> Enum.reverse()
      |> Enum.reduce([], fn x, acc ->
        case x do
          "m" ->
            [1 | acc]

          "M" ->
            [1 | [0 | acc]]

          "A" ->
            [1 | [0 | [0 | acc]]]
        end
      end)

    scale
    |> Enum.zip(should_take)
    |> Enum.filter(fn {s, t} -> t == 1 end)
    |> Enum.map(&elem(&1, 0))
    |> (&List.insert_at(&1, -1, List.first(&1))).()
  end
end
