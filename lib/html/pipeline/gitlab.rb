require 'html/pipeline'
require 'html/pipeline/gitlab/version'

module HTML
  class Pipeline
    class GitLab
      # GitLab related filters for html-pipeline. Implements new filters used
      # by GitLab.

      # Custom filter implementations
      autoload :GitLabEmojiFilter, 'html/pipeline/gitlab/gitlab_emoji_filter'

      # Most used markdown pipeline in GitLab. Performs emoji replacement.
      MarkdownPipeline = HTML::Pipeline.new [
        SanitizationFilter,
        GitLabEmojiFilter
      ]
    end
  end
end
