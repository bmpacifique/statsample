require(File.expand_path(File.dirname(__FILE__) + '/helpers_tests.rb'))
class StatsampleDatasetTestCase
  def setup
    assert_output(nil, "WARNING: Statsample::Dataset and Statsample::Vector have been deprecated in favor of Daru::DataFrame and Daru::Vector. Please switch to using that.") do
      @ds = Statsample::Dataset.new({ 
        'id' => Statsample::Vector.new([1, 2, 3, 4, 5]), 
        'name' => Statsample::Vector.new(%w(Alex Claude Peter Franz George)), 
        'age' => Statsample::Vector.new([20, 23, 25, 27, 5]),
        'city' => Statsample::Vector.new(['New York', 'London', 'London', 'Paris', 'Tome']),
        'a1' => Statsample::Vector.new(['a,b', 'b,c', 'a', nil, 'a,b,c']) }, 
        %w(id name age city a1))
    end
  end

  def test_basic
    assert_output(nil, "WARNING: Statsample::Vector has been deprecated for Daru::Vector. Please switch to using that.") do
      assert_equal(5, @ds.cases)
      assert_equal([:id, :name, :age, :city, :a1], @ds.fields)
    end
  end

  def test_fields
    assert_output(nil, "WARNING: Statsample::Vector has been deprecated for Daru::Vector. Please switch to using that.") do
      @ds.fields = %w(name a1 id age city)
      assert_equal([:name, :a1, :id, :age, :city], @ds.fields)
    end

    assert_raise ArgumentError, "Assigning less fields than vectors is no longer supported" do
      @ds.fields = %w(id name age)
    end
  end

  def test_crosstab_with_asignation
    v1 = %w(a a a b b b c c c).to_vector
    v2 = %w(a b c a b c a b c).to_vector
    v3 = %w(0 1 0 0 1 1 0 0 1).to_numeric

    assert_output(nil, "WARNING: Statsample::Dataset and Statsample::Vector have been deprecated in favor of Daru::DataFrame and Daru::Vector. Please switch to using that.") do
      ds = Statsample::Dataset.crosstab_by_asignation(v1, v2, v3)
    end

    assert_output(nil, "WARNING: Daru uses symbols instead of strings for naming vectors. Please switch to symbols.") do
      assert_equal(:object, ds['_id'].type)
      assert_equal(:numeric, ds['a'].type)
      assert_equal(:numeric, ds['b'].type)
    end
  end
end
