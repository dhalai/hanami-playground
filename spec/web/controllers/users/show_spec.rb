describe Web::Controllers::Users::Show, type: :action do
  let(:action) { described_class.new }

  context "with nonexistent user" do
    let(:params) { Hash[] }

    it 'redirects the user to the users listing' do
      response = action.call(params)

      expect(response[0]).to eq 302
      expect(response[1]['Location']).to eq '/users'
    end
  end

  context "with existent user" do
    let(:repository) { UserRepository.new }
    let(:user_params) do
      {
        email: 'some@email.com',
        password: 'some_password',
        role: 'Admin'
      }
    end

    let!(:user) { repository.create(user_params) }
    let(:params) { Hash[id: user.id.to_s] }

    after { repository.clear }

    it 'is successfull' do
      response = action.call(params)
      expect(response[0]).to eq 200
    end

    it 'exposes the user' do
      action.call(params)
      expect(action.exposures[:user]).to eq user
    end
  end
end
