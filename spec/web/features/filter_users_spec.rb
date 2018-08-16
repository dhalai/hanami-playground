require 'features_helper'

describe 'Filter users' do
  let(:repository) { UserRepository.new }

  context "as guest" do
    it 'redirects to the sign in page' do
      visit '/users'
      expect(current_path).to eq('/sessions/new')
    end
  end

  context "signed in" do
    let(:user_1_email) { "user_1@email.com" }
    let(:user_1_role) { "user" }
    let!(:user_1) do
      repository.create(
        email: user_1_email,
        password: SecureRandom.hex,
        role: user_1_role
      )
    end

    let(:user_2_email) { "user_2@email.com" }
    let(:user_2_role) { "admin" }
    let!(:user_2) do
      repository.create(
        email: user_2_email,
        password: SecureRandom.hex,
        role: user_2_role
      )
    end

    before do
      sign_in_as role
      visit "/users/"
    end

    after { repository.clear }

    context 'as user' do
      let(:role) { "user" }
      it_behaves_like "protected page"
    end

    context 'as admin' do
      let(:role) { "admin" }

      it 'displays filters' do
        expect(page).to have_selector('.filters')
      end

      context "without filters" do
        it 'displays all users on the page' do
          within '.users' do
            expect(page).to have_selector('.user', count: 3)
          end
        end
      end

      context "with the email filter" do
        it 'filters users' do
          within '.filters' do
            fill_in 'Email', with: "user_1"
            click_button 'Filter'
          end

          expect(page).to have_selector('.user', count: 1)
          expect(page.has_content?(user_1_email)).to be true
        end
      end

      context "with the role filter" do
        it 'filters users' do
          within '.filters' do
            check "filters-role-#{user_2_role}"
            click_button 'Filter'
          end

          expect(page).to have_selector('.user', count: 2)
          expect(page.has_content?(user_2_email)).to be true
        end
      end

      context "with both filters" do
        it 'shows nothing' do
          within '.filters' do
            fill_in 'Email', with: "some_email"
            check "filters-role-#{user_2_role}"
            click_button 'Filter'
          end

          expect(page).to_not have_selector('.user')
        end

        it 'shows the user' do
          within '.filters' do
            fill_in 'Email', with: user_2_email
            check "filters-role-#{user_2_role}"
            click_button 'Filter'
          end

          expect(page).to have_selector('.user', count: 1)
          expect(page.has_content?(user_2_email)).to be true
        end
      end
    end
  end
end
