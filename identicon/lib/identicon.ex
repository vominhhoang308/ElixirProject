defmodule Identicon do
  @moduledoc """
  This module is for 
  """

  def main(input) do
    input
    |> hash_input
    |> pick_color
  def build_grid(%Identicon.Image{ hex: hex } = image) do 
    grid = 
      hex
        |> Enum.chunk(3)
        |> Enum.map(&mirror_rows/1)
        |> List.flatten
        |> Enum.with_index # return index : value for each grid and put that to a grid field in Image struct
    %Identicon.Image{image | grid: grid}
  end

  # one rows of grid will have 5 elements
  # input [a,b,c]
  # output [a,b,c,b,a]
  def mirror_rows(list) do 
    [first, second | _tail] = list

    list ++ [second, first]
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
