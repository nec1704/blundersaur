module Blundersaur
  module Keyboards
    module Qwerty
      ROWS = [
        nil, ?q, ?w, ?e, ?r, ?t, ?y, ?u, ?i, ?o, ?p, nil,
        nil, ?a, ?s, ?d, ?f, ?g, ?h, ?j, ?k, ?l, nil,
        nil, ?z, ?x, ?c, ?v, ?b, ?n, ?m, nil
      ]
      def self.keys_near(char)
        i = ROWS.index(char)
        ROWS.values_at(i-1, i+1).compact
      end
    end
  end
end
