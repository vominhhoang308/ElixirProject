defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "the truth" do
    assert 1 + 1 == 2
  end

  ## Elixir is gonna automatically test our documentation, it will runs throught every single examples we have, and check if the last line is equal to what we already typed in the docs.

  test "create_test makes 20 cards" do
          deck_length = length(Cards.create_deck)
          assert deck_length == 20
 end

 test "shuffling a deck randomizedly" do
          deck = Cards.create_deck
          refute deck == Cards.shuffle(deck)
 end
end
