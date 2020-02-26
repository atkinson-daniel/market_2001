require "minitest/autorun"
require "minitest/pride"
require "./lib/item"
require "./lib/vendor"
require "./lib/market"

class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_it_has_attributes
    assert_equal "South Pearl Street Farmers Market", @market.name
    assert_equal [], @market.vendors
  end

  def test_it_can_add_vendors
  @vendor1.stock(@item1, 35)
  @vendor1.stock(@item2, 7)
  @vendor2.stock(@item4, 50)
  @vendor2.stock(@item3, 25)
  @vendor3.stock(@item1, 65)
  @market.add_vendor(@vendor1)
  @market.add_vendor(@vendor2)
  @market.add_vendor(@vendor3)

  assert_equal [@vendor1, @vendor2, @vendor3], @market.vendors
  end

  def test_it_can_return_vendor_names
  @vendor1.stock(@item1, 35)
  @vendor1.stock(@item2, 7)
  @vendor2.stock(@item4, 50)
  @vendor2.stock(@item3, 25)
  @vendor3.stock(@item1, 65)
  @market.add_vendor(@vendor1)
  @market.add_vendor(@vendor2)
  @market.add_vendor(@vendor3)
  expected = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]

  assert_equal expected, @market.vendor_names
  end

  def test_it_can_return_vendors_that_sell_a_specific_item
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal [@vendor1, @vendor3], @market.vendors_that_sell(@item1)
    assert_equal [@vendor2], @market.vendors_that_sell(@item4)
  end

  def test_it_can_return_total_inventory
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @vendor3.stock(@item3, 10)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expected = {
                @item1 => {:quantity => 100, :vendors => [@vendor1, @vendor3]},
                @item2 => {:quantity => 7, :vendors => [@vendor1]},
                @item4 => {:quantity => 50, :vendors => [@vendor2]},
                @item3 => {:quantity => 35, :vendors => [@vendor2, @vendor3]}
                }

    assert_equal expected, @market.total_inventory
  end

  def test_it_can_find_total_items
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @vendor3.stock(@item3, 10)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal [@item1, @item2, @item4, @item3], @market.find_total_items
  end

  def test_it_can_return_overstocked_items
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @vendor3.stock(@item3, 10)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal [@item1], @market.overstocked_items
  end

  def test_it_can_sort_list
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @vendor3.stock(@item3, 10)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expected = ["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"]

    assert_equal expected, @market.sorted_item_list
  end
end


# Iteration 3 - Items sold at the Market
# Add a method to your Market class called sorted_item_list that returns a list of names of all items the Vendors have in stock, sorted alphabetically. This list should not include any duplicate items.
#
# Additionally, your Market class should have a method called total_inventory that reports the quantities of all items sold at the market. Specifically, it should return a hash with items as keys and hash as values - this sub-hash should have two key/value pairs: quantity pointing to total inventory for that item and vendors pointing to an array of the vendors that sell that item.
#
# You Market will also be able to identify overstocked_items. An item is overstocked if it is sold by more than 1 vendor AND the total quantity is greater than 50.
#

# pry(main).overstocked_items
# #=> [#<Item:0x007f9c56740d48...>]
#
# pry(main)> market.sorted_item_list
# #=> ["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"]
