class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    return 0 if @inventory[item] == nil
    @inventory[item]
  end

  def stock(item, amount)
    if inventory[item] == nil
      inventory[item] = amount
    else
      inventory[item] += amount
    end
  end

  def potential_revenue
    @inventory.inject(0) do |total, inventory|
      total += inventory.first.price * inventory.last
    end
  end
end
