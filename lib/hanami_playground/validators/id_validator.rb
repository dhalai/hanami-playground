require 'hanami/validations'

class IdValidator
  include Hanami::Validations

  predicate :id?, message: 'must be an Integer' do |current|
    current.match?(/^\d*$/)
  end

  validations do
    required(:id) { filled? & id? }
  end
end
