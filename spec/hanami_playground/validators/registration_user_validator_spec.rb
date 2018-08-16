describe RegistrationUserValidator, type: :validator do
  subject { described_class.new(params) }
  let(:user) { nil }
  let(:repository) { instance_double("UserRepository", find_by_email: user) }

  before do
    allow(UserRepository).to receive(:new).and_return(repository)
  end

  context 'with valid params' do
    let(:params) do
      {
        user: {
          email: "some@email.com",
          password: "some_password"
        }
      }
    end

    it 'is valid' do
      expect(subject.validate.success?).to be true
    end

    it 'returns right messages' do
      expect(subject.validate.messages).to eq({})
    end

    context 'with existent user' do
      let(:user) { Hash[some: :user_data] }
      let(:errors) { { user: ['User with this email has already existed'] } }

      it 'is invalid' do
        expect(subject.validate.success?).to be false
      end

      it 'returns right messages' do
        expect(subject.validate.messages).to eq errors
      end
    end
  end

  context 'with invalid params' do
    let(:params) { [] }
    let(:errors) { { user: ['is missing'] } }

    it 'is invalid' do
      expect(subject.validate.success?).to be false
    end

    it 'returns right messages' do
      expect(subject.validate.messages).to eq errors
    end

    context "with some data" do
      let(:user_params) do
        {
          email: "invalid_email",
          password: "invalid"
        }
      end

      let(:params) { Hash[user: user_params] }
      let(:errors) do
        {
          user: {
            email: ["is in invalid format"],
            password: ["size cannot be less than 8"]
          }
        }
      end

      it 'is invalid' do
        expect(subject.validate.success?).to be false
      end

      it 'returns right messages' do
        expect(subject.validate.messages).to eq errors
      end
    end
  end
end
