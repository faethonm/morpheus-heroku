require 'morpheus/fetch'
require 'morpheus/load'

require 'morpheus/helper'
require 'morpheus/config'

require 'morpheus/railtie'

module Morpheus
  class << self
    attr_accessor :configuration
  end

  extend self

  def fetch
    Morpheus::Fetch.run
  end

  def load
    Morpheus::Load.run
  end

  def deploy(environment = :production)

  end

  def self.configure
    self.configuration ||= Config.new
    yield(configuration)
  end
end
