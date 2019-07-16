# Decorator for Chef model, ensuring a valid object is always returned.
class ValidChefDecorator
  def self.find(id)
    Chef.find(id)
  rescue ActiveRecord::RecordNotFound
    NullChefRecord.new
  end

  def self.find_by(hash)
    Chef.find_by(hash) || NullChefRecord.new
  end
end
