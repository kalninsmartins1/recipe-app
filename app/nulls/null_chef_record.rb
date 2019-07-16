# Null object pattern for Chef record.
# Placeholder for when there is no chef record.
class NullChefRecord
  def authenticate(_password)
    false
  end

  def update(params); end

  def id
    -1
  end
end
