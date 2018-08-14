RSpec.describe CreateUserValidator, type: :validator do
  subject { described_class.new(params) }

  context 'with valid params' do
    let(:params) do
      {
        user: {
          email: "some@email.com",
          password: "some_password",
          role: "admin"
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
  end
end
