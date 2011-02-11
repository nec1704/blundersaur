module Blundersaur
  module Extensions
    module String
      MISTAKE_METHODS = [:fat_finger!, :stutter!, :mistype!, :phonetic_swap!, :swap_characters!]
      PHONETIC_GROUPS = [
        # whole words
        ["your", "you're"],
        ["there", "their", "they're"],
        nil,

        # syllables
        ["ph", "f"]
      ]

      def index_of_random_letter
        indices = (0...length).sort { |a, b| rand(3) - 1 }
        index = indices.shift
        while index && self[index..index] =~ /\W/
          index = indices.shift
        end
        index
      end

      def fat_finger!
        index = index_of_random_letter
        if index
          chars = Keyboards::Qwerty.keys_near(self[index..index])
          char = chars[rand(chars.length)]
          self[index..index] = rand(2) == 1 ? self[index..index] + char : char + self[index..index]
        end
        self
      end

      def fat_finger
        dup.fat_finger!
      end

      def stutter!
        i = rand(length)
        self[i..i] = self[i..i] * 2
        self
      end

      def stutter
        dup.stutter!
      end

      def mistype!
        index = index_of_random_letter
        if index
          chars = Keyboards::Qwerty.keys_near(self[index..index])
          char = chars[rand(chars.length)]
          self[index..index] = char
        end
        self
      end

      def mistype
        dup.mistype!
      end

      def random_mistake!
        send(MISTAKE_METHODS[rand(MISTAKE_METHODS.length)])
      end

      def random_mistake
        dup.random_mistake!
      end

      # This method is kind of expensive :(
      def phonetic_swap!(passes = 1)
        # Find all of the matches in the string
        # NOTE: if passes == 1, it would probably be better to sort the groups
        #       randomly and stop at the first one we find that has a match
        matches = {}
        whole_words = true
        PHONETIC_GROUPS.each_with_index do |group, index|
          if group.nil?
            whole_words = false
            next
          end
          re_str = "(?:#{group.join('|')})"
          re = Regexp.new(whole_words ? '\b'+re_str+'\b' : re_str)

          matches[index] = []
          scan(re) do |str|
            matches[index] << [$~.begin(0), str]
          end
          matches.delete(index) if matches[index].empty?
        end

        if !matches.empty?
          adjustments = []
          passes.times do |i|
            # Pick a random group's matches
            group_index = matches.keys[rand(matches.keys.length)]
            group_matches = matches[group_index]
            group = PHONETIC_GROUPS[group_index]

            # Pick a random match to replace
            offset, string = group_matches.delete_at(rand(group_matches.length))
            taken_index = group.index(string)
            matches.delete(group_index) if group_matches.empty?

            # Adjust offset if necessary
            new_offset = adjustments.inject(offset) do |n, (a_offset, a_diff)|
              offset > a_offset ? n + a_diff : n
            end
            offset = new_offset

            # Pick a random string from the group to replace it with
            elt_indices = (0...group.length).sort { |a, b| rand(3) - 1 }
            elt_index = elt_indices.shift
            elt_index = elt_indices.shift if elt_index == taken_index
            replacement = group[elt_index]

            # Booyah!
            diff = replacement.length - string.length
            if diff != 0
              adjustments << [offset, diff]
            end
            self[offset, string.length] = replacement

            break if matches.empty?
          end
        end
        self
      end

      def phonetic_swap(passes = 1)
        dup.phonetic_swap!(passes)
      end

      def swap_characters!
        if length > 1
          i = rand(length-1)
          r = i..(i+1)
          self[r] = self[r].reverse
        end
        self
      end

      def swap_characters
        dup.swap_characters!
      end
    end
  end
end

String.class_eval do
  include Blundersaur::Extensions::String
end
