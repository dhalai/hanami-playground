describe Web::Views::Users::Edit, type: :view do
  let(:current_user) { "some_user_info" }
  let(:exposures) { Hash[format: :html, current_user: current_user] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/users/edit.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    expect(view.format).to eq exposures.fetch(:format)
  end
end
