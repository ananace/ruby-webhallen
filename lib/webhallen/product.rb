# frozen_string_literal: true

module Webhallen
  class Product
    attr_reader :id, :name, :price, :stock, :release

    def initialize id:, name:, price:, stock:, release:, **json
      @id = id
      @name = name
      @price = price
      @stock = stock
      @release = release
    end

    def self.get_by_id id
      new(**JSON.parse(Net::HTTP.get(URI(File.join(Webhallen::BASE_URI, 'api', 'product', id.to_s))), symbolize_names: true)[:product])
    end

    def pretty_price
      "#{price[:price]} #{price[:currency]}"
    end

    def to_uri
      URI(File.join(Webhallen::BASE_URI, Webhallen::LANG, 'product', id.to_s))
    end

    def in_stock?
      stock[:web].to_i > 0 || stock.any? { |key, value| key =~ /^\d+$/ && value.to_i > 0 }
    end

    def available_at_supplier?
      !stock[:supplier].nil? && stock[:supplier].to_i > 0
    end
  end
end
