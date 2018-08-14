RSpec.describe Web::Controllers::Users::Create, type: :action do
  let(:action) { described_class.new }
  let(:repository) { UserRepository.new }

  before { repository.clear }

  context 'with valid params' do
    let(:params) do
      Hash[
        user: {
          email: "some@email.com",
          password: "some_password",
          role: "admin"
        }
      ]
    end

    it 'creates a new user' do
      action.call(params)
      user = repository.last

      expect(user.id).to_not eq nil

      params.dig(:user).each do |field, data|
        expect(user.send(field)).to eq data
      end
    end

    it 'redirects the user to the users listing' do
      response = action.call(params)

      expect(response[0]).to eq 302
      expect(response[1]['Location']).to eq '/users'
    end
  end

  context 'with invalid params' do
    let(:params) { Hash[user: {}] }

    it 'returns error' do
      response = action.call(params)
      expect(response[0]).to eq 422
    end

    it 'returns errors in params' do
      action.call(params)
      errors = action.errors

      expect(errors.dig(:user, :email)).to eq ['is missing']
      expect(errors.dig(:user, :password)).to eq ['is missing']
      expect(errors.dig(:user, :role)).to eq ['is missing']
    end
  end
end
