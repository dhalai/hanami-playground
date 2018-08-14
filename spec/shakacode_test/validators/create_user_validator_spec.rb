RSpec.describe CreateUserValidator, type: :validator do
  subject { described_class.new(params) }

  context 'with valid params' do
    let(:params) do
      {
        user: {
          email: "some@email.com",
          password: "some_password",
          role: "Admin"
        }
      }
    end

    it 'is valid' do
      expect(subject.validate.success?).to be true
    end

    it 'returns right messages' do
      expect(subject.validate.messages).to eq({})
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
          password: "invalid",
          role: "invalid_role"
        }
      end

      let(:params) { Hash[user: user_params] }
      let(:errors) do
        {
          user: {
            email: ["is in invalid format"],
            password: ["size cannot be less than 8"],
            role: ["must be one of: User, Admin"]
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
