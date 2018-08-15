describe Web::Controllers::Users::Create, type: :action do
  let(:interactor) { instance_double("Users::Creator", call: nil) }
  let(:action) { described_class.new(interactor: interactor) }
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

    it 'calls interactor' do
      expect(interactor).to receive(:call)
      action.call(params)
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

    it 'does not call interactor' do
      expect(interactor).to_not receive(:call)
      action.call(params)
    end

    it 'returns errors in params' do
      action.call(params)
      errors = action.errors

      expect(errors.dig(:user, :email)).to eq ['is missing']
      expect(errors.dig(:user, :password)).to eq ['is missing', 'size cannot be less than 8']
      expect(errors.dig(:user, :role)).to eq ['is missing', 'must be one of: user, admin']
    end
  end
end
