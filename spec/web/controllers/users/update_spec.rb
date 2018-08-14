RSpec.describe Web::Controllers::Users::Update, type: :action do
  let(:action) { described_class.new }

  let(:user_params) do
    {
      email: "some@email.com",
      password: "some_password",
      role: "Admin"
    }
  end

  context "with nonexistent user" do
    context "with invalid params" do
      let(:params) { Hash[] }

      it 'redirects the user to the users listing' do
        response = action.call(params)

        expect(response[0]).to eq 302
        expect(response[1]['Location']).to eq '/users'
      end
    end

    context "with valid params" do
      let(:params) { Hash[id: "1", user: user_params] }

      it 'redirects the user to the users listing' do
        response = action.call(params)

        expect(response[0]).to eq 302
        expect(response[1]['Location']).to eq '/users'
      end
    end
  end

  context "with existent user" do
    let(:repository) { UserRepository.new }
    let!(:user) { repository.create(user_params) }

    after { repository.clear }

    context "with invalid params" do
      let(:params) { Hash[id: user.id.to_s] }

      it 'redirects the user to the users listing' do
        response = action.call(params)
        expect(response[0]).to eq 422
      end
    end

    context "with valid params" do
      let(:new_email) { "test@test.com" }
      let(:params) do
        Hash[
          id: user.id.to_s,
          user: user_params.merge(email: new_email)
        ]
      end

      it 'updates the user' do
        expect { action.call(params) }.to change { repository.last.email }.to(new_email)
      end

      it 'redirects the user to the users listing' do
        response = action.call(params)

        expect(response[0]).to eq 302
        expect(response[1]['Location']).to eq '/users'
      end
    end
  end
end
