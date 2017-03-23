defmodule Identicon do
  @moduledoc """
  This module is for 
  """

  ### NOTE TO ALL FUNCTION HERE
  ### THE REASON WHY WE USE PATTERN MATCHING IN ARGUMENT IN ANY FUNCTION BEWLOW (EXCEPT draw_image)
  ### IS that we need to take in use of the image structs
  ### if we dont need the whole image struct e.g. draw_image, we can only call a part of image struct in an argument eventhough 
  ### in a main function pipeline we passing a whole image struct to each function
  def main(input) do
    input
      |> hash_input
      |> pick_color
      |> build_grid
      |> filter_odd_squares
      |> build_pixel_map
      |> draw_image
      |> save_image(input)
  end

  def save_image(imageFile, imageString) do
    File.write("#{imageString}.png", imageFile)
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start , stop}) -> 
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do 
    pixel_map = Enum.map grid, fn({_value, index}) -> 
      horizontal = rem(index, 5)*50
      vertical = div(index, 5)*50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}      
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do 
    # grid
    #   |> Enum.filter(
    #     fn({key, _value} = singleSquare) -> 
    #       rem(key,2) == 0
    #     end
    #   )
    grid = Enum.filter grid, fn({key, _value} = singleSquare) -> rem(key, 2) == 0 end

    %Identicon.Image{image | grid: grid}
  end

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
