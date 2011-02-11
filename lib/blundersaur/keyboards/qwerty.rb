module Blundersaur
  module Keyboards
    module Qwerty
      ROWS = [
        nil, "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", nil,
        nil, "a", "s", "d", "f", "g", "h", "j", "k", "l", nil,
        nil, "z", "x", "c", "v", "b", "n", "m", nil
      ]
      def self.keys_near(char)
        upcased = char.ord < 97
        i = ROWS.index(char.downcase)
        keys = ROWS.values_at(i-1, i+1).compact
        keys.collect!(&:upcase) if upcased
        keys
      end
    end
  end
end
