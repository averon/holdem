shared_context 'Example Hands' do
  EXAMPLE_HANDS = {
    royal_flush: [
      [:ace,   :spades],
      [:king,  :spades],
      [:queen, :spades],
      [:jack,  :spades],
      [:ten,   :spades]
    ],
    straight_flush: [
      [:king,  :spades],
      [:queen, :spades],
      [:jack,  :spades],
      [:ten,   :spades],
      [:nine,  :spades]
    ],
    four_of_a_kind: [
      [:ace,  :spades],
      [:ace,  :clubs],
      [:ace,  :hearts],
      [:ace,  :diamonds],
      [:king, :spades]
    ],
    full_house: [
      [:ace,  :spades],
      [:ace,  :hearts],
      [:ace,  :clubs],
      [:king, :spades],
      [:king, :hearts]
    ],
    flush: [
      [:ace,   :spades],
      [:queen, :spades],
      [:ten,   :spades],
      [:eight, :spades],
      [:six,   :spades],
    ],
    straight: [
      [:ace,   :spades],
      [:king,  :clubs],
      [:queen, :hearts],
      [:jack,  :diamonds],
      [:ten,   :spades]
    ],
    three_of_a_kind: [
      [:ace,   :spades],
      [:ace,   :hearts],
      [:ace,   :clubs],
      [:king,  :spades],
      [:queen, :hearts]
    ],
    two_pair: [
      [:ace,   :spades],
      [:ace,   :hearts],
      [:king,  :clubs],
      [:king,  :spades],
      [:queen, :hearts]
    ],
    one_pair: [
      [:ace,   :spades],
      [:ace,   :hearts],
      [:king,  :clubs],
      [:queen, :spades],
      [:jack,  :hearts]
    ]
  }
end
