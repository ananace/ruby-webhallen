require 'test_helper'

class QueryTest < Test::Unit::TestCase
  def setup
    @query = Webhallen::Query.new
  end

  def test_default_query
    refute_nil @query.to_queryhash
    refute_nil @query.to_uri
  end

  def test_category
    @query.query = {filters: []}
    @query.with_category 10

    assert_equal 1, @query.query[:filters].count
    assert_equal :category, @query.query[:filters][0][:type]
    assert_equal 10, @query.query[:filters][0][:value]

    assert_equal({
      page: 1,
      :'query[filters][0][type]' => :category,
      :'query[filters][0][value]' => 10
    }, @query.to_queryhash)
  end

  def test_text
    @query.query = {filters: []}
    @query.with_text 'testcase'

    assert_equal 1, @query.query[:filters].count
    assert_equal :text, @query.query[:filters][0][:type]
    assert_equal 'testcase', @query.query[:filters][0][:value]

    assert_equal({
      page: 1,
      :'query[filters][0][type]' => :text,
      :'query[filters][0][value]' => 'testcase'
    }, @query.to_queryhash)
  end

  def test_price
    @query.query = {filters: []}
    @query.with_price min: 10, max: 5000

    assert_equal 0, @query.query[:filters].count
    assert_equal 10, @query.query[:minPrice]
    assert_equal 5000, @query.query[:maxPrice]

    assert_equal({
      page: 1,
      :'query[minPrice]' => 10,
      :'query[maxPrice]' => 5000
    }, @query.to_queryhash)
  end

  def test_ordering
    @query.query = {filters: []}
    @query.order_by :latest

    assert_equal 0, @query.query[:filters].count
    assert_equal :latest, @query.query[:sortBy]

    assert_equal({
      page: 1,
      :'query[sortBy]' => :latest
    }, @query.to_queryhash)
  end

  def test_stacking
    @query.with_category(10)
      .with_text('testcase')
      .with_price(min: 10, max: 5000)
      .order_by(:latest)

    assert_equal :category, @query.query[:filters][0][:type]
    assert_equal 10, @query.query[:filters][0][:value]
    assert_equal :text, @query.query[:filters][1][:type]
    assert_equal 'testcase', @query.query[:filters][1][:value]
    assert_equal 10, @query.query[:minPrice]
    assert_equal 5000, @query.query[:maxPrice]
    assert_equal :latest, @query.query[:sortBy]

    assert_equal({
      page: 1,
      :'query[filters][0][type]' => :category,
      :'query[filters][0][value]' => 10,
      :'query[filters][1][type]' => :text,
      :'query[filters][1][value]' => 'testcase',
      :'query[minPrice]' => 10,
      :'query[maxPrice]' => 5000,
      :'query[sortBy]' => :latest
    }, @query.to_queryhash)
  end
end
