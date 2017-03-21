defmodule Cards do
          ## writing module docs

          @moduledoc """
                    Provides methods for creating and handling a deck of cards
          """

          @doc """
                    return a list of strings representing a deck of cards
          """
          def create_deck do
                    values = ["Ace", "Two", "Three", "Four", "Five"]
                    suits = ["Spades", "Heart", "Club", "Diamond"]

                    for suit <- suits, value <- values do
                              "#{value} of #{suit}"
                    end
          end

          def shuffle(deck) do
                    Enum.shuffle(deck)
          end

          #######
          @doc ~S"""
                    Determines whether a deck contains a given card

          ## Examples

                              iex> deck = Cards.create_deck
                              iex> Cards.contains?(deck, "Ace of Spades")
                              true

          """
          def contains?(deck, hand) do
                    Enum.member?(deck, hand)
          end


          ## in writing examples in docs
          ## example must have ## before it, same tab with @doc thing
          ## we must have spacebar between ## and Examples
          ## after that it must be newline (break line)
          ## then the example code must have 3 tabs
          @doc """
                    Divides a deck into a hand and the remainder of the deck. The `hand_size` argument indicates how many cards should be in the hand.

          ## Examples

                              iex> deck = Cards.create_deck
                              iex> {hand, deck} = Cards.deal(deck, 1)
                              iex> hand
                              ["Ace of Spades"]

          """
          def deal(deck, hand_size) do
                    Enum.split(deck, hand_size)
          end

          #####
          def save(deck, fileName) do
                    binary = :erlang.term_to_binary(deck)
                    File.write(fileName, binary)
          end

          ####
          def load(fileName) do
                    case File.read(fileName) do
                              {:ok, binary} -> :erlang.binary_to_term(binary)
                              {:error, _reason} -> "file does not exist haha"
                    end
          end

          ####
          def create_hand(hand_size) do
                    ## the result of the first function will be automatcially passed into the FIRST arugment of the next function called
                    ## with the pipe operators
                    Cards.create_deck
                    |> Cards.shuffle
                    ## as we use the |> operator (pipe operators), so elixir automatically pass in the result of
                    ## Cards.shuffle to the FIRST argument we pass in the Cards.deal
                    ## so in the next fucntion call, we only have to specify the second argument of the Cards.deal
                    |> Cards.deal(hand_size)
          end
end
