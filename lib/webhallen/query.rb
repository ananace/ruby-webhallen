# frozen_string_literal: true

module Webhallen
  class Query
    attr_accessor :query, :page

    def initialize
      @query = {
        sortBy: :sales,
        filters: [],
        minPrice: 0,
        maxPrice: 999999,
      }
      @page = 1
    end

    def with_category id
      @query[:filters] << {
        type: :category,
        value: id
      }
      self
    end

    def with_text text
      @query[:filters] << {
        type: :text,
        value: text
      }
      self
    end

    def with_price min: nil, max: nil
      @query[:minPrice] = min if min
      @query[:maxPrice] = max if max
      self
    end

    def order_by type
      @query[:sortBy] = type
      self
    end

    def to_queryhash
      convert_hash(@query, 'query').merge(page: @page)
    end

    def to_uri
      u = URI(File.join(Webhallen::BASE_URI, 'api', 'search'))
      u.query = URI.encode_www_form(to_queryhash)

      u
    end

    private

    def convert_hash hash, path
      Hash[hash.map do |key, value|
        if value.is_a? Array
          value.map.with_index do |v, i|
            convert_hash(v, "#{path}[#{key}][#{i}]").to_a
          end.flatten
        elsif value.is_a? Hash
          convert_hash(value, "#{path}[#{key}]")
        else
          ["#{path}[#{key}]".to_sym, value]
        end
      end.flatten.each_slice(2).to_a]
    end
  end
end
