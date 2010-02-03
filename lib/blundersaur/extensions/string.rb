module Blundersaur
  module Extensions
    module String
      def fat_finger
        i = rand(self.length)
        chars = Keyboards::Qwerty.keys_near(self[i])
        char = chars[rand(chars.length)]
        retval = self.dup
        retval[i..i] = (rand(2) == 1 ? [retval[i], char] : [char, retval[i]]).pack("cc")
        retval
      end
    end
  end
end

String.class_eval do
  include Blundersaur::Extensions::String
end
