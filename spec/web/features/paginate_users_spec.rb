require 'features_helper'

describe 'Paginate users' do
  let(:repository) { UserRepository.new }

  context "as guest" do
    it 'redirects to the sign in page' do
      visit '/users'
      expect(current_path).to eq('/sessions/new')
    end
  end

  context "signed in" do
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

      before do
        users_count.times do
          params = {
            email: SecureRandom.hex,
            password: SecureRandom.hex,
            role: "admin"
          }
          repository.create(params)
        end
      end

      context "without pagination" do
        let(:users_count) { 2 }

        it 'displyas each user on the page' do
          visit '/users'

          within '.users' do
            expect(page).to have_selector('.user', count: users_count + 1)
          end
        end

        it 'does not display the pagination' do
          visit '/users'
          expect(page).to_not have_selector('.paginator')
        end
      end

      context "with pagination" do
        let(:users_count) { 20 }
        let(:users_per_page) { 10 }

        it 'displyas each user on the page' do
          visit '/users'

          within '.users' do
            expect(page).to have_selector('.user', count: users_per_page)
          end
        end

        it 'displays the pagination' do
          visit '/users'
          expect(page).to have_selector('.paginator')
        end

        it 'displays the pagination links' do
          visit '/users'

          count_pages = ((users_count + 1) / users_per_page.to_f).ceil

          within '.paginator' do
            expect(page).to have_selector('a', count: count_pages)
          end
        end
      end
    end
  end
end
