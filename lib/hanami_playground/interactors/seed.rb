require 'hanami/interactor'

class Seed
  include Hanami::Interactor

  TEST_USER = {
    email: "admin@admin.com",
    password: "12345678",
    role: "admin"
  }.freeze

  def initialize(repository: UserRepository.new, interactor: Users::Creator.new)
    @repository = repository
    @interactor = interactor
  end

  def call
    @interactor.call(TEST_USER) unless user
  end

  private

  def user
    @repository.find_by_email(TEST_USER[:email])
  end
end
