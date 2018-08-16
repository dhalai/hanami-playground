require 'features_helper'

describe 'Visit home page' do
  let(:repository) { UserRepository.new }

  context "as guest" do
    it 'redirects to the sign in page' do
      visit '/'
      expect(current_path).to eq('/sessions/new')
    end
  end

  context "signed in" do
    before do
      sign_in_as role
      visit '/'
    end

    after { repository.clear }

    context 'as user' do
      let(:role) { "user" }

      it 'is successfull' do
        expect(page.body).to include('Hello world!')
      end
    end

    context 'as admin' do
      let(:role) { "admin" }

      it 'is successfull' do
        expect(page.body).to include('Hello world!')
      end
    end
  end
end
