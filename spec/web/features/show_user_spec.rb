require 'features_helper'

describe 'Show the user' do
  let(:repository) { UserRepository.new }

  context "as guest" do
    it 'redirects to the sign in page' do
      visit "/users/1"
      expect(current_path).to eq('/sessions/new')
    end
  end

  context "signed in" do
    before do
      sign_in_as role
      visit "/users/#{user_id}"
    end

    after { repository.clear }

    context 'as user' do
      let(:user_id) { 123 }
      let(:role) { "user" }
      it_behaves_like "protected page"
    end

    context 'as admin' do
      let(:role) { "admin" }

      context "nonexistent user" do
        let(:user_id) { 123 }

        it 'redirects to the users page' do
          expect(current_path).to eq('/users')
        end
      end

      context "existent user" do
        let(:user_params) do
          {
            email: "some@email.com",
            password: "some_password",
            role: "admin"
          }
        end
        let(:user) { repository.create(user_params) }
        let(:user_id) { user.id }

        it 'shows the user' do
          user.to_h.each do |column, value|
            expect(page.has_content?(column.capitalize)).to be true
            expect(page.has_content?(value)).to be true
          end
        end
      end
    end
  end
end
