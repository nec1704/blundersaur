require File.join(File.dirname(__FILE__), "..", "..", "helper")

module Blundersaur
  module Keyboards
    class TestQwerty < Test::Unit::TestCase
      def test_keys_near
        expected = {
          ?q => [?w],
          ?w => [?q, ?e],
          ?e => [?w, ?r],
          ?r => [?e, ?t],
          ?t => [?r, ?y],
          ?y => [?t, ?u],
          ?u => [?y, ?i],
          ?i => [?u, ?o],
          ?o => [?i, ?p],
          ?p => [?o],
          ?a => [?s],
          ?s => [?a, ?d],
          ?d => [?s, ?f],
          ?f => [?d, ?g],
          ?g => [?f, ?h],
          ?h => [?g, ?j],
          ?j => [?h, ?k],
          ?k => [?j, ?l],
          ?l => [?k],
          ?z => [?x],
          ?x => [?z, ?c],
          ?c => [?x, ?v],
          ?v => [?c, ?b],
          ?b => [?v, ?n],
          ?n => [?b, ?m],
          ?m => [?n]
        }
        expected.each_pair do |char, set|
          assert_equal set, Qwerty.keys_near(char)
        end
      end
    end
  end
end
