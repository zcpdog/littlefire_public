module PaperTrailConfig
  extend ActiveSupport::Concern
  included do
    has_paper_trail :ignore => [:comments_count, :favorites_count, :agree_count, :disagree_count]
  end
end