require 'test_helper'

class ProductTest < Test::Unit::TestCase
  FIXTURE = JSON.parse(<<~DOC, symbolize_names: true)
  {"id":305331,"name":"Gigabyte Radeon RX 5700 XT 8GB Gaming OC","price":{"price":"4349.00","currency":"SEK","vat":869.8,"type":null,"endAt":"2021-02-21","maxQtyPerCustomer":null},"stock":{"1":0,"2":0,"5":0,"8":0,"9":0,"10":0,"11":0,"14":0,"15":0,"16":1,"17":0,"19":1,"20":0,"21":0,"22":0,"23":0,"26":0,"27":0,"28":0,"29":0,"web":0,"supplier":null,"displayCap":50,"orders":{"CL":{"ordered":51,"status":2}}},"release":{"timestamp":1565841600,"format":"Y-m-d"},"isFyndware":false,"reviewCount":null,"categoryTree":"Datorkomponenter/Grafikkort GPU/AMD Radeon","regularPrice":{"price":"4349.00","currency":"SEK","vat":869.8,"type":null,"endAt":"2021-02-21","maxQtyPerCustomer":null},"fyndwareClass":null,"averageRating":null,"energyMarking":null,"statusCodes":[],"mainTitle":"Gigabyte Radeon RX 5700 XT 8GB Gaming OC","subTitle":"AMD Radeon / PCI Express 4.0 x16 / 8 GB / 1605 MHz"}
  DOC

  def setup
    @product = Webhallen::Product.new(**FIXTURE)
  end

  def test_creation
    refute_nil @product

    simple_product = Webhallen::Product.new id: 1, name: 'test', price: { price: 10, currency: 'SEK' }, stock: { :'0' => 0, web: 0, supplier: 0 }, release: ''
    refute_nil simple_product
  end

  def test_uri
    assert_equal URI('https://www.webhallen.com/se/product/305331'), @product.to_uri
  end

  def test_data
    assert_equal 305331, @product.id
    assert_equal '4349.00 SEK', @product.pretty_price
    assert @product.in_stock?
    refute @product.available_at_supplier?
  end
end
