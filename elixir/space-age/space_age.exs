defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(:earth, seconds), do: seconds / 31_557_068.55
  def age_on(:mercury, seconds), do: seconds / 7_600_525.8
  def age_on(:venus, seconds), do: seconds / 19_411_026.1
  def age_on(:mars, seconds), do: seconds / 59_359_776.7
  def age_on(:jupiter, seconds), do: seconds / 374_222_565.1
  def age_on(:saturn, seconds), do: seconds / 928_792_569.659
  def age_on(:uranus, seconds), do: seconds / 2_652_994_591.735
  def age_on(:neptune, seconds), do: seconds / 5_196_280_668.354
end
