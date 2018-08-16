describe Web::Controllers::Users::New, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:user) do
    OpenStruct.new(
      email: "some@email.com",
      password: "some_password",
      role: role,
      admin?: role == "admin"
    )
  end

  before { sign_in user }

  context "as user" do
    let(:role) { "user" }
    it_behaves_like "protected resource"
  end

  context "as admin" do
    let(:role) { "admin" }

    it 'is successful' do
      response = action.call(params)
      expect(response[0]).to eq 200
    end
  end
end
