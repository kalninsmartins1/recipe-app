require 'rails_helper'
require 'support/login_helper'

RSpec.describe 'CommentsControllerCreate', type: :request do
  let!(:chef) { create(:chef) }
  let!(:recipe) { chef.recipes.create!(attributes_for(:recipe)) }
  let(:new_comment) { build(:comment) }

  def post_comment(description)
    post recipe_comments_path(recipe), params: {comment: {description: description}}
  end

  context 'without login' do
    it 'creating comment requires login' do
      expect { post_comment(new_comment.description) }.to change { Comment.count }.by(0)
    end
  end

  context 'with login' do
    before(:each) do
      login(chef.email, chef.password)
    end

    it 'cant create empty comment' do
      expect { post_comment('') }.to change { Comment.count }.by(0)
    end

    it 'valid comment is accepted' do
      expect { post_comment(new_comment.description) }.to change { Comment.count }.by(1)
    end

    it 'should broadcast to comments channel' do
      expect { post_comment(new_comment.description).to have_broadcasted_to('comments').with(text: new_comment.description) }
    end
  end
end
