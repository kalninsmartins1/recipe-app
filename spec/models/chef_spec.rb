require 'rails_helper'

RSpec.describe Chef, type: :model do
  before(:each) do
    @chef = Chef.create(name: 'Peter', email: 'peter12@awesome.com', password: 'parole', password_confirmation: 'parole')
  end

  context 'validation tests' do
    context 'name' do
      it 'should be present' do
        @chef.name = ' '
        expect(@chef.valid?).to eq(false)
      end

      it 'should not be shorter than 3 characters' do
        @chef.name = 'aa'
        expect(@chef.valid?).to eq(false)
      end

      it 'should not be longer than 20 characters' do
        @chef.name = 'a' * 21
        expect(@chef.valid?).to eq(false)
      end
    end

    context 'email' do
      it 'should be present' do
        @chef.email = ' '
        expect(@chef.valid?).to eq(false)
      end

      it 'shoud not be shorter than 3 characters' do
        @chef.email = 'a'
        expect(@chef.valid?).to eq(false)
      end

      it 'should not be longer than 320 characters' do
        @chef.email = 'a' * 321
        expect(@chef.valid?).to eq(false)
      end

      it 'should have correct format' do
        @chef.email = 'aaaa'
        expect(@chef.valid?).to eq(false)
      end

      it 'should be unique' do
        chef_dupe = @chef.dup
        @chef.save
        expect(chef_dupe.valid?).to eq(false)
      end

      it 'should be case insensitive' do
        chef_dupe = @chef.dup
        chef_dupe.email = @chef.email.upcase
        @chef.save
        expect(chef_dupe.valid?).to eq(false)
      end

      it 'should be lower case before hitting the database' do
        mixed_case_email = 'PeterisTestetajs@peteris.co.uk'
        @chef.email = mixed_case_email
        @chef.save
        expect(@chef.reload.email).to eq(mixed_case_email.downcase)
      end
    end

    context 'password' do
      it 'should be present' do
        @chef.password = @chef.password_confirmation = ' '
        expect(@chef.valid?).to eq(false)
      end

      it 'should be atleast 5 characters' do
        @chef.password = @chef.password_confirmation = 'w' * 4
        expect(@chef.valid?).to eq(false)
      end
    end
  end

  context 'association tests' do
    it 'recipes are deleted when chef is deleted' do
      @chef.recipes.create(name: 'test', description: 'testing123')
      @chef.save!
      expect { @chef.destroy }.to change { Recipe.count }.by(-1)
    end

    it 'comments are deleted when chef is deleted' do
      recipe = @chef.recipes.create(name: 'test', description: 'testing123')
      @chef.comments.create(description: 'ulaa', recipe_id: recipe.id, chef_id: @chef.id)
      @chef.save!
      expect { @chef.destroy }.to change { Comment.count }.by(-1)
    end

    it 'messages are deleted when chef is deleted' do
      @chef.messages.create(content: 'This is a message')
      @chef.save!
      expect { @chef.destroy }.to change { Message.count }.by(-1)
    end

    it 'has many comments' do
      expect(@chef).to respond_to(:comments)
    end
  end
end
