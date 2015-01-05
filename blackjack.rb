# 1. take a deck of cards - shuffle
# 2. deal 2 cards to player and 2 cards to dealer (1 is hidden) / remove cards from the deck
# 3. each card is valued the face value, figures are 10 and ace is either 11 or 1
# 4. player decides whether to stay or hit
# 5. if hit, deal another card to the player
# 6. if player cards total value is above 21 it is bust
# 7. if player stays and is not bust, deal cards to the dealer
# 8. hit dealer until he has at least 17, then compare cards
# 9. if dealer busts or player cards are more the player wins
# 10. else dealer wins
# 11. ask to play again

SUITS = ["hearts", "spades", "diamonds", "clubs"]
VALUES = [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]

def build_deck(number_of_decks)
  deck = []
  number_of_decks.times do
    SUITS.each do |suit|
      VALUES.each do |value|
        deck << value.to_s + " " + suit
      end
    end
  end
  deck.shuffle
end

