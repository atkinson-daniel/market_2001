class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    @vendors.find_all {|vendor| vendor.inventory.include?(item)}
  end

  def find_total_items
    total_items = []
    @vendors.each do |vendor|
      total_items << vendor.inventory.keys
    end
    total_items = total_items.flatten.uniq
  end

  def items_and_quantity
    total_items = []
    @vendors.each do |vendor|
      total_items << vendor.inventory
    end
    total_items = total_items.flatten.uniq

    my_new_hash = {}
    total_items.each do |items|
      items.each do |item|
        if my_new_hash.has_key?(item.first)
          my_new_hash[item.first] += item.last
        else
          my_new_hash[item.first] = item.last
        end
      end
    end
    my_new_hash
  end

  def find_item_quantity(item)
    x = items_and_quantity
    x[item]
  end

  def total_inventory
    market_items = {}
    find_total_items.each do |item|
      market_items[item] = {quantity: find_item_quantity(item),
                            vendors: vendors_that_sell(item)}
    end
    market_items
  end

  def overstocked_items
    found = total_inventory.find_all do |items|
      items[1].values.first > 50 && items[1].values.last.length > 1
    end.flatten
    [found.first]
  end

  def sorted_item_list
    find_total_items.map {|item| item.name}.sort
  end
end
