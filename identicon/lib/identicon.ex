defmodule Identicon do
  @moduledoc """
  This module is for 
  """

  def main(input) do
    input
    |> hash_input
    |> pick_color
  end

  ## we can do pattern matching inside argument list
  ## in this case, we take image as our argument, while we are taking image as our argument, we also do some
  ## pattern matching there
  def pick_color(%Identicon.Image{hex: [r,g,b | _tail]} = image) do     
    ## taking all of the image property their, PASS ON to the one after the PIPE, add color to it.
    %Identicon.Image{image | color: {r,g,b}}
  end

  def hash_input(input) do 
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list    

    %Identicon.Image{hex: hex}
  end

end
