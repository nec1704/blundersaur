require 'helper'

module Blundersaur
  module Extensions
    class TestString < Test::Unit::TestCase
      def test_included
        assert ::String.included_modules.include?(Extensions::String)
      end

      def test_fat_finger
        result = "hello".fat_finger
        assert_not_equal result, "hello"
        assert_match /^[gj]?h[gj]?[wr]?e[wr]?k?lk?k?lk?[ip]?o[ip]?$/, result
      end

      def test_fat_finger_skips_spaces
        str = " hey "
        50.times do
          assert_not_equal str, str.fat_finger
        end
      end

      def test_stutter
        result = "hello".stutter
        assert_not_equal result, "hello"
        assert_match /^h{1,2}e{1,2}l{1,2}l{1,2}o{1,2}$/, result
      end

      def test_mistype
        result = "hello".mistype
        assert_not_equal result, "hello"
        assert_match /^[gjh][wre][kl][kl][ipo]$/, result
      end

      def test_mistype_skips_spaces
        str = " hey "
        50.times do
          assert_not_equal str, str.mistype
        end
      end

      def test_random_mistake
        str = "hey there mister"
        50.times do
          assert_not_equal str, str.random_mistake
        end
      end

      def test_phonetic_swap_your_youre
        assert ["you're pants are burning; you're a liar", "your pants are burning; your a liar"].include?("your pants are burning; you're a liar".phonetic_swap)
        assert_equal "your the man", "you're the man".phonetic_swap
      end

      def test_phonetic_swap_ph_f
        assert_equal "phunky town", "funky town".phonetic_swap
      end

      def test_phonetic_swap_there_their_theyre
        assert %w{there their}.include?("they're".phonetic_swap)
        assert %w{they're their}.include?("there".phonetic_swap)
        assert %w{there they're}.include?("their".phonetic_swap)
      end

      def test_phonetic_swap_nothing
        str = "nothing"
        assert_equal str, str.phonetic_swap
      end

      def test_phonetic_swap_multiple_passes
        assert_equal "your spilling dip on you're pants", "you're spilling dip on your pants".phonetic_swap(2)
        assert_equal "you're your you're your you're your you're your", "your you're your you're your you're your you're".phonetic_swap(8)
      end

      def test_phonetic_swap_uses_random_match
        counts = [0, 0, 0]
        str = "your you're your"
        50.times do |i|
          case str.phonetic_swap
          when "you're you're your" then counts[0] += 1
          when "your your your"     then counts[1] += 1
          when "your you're you're" then counts[2] += 1
          end
        end
        assert counts[0] > 0, %{"you're you're your" wasn't ever created}
        assert counts[1] > 0, %{"your your your" wasn't ever created}
        assert counts[2] > 0, %{"your you're you're" wasn't ever created}
      end

      def test_swap_characters
        str = "hey"
        results = %w{ehy hye}
        20.times do
          assert results.include?(str.swap_characters)
        end
        assert_equal "h", "h".swap_characters
        assert_equal "", "".swap_characters
      end
    end
  end
end
