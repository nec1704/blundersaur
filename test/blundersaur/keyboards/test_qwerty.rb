require 'helper'

module Blundersaur
  module Keyboards
    class TestQwerty < Test::Unit::TestCase
      def test_keys_near
        expected = {
          "1" => ["2"],
          "2" => ["1", "3"],
          "3" => ["2", "4"],
          "4" => ["3", "5"],
          "5" => ["4", "6"],
          "6" => ["5", "7"],
          "7" => ["6", "8"],
          "8" => ["7", "9"],
          "9" => ["8", "0"],
          "0" => ["9"],
          "q" => ["w"],
          "w" => ["q", "e"],
          "e" => ["w", "r"],
          "r" => ["e", "t"],
          "t" => ["r", "y"],
          "y" => ["t", "u"],
          "u" => ["y", "i"],
          "i" => ["u", "o"],
          "o" => ["i", "p"],
          "p" => ["o"],
          "a" => ["s"],
          "s" => ["a", "d"],
          "d" => ["s", "f"],
          "f" => ["d", "g"],
          "g" => ["f", "h"],
          "h" => ["g", "j"],
          "j" => ["h", "k"],
          "k" => ["j", "l"],
          "l" => ["k"],
          "z" => ["x"],
          "x" => ["z", "c"],
          "c" => ["x", "v"],
          "v" => ["c", "b"],
          "b" => ["v", "n"],
          "n" => ["b", "m"],
          "m" => ["n"]
        }
        expected.each_pair do |char, set|
          assert_equal set, Qwerty.keys_near(char)
          assert_equal set.collect(&:upcase), Qwerty.keys_near(char.upcase)
        end
      end
    end
  end
end
