require 'rails_helper'

RSpec.describe RecentlyUpdatedCommentsQuery do
  let(:chef) { create(:chef) }
  let(:recipe) { chef.recipes.create!(attributes_for(:recipe)) }

  it 'comments are ordered in descending order' do
    comment_a = create(:comment, recipe_id: recipe.id, chef_id: chef.id, created_at: 2.days.ago, updated_at: 2.days.ago)
    comment_b = create(:comment, recipe_id: recipe.id, chef_id: chef.id, created_at: 1.day.ago, updated_at: 2.hours.ago)
    comments = RecentlyUpdatedCommentsQuery.comments

    expect(comments.first.id).to eq(comment_b.id)
    expect(comments.second.id).to eq(comment_a.id)
  end
end
