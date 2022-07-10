# frozen_string_literal: true

module Webhallen
  class Product
    attr_reader :id, :name, :price, :stock, :release

    def initialize(id:, name:, price:, stock:, release:, **) # rubocop:disable Metrics/ParameterLists Taken from JSON, needs to extract the data in a sane way
      @id = id
      @name = name
      @price = price
      @stock = stock
      @release = release
    end

    def self.get_by_id(id)
      new(**JSON.parse(Net::HTTP.get(URI(File.join(Webhallen::BASE_URI, 'api', 'product', id.to_s))), symbolize_names: true)[:product])
    end

    def pretty_price
      "#{price[:price]} #{price[:currency]}"
    end

    def to_uri
      URI(File.join(Webhallen::BASE_URI, Webhallen::LANG, 'product', id.to_s))
    end

    def in_stock?
      stock[:web].to_i.positive? || stock.any? { |key, value| key =~ /^\d+$/ && value.to_i.positive? }
    end

    def available_at_supplier?
      !stock[:supplier].nil? && stock[:supplier].to_i.positive?
    end
  end
end
