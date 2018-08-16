require 'features_helper'

describe 'Sign up' do
  let(:repository) { UserRepository.new }

  before do
    repository.clear
    visit '/registrations/new'
  end

  context 'invalid form' do
    let(:messages) do
      [
        "Email must be filled",
        "Password must be filled"
      ]
    end

    it 'displays list of errors' do
      within 'form' do
        click_button 'Sign up'
      end

      expect(current_path).to eq('/registrations')

      messages.each do |msg|
        expect(page.has_content?(msg)).to be true
      end
    end
  end

  context 'valid form' do
    let(:user_params) do
      {
        email: "some@email.com",
        password: "some_password"
      }
    end

    it 'redirects to the root page' do
      within 'form' do
        fill_in 'Email', with: user_params[:email]
        fill_in 'Password', with: user_params[:password]

        click_button 'Sign up'
      end

      expect(current_path).to eq('/')
    end
  end
end
