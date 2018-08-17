describe Web::Views::Users::Create, type: :view do
  let(:current_user) { OpenStruct.new(admin?: true) }
  let(:exposures)    { Hash[format: :html, current_user: current_user] }
  let(:template)     { Hanami::View::Template.new('apps/web/templates/users/create.html.erb') }
  let(:view)         { described_class.new(template, exposures) }
  let(:rendered)     { view.render }

  let(:form_errors) do
    {
      user: {
        email: ['must be fullfilled'],
        password: ['must be fullfilled'],
        role: ['is missing']
      }
    }
  end

  let(:exposures) do
    {
      format: :html,
      params: {},
      form_errors: form_errors,
      current_user: current_user
    }
  end
  let(:template)  { Hanami::View::Template.new('apps/web/templates/users/new.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'displays list of errors when params contains errors' do
    form_errors[:user].each do |field, msg|
      expect(rendered.include?("#{field.capitalize} #{msg.join(',')}")).to be true
    end
  end
end
