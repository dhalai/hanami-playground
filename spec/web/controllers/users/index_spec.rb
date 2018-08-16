describe Web::Controllers::Users::Index, type: :action do
  let(:params) { Hash[] }
  let(:repository) { instance_double("UsersRepository") }
  let(:paginator_result) { Hash[] }
  let(:paginator) { instance_double("Paginator", call: paginator_result) }
  let(:filter_result) { OpenStruct.new(relation: {}) }
  let(:filter) { instance_double("Filter", call: filter_result) }
  let(:action) do
    described_class.new(
      repository: repository,
      paginator: paginator,
      filter: filter
    )
  end

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

    it 'exposes paginator' do
      action.call(params)
      expect(action.exposures[:paginator]).to eq paginator_result
    end
  end
end
