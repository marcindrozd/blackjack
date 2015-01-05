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

require 'pry'

SUITS = ["hearts", "spades", "diamonds", "clubs"]
VALUES = [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]

def build_deck(number_of_decks)
  deck = []
  number_of_decks.times do
    SUITS.each do |suit|
      VALUES.each do |value|
        deck << value.to_s + " of " + suit
      end
    end
  end
  deck.shuffle
end

def hit(who, deck)
  who << deck.pop
end

def count_total(array)
  total = 0
  array.each do |card|
  # if 2-10 = value is face value
    if card.to_i != 0
      total += card.to_i
  # if A value is 11 if total <= 10 and 1 if total > 10
    elsif card[0] == "A" && total <= 10
      total += 11
    elsif card[0] == "A" && total > 10
      total += 1
  # J - K value is 10
    else
      total += 10
    end
  end
  total
end

while true
  deck = build_deck(1)

  player_cards = []
  dealer_cards = []

  bust = false

  2.times { hit(player_cards, deck) }
  2.times { hit(dealer_cards, deck) }

  puts "Player has the following cards in hand: #{player_cards.join(", ")}."
  puts "The total is #{count_total(player_cards)}"
  puts "Dealer has the following cards in hand: #{dealer_cards.first} and one other card."
  puts

  while !bust
    if count_total(player_cards) == 21
      puts "Blackjack! Player wins!"
      break
    elsif count_total(player_cards) > 21
      puts "Player busts and loses!"
      bust = true
      break
    else
      puts "Would you like to hit or stay? (h/s)"
      answer = gets.chomp

      while answer.downcase != "h" && answer.downcase != "s"
        puts "Please select either 'h' for hit of 's' for stay."
        answer = gets.chomp
      end

      if answer == "h"
        hit(player_cards, deck)
        puts "Player has the following cards in hand: #{player_cards.join(", ")}."
        puts "The total is #{count_total(player_cards)}"
      else
        puts "You selected to stay."
        break
      end
    end
  end

  puts "Player has the following cards in hand: #{player_cards.join(", ")}."
      
  # dealer turn
  # hit until dealer has 17 or busts

  puts "Dealer has the following cards in hand: #{dealer_cards.join(", ")}"

  # Add check if player busts
  if !bust
    while count_total(dealer_cards) < 17
      hit(dealer_cards, deck)
      if count_total(dealer_cards) == 21
        puts "Blackjack! Dealer wins!"
        break
      elsif count_total(dealer_cards) > 21
        puts "Dealer busts and loses!"
        bust = true
        break
      end
    end
  end

  if !bust
      if count_total(player_cards) > count_total(dealer_cards)
      puts "Player wins!"
    else
      puts "Dealer wins!"
    end
  end

  puts "Would you like to play again? (y/n)"
  answer = gets.chomp
  break if answer.downcase != "y"
end