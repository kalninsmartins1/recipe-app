require 'rails_helper'

RSpec.describe RecentlyUpdatedCommentsQuery do
  let(:chef) { Chef.create!(name: 'Jim', email: 'jim123@test.com', password: 'password') }
  let(:recipe) { chef.recipes.create!(name: 'Coconut', description: 'Break the shell !') }

  it 'comments are ordered in descending order' do
    comment_a = recipe.comments.create!(description: 'Yeah!', chef_id: chef.id)
    comment_b = recipe.comments.create!(description: 'Perfect !', chef_id: chef.id)
    comments = RecentlyUpdatedCommentsQuery.comments

    expect(comments.first.id).to eq(comment_b.id)
    expect(comments.second.id).to eq(comment_a.id)
  end
end
