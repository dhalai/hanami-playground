describe Web::Views::Users::Index, type: :view do
  let(:paginator) { OpenStruct.new(result: result, rendered: "") }
  let(:exposures) { Hash[format: :html, params: {}, paginator: paginator] }
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
      expect(rendered.scan(/class="user"/).count).to eq 2
    end

    it 'does not show the placeholder' do
      expect(rendered).to_not include(placeholder)
    end
  end
end
