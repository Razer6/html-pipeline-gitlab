require 'cgi'
require 'gitlab_emoji'
require 'html/pipeline/filter'


module HTML
  class Pipeline
    class GitLab
      # HTML filter that replaces :emoji: with images.
      #
      # Context:
      #   :asset_root (required) - base url to link to emoji sprite
      #   :asset_path (optional) - url path to link to emoji sprite.
      #      :file_name can be used as a placeholder for the sprite file name.
      #      If no asset_path is set "emoji/:file_name" is used.
      class GitLabEmojiFilter < Filter
        def call
          search_text_nodes(doc).each do |node|
            content = node.to_html
            next if !content.include?(':')
            next if has_ancestor?(node, %w(pre code))
            html = emoji_image_filter(content)
            next if html == content
            node.replace(html)
          end
          doc
        end

        # Implementation of validate hook.
        # Errors should raise exceptions or use an existing validator.
        def validate
          needs :asset_root
        end

        # Replace :emoji: with corresponding images.
        #
        # text - String text to replace :emoji: in.
        #
        # Returns a String with :emoji: replaced with images.
        def emoji_image_filter(text)
          return text unless text.include?(':')

          text.gsub(emoji_pattern) do |match|
            name = $1
            "<img class='emoji' title=':#{name}:' alt=':#{name}:' src='#{emoji_url(name)}' height='20' width='20' align='absmiddle' />"
          end
        end

        # The base url to link emoji sprites
        #
        # Raises ArgumentError if context option has not been provided.
        # Returns the context's asset_root.
        def asset_root
          context[:asset_root]
        end

        private

        def emoji_url(name)
          File.join(asset_root, 'emoji', emoji_filename(name))
        end

        # Build a regexp that matches all valid :emoji: names.
        def self.emoji_pattern
          @emoji_pattern ||= /:(#{emoji_names.map { |name| Regexp.escape(name) }.join('|')}):/
        end

        def emoji_pattern
          self.class.emoji_pattern
        end

        def self.emoji_names
          Emoji.names
        end

        def emoji_filename(name)
          "#{::CGI.escape(name)}.png"
        end
      end
    end
  end
end
