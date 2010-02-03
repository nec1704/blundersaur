require File.join(File.dirname(__FILE__), "..", "..", "helper")

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
    end
  end
end
