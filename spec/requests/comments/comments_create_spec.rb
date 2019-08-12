require 'rails_helper'
require 'support/login_helper'

RSpec.describe 'CommentsControllerCreate', type: :request do
  before(:each) do
    @chef = Chef.create(name: 'Peter', email: 'peter12@test.com', password: 'password')
    @recipe = Recipe.create(name: 'Coconut', description: 'Use hammer to open.', chef_id: @chef.id)
  end

  def post_comment(description)
    post recipe_comments_path(@recipe), params: {comment: {description: description}}
  end

  context 'without login' do
    it 'creating comment requires login' do
      expect { post_comment('Hello World !') }.to change { Comment.count }.by(0)
    end
  end

  context 'with login' do
    before(:each) do
      login(@chef.email, @chef.password)
    end

    it 'cant create empty comment' do
      expect { post_comment('') }.to change { Comment.count }.by(0)
    end

    it 'valid comment is accepted' do
      comment = 'Hello World !'
      expect { post_comment(comment) }.to change { Comment.count }.by(1)
      follow_redirect!
      expect(response.body).to match(comment)
    end
  end
end
