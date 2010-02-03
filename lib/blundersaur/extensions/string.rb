module Blundersaur
  module Extensions
    module String
      def fat_finger!
        i = rand(self.length)
        chars = Keyboards::Qwerty.keys_near(self[i])
        char = chars[rand(chars.length)]
        self[i..i] = (rand(2) == 1 ? [self[i], char] : [char, self[i]]).pack("cc")
        self
      end

      def fat_finger
        self.dup.fat_finger!
      end

      def stutter!
        i = rand(self.length)
        self[i..i] = self[i..i] * 2
        self
      end

      def stutter
        self.dup.stutter!
      end

      def mistype!
        i = rand(self.length)
        chars = Keyboards::Qwerty.keys_near(self[i])
        char = chars[rand(chars.length)]
        self[i] = char
        self
      end

      def mistype
        self.dup.mistype!
      end
    end
  end
end

String.class_eval do
  include Blundersaur::Extensions::String
end
