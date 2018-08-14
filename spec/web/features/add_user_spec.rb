require 'features_helper'

describe 'Add a user' do
  let(:email) { 'test@email.com' }
  let(:password) { 'some_password' }
  let(:role) { 'admin' }

  before { visit '/users/new' }
  after { UserRepository.new.clear }

  context 'valid form' do
    it 'can create a new user' do
      within 'form#user-form' do
        fill_in 'Email', with: email
        fill_in 'Password', with: password
        choose "#{role}-role"

        click_button 'Create'
      end

      expect(current_path).to eq('/users')
      expect(page.has_content?('New User')).to be true
    end
  end

  context 'invalid form' do
    let(:messages) do
      [
        "There was a problem with your submission",
        "Email must be filled",
        "Password must be filled",
        "Role is missing"
      ]
    end

    it 'displays list of errors' do
      within 'form#user-form' do
        click_button 'Create'
      end

      expect(current_path).to eq('/users')

      messages.each do |msg|
        expect(page.has_content?(msg)).to be true
      end
    end
  end
end
