# frozen_string_literal: true

require 'json'
require 'webhallen/product'
require 'webhallen/query'
require 'webhallen/version'

module Webhallen
  BASE_URI = 'https://www.webhallen.com/'
  LANG = 'se'

  def self.search(query)
    raise ArgumentError, 'query must be a Webhallen::Query' unless query.is_a? Query

    doc = Net::HTTP.get query.to_uri
    doc = JSON.parse(doc, symbolize_names: true)

    doc[:products] = doc[:products].map { |prod| Product.new(**prod) }

    doc
  end

  class Error < StandardError; end
end
