require 'features_helper'

describe 'Edit the user' do
  let(:repository) { UserRepository.new }
  let(:user_params) do
    {
      email: "some@email.com",
      password: "some_password",
      role: "admin"
    }
  end
  let!(:user) { repository.create(user_params) }

  before { visit "/users/#{user.id}/edit" }
  after { repository.clear }

  context 'valid form' do
    let(:new_email) { "another@email.com" }

    it 'can update a new user' do
      within 'form#user-form' do
        fill_in 'Email', with: new_email
        fill_in 'Password', with: user.password
        choose "#{user.role}-role"

        click_button 'Update'
      end

      expect(current_path).to eq('/users')
      expect(page.has_content?(new_email)).to be true
    end
  end

  context 'invalid form' do
    let(:messages) do
      [
        "There was a problem with your submission",
        "Password must be filled"
      ]
    end

    it 'displays list of errors' do
      within 'form#user-form' do
        click_button 'Update'
      end

      expect(current_path).to eq("/users/#{user.id}")

      messages.each do |msg|
        expect(page.has_content?(msg)).to be true
      end
    end
  end
end
