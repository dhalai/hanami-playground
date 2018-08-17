describe Web::Views::Users::Index, type: :view do
  let(:paginator) { OpenStruct.new(result: result, rendered: "") }
  let(:current_user) { OpenStruct.new(admin?: true) }
  let(:exposures) do
    {
      format: :html,
      params: {},
      paginator: paginator,
      filters: {},
      current_user: current_user
    }
  end
  let(:template)  { Hanami::View::Template.new('apps/web/templates/users/index.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  let(:placeholder) { '<p>There are no users yet.</p>' }

  context 'without users' do
    let(:result) { [] }

    it 'shows a placeholder message' do
      expect(rendered).to include(placeholder)
    end
  end

  context 'with users' do
    let(:user_1) do
      User.new(
        id: rand(1_000),
        email: SecureRandom.hex,
        password: SecureRandom.hex,
        role: "admin"
      )
    end

    let(:user_2) do
      User.new(
        id: rand(1_000),
        email: SecureRandom.hex,
        password: SecureRandom.hex,
        role: "admin"
      )
    end

    let(:result) { [user_1, user_2] }

    it 'shows all users' do
      expect(rendered.scan(/row user mb-2/).count).to eq 2
    end

    it 'does not show the placeholder' do
      expect(rendered).to_not include(placeholder)
    end
  end
end
