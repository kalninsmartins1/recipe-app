# Null object pattern for Chef record.
# Placeholder for when there is no chef record.
class NullChefRecord
  def authenticate(_password)
    false
  end

  def update(_params)
    false
  end

  def destroy
    false
  end

  def id
    -1
  end

  def admin?
    false
  end
end
