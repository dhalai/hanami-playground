describe Web::Views::Users::Create, type: :view do
  let(:exposures) { Hash[format: :html] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/users/create.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  let(:form_errors) do
    {
      user: {
        email: ['must be fullfilled'],
        password: ['must be fullfilled'],
        role: ['is missing']
      }
    }
  end

  let(:exposures) { Hash[format: :html, params: {}, form_errors: form_errors] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/users/new.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'displays list of errors when params contains errors' do
    expect(rendered.include?('There was a problem with your submission')).to be true

    form_errors[:user].each do |field, msg|
      expect(rendered.include?("#{field.capitalize} #{msg.join(',')}")).to be true
    end
  end
end
