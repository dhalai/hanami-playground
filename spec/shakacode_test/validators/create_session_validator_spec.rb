describe CreateSessionValidator, type: :validator do
  subject { described_class.new(params) }

  let(:user) do
    OpenStruct.new(
      email: "some@email.com",
      password: "some_password"
    )
  end

  let(:found_user) { user }
  let(:user_repository) do
    instance_double("UserRepository", find_by_email: found_user)
  end

  before do
    allow(UserRepository).to receive(:new).and_return(user_repository)
    allow(BCrypt::Password).to receive(:new).and_return(user.password)
  end

  context 'with valid params' do
    let(:params) { Hash[session: user.to_h] }

    it 'is valid' do
      expect(subject.validate.success?).to be true
    end

    it 'returns right messages' do
      expect(subject.validate.messages).to eq({})
    end
  end

  context 'with invalid params' do
    let(:params) { [] }
    let(:errors) { { session: ['is missing'] } }

    it 'is invalid' do
      expect(subject.validate.success?).to be false
    end

    it 'returns right messages' do
      expect(subject.validate.messages).to eq errors
    end

    context "with some data" do
      let(:session_params) do
        {
          email: "invalid_email",
          password: ""
        }
      end

      let(:params) { Hash[session: session_params] }
      let(:errors) do
        {
          session: {
            email: ["is in invalid format"],
            password: ["must be filled"]
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

    context "with nonexistent user" do
      let(:found_user) { nil }
      let(:params) { Hash[session: user.to_h] }
      let(:errors) { Hash[valid_user: ["Email or password is invalid"]] }

      it 'is invalid' do
        expect(subject.validate.success?).to be false
      end

      it 'returns right messages' do
        expect(subject.validate.messages).to eq errors
      end
    end
  end
end
