# Class for fetching comments in decending order by :updated_at attribute
class RecentlyUpdatedCommentsQuery
  def self.comments
    Comment.all.order(updated_at: :desc)
  end
end
