defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    {MapSet.member?(collection, card), MapSet.union(collection, new_collection(card))}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    cond do
      # You don't have your_card to trade -> just add their_card
      not MapSet.member?(collection, your_card) ->
        {false, MapSet.put(collection, their_card)}

      # You have your_card, but already have their_card -> remove yours, keep theirs
      MapSet.member?(collection, their_card) ->
        {false, MapSet.delete(collection, your_card)}

      # You have your_card, don't have their_card -> successful trade!
      true ->
        collection
        |> MapSet.delete(your_card)
        |> MapSet.put(their_card)
        |> then(&{true, &1})
    end
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    MapSet.new(cards)
    |> MapSet.to_list()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    MapSet.difference(your_collection, their_collection)
    |> MapSet.size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []

  def boring_cards(collections) do
    collections
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.to_list()
    |> Enum.sort()
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards(collections) do
    collections
    |> Enum.reduce(MapSet.new(), &MapSet.union/2)
    |> MapSet.size()
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    collection
    |> Enum.split_with(&String.starts_with?(&1, "Shiny"))
  end
end
