RSpec.describe Web::Controllers::Users::Destroy, type: :action do
  let(:action) { described_class.new }

  context "with valid params" do
    let(:repository) { UserRepository.new }
    let(:user_params) do
      {
        email: "some@email.com",
        password: "some_password",
        role: "Admin"
      }
    end
    let!(:user) { repository.create(user_params) }
    let(:params) { Hash[id: user.id.to_s] }

    after { repository.clear }

    it 'deletes the user' do
      expect { action.call(params) }.to change {
        repository.all.count
      }.from(1).to(0)
    end

    it 'redirects the user to the users listing' do
      response = action.call(params)

      expect(response[0]).to eq 302
      expect(response[1]['Location']).to eq '/users'
    end
  end

  context "with invalid params" do
    let(:params) { Hash[] }

    it 'redirects the user to the users listing' do
      response = action.call(params)

      expect(response[0]).to eq 302
      expect(response[1]['Location']).to eq '/users'
    end
  end
end
