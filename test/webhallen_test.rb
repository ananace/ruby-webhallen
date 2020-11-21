require "test_helper"
require 'net/http'

class WebhallenTest < Test::Unit::TestCase
  FIXTURE = <<~DOC
  {"products":[{"id":305331,"name":"Gigabyte Radeon RX 5700 XT 8GB Gaming OC","price":{"price":"4349.00","currency":"SEK","vat":869.8,"type":null,"endAt":"2021-02-21","maxQtyPerCustomer":null},"stock":{"1":0,"2":0,"5":0,"8":0,"9":0,"10":0,"11":0,"14":0,"15":0,"16":1,"17":0,"19":1,"20":0,"21":0,"22":0,"23":0,"26":0,"27":0,"28":0,"29":0,"web":0,"supplier":null,"displayCap":50,"orders":{"CL":{"ordered":51,"status":2}}},"release":{"timestamp":1565841600,"format":"Y-m-d"},"isFyndware":false,"reviewCount":null,"categoryTree":"Datorkomponenter/Grafikkort GPU/AMD Radeon","regularPrice":{"price":"4349.00","currency":"SEK","vat":869.8,"type":null,"endAt":"2021-02-21","maxQtyPerCustomer":null},"fyndwareClass":null,"averageRating":null,"energyMarking":null,"statusCodes":[],"mainTitle":"Gigabyte Radeon RX 5700 XT 8GB Gaming OC","subTitle":"AMD Radeon / PCI Express 4.0 x16 / 8 GB / 1605 MHz"}],"totalProductCount":1}
  DOC

  def test_that_it_has_a_version_number
    refute_nil ::Webhallen::VERSION
  end

  def test_search
    Net::HTTP.expects(:get).with(URI('https://www.webhallen.com/api/search?query%5BsortBy%5D=sales&query%5Bfilters%5D%5B0%5D%5Btype%5D=category&query%5Bfilters%5D%5B0%5D%5Bvalue%5D=3031&query%5BminPrice%5D=0&query%5BmaxPrice%5D=7998&page=1')).returns(FIXTURE)
    
    result = Webhallen.search Webhallen::Query.new.with_category(3031).with_price(min: 0, max: 7998)
    refute_nil result

    assert_equal 1, result[:totalProductCount]
    assert_equal 305331, result[:products].first.id
    assert_equal '4349.00 SEK', result[:products].first.pretty_price
  end
end
