RSpec.describe Web::Controllers::Users::Edit, type: :action do
  let(:action) { described_class.new }
  let(:repository) { UserRepository.new }

  before { repository.clear }

  context "with valid params" do
    let(:user) do
      repository.create(
        email: 'some@email.com',
        password: 'some_password',
        role: 'Admin'
      )
    end

    let(:params) { Hash[id: user.id.to_s] }

    it 'is successful' do
      response = action.call(params)
      expect(response[0]).to eq 200
    end
  end

  context "with invalid params" do
    let(:params) { Hash[] }

    it 'is successful' do
      response = action.call(params)
      expect(response[0]).to eq 302
      expect(response[1]['Location']).to eq '/users'
    end
  end
end
