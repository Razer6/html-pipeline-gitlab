require 'html/pipeline'
require 'html/pipeline/gitlab/version'
require 'html/pipeline/gitlab/gitlab_emoji_filter'

module HTML
  class Pipeline
    class Gitlab
      # GitLab related filters for html-pipeline. Implements new filters used
      # by GitLab.

      # Most used markdown pipeline in GitLab. Performs emoji replace,,ent
      MarkdownPipeline = HTML::Pipeline.new [
        HTML::Pipeline::GitLab::GitLabEmojiFilter
      ]
    end
  end
end
