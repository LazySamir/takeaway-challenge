require 'menu'
require 'order'
require 'messager'
describe 'User Stories' do

# As a customer
# So that I can check if I want to order something
# I would like to see a list of dishes with prices
  it "can see a list of dishes with prices" do
    menu = Menu.new
    expect(menu.see_dishes).to eq({ 'spring rolls' => 3.99, 'crispy duck' => 11.95, 'chop suey' => 10.95, 'fried rice' => 4.99 })
  end

# As a customer
# So that I can order the meal I want
# I would like to be able to select some number of several available dishes
  it "can select a dish and quantity" do
    order = Order.new
    expect(order.add('spring rolls', 2)).to eq('added to basket: spring rolls x2 for 3.99 each')
  end
  it "adds dish and quantity to order basket" do
    order = Order.new
    order.add('spring rolls', 2)
    expect(order.basket).to eq([{ 'spring rolls' => 3.99 }, { 'spring rolls' => 3.99 }])
  end

# As a customer
# So that I can verify that my order is correct
# I would like to check that the total I have been given matches the sum of the various dishes in my order
  it "can check total matches order" do
    order = Order.new
    order.add('spring rolls', 2)
    expect(order.check).to eq(["spring rolls: £3.99", "spring rolls: £3.99", "Total: £7.98"])
  end

# # As a customer
# # So that I am reassured that my order will be delivered on time
# # I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered
  it "sends a text to client with ETA" do
    menu = Menu.new
    order = Order.new
    messager = Messager.new
    expect(messager.send_eta_text.body).to eq("Sent from your Twilio trial account - your order will arrive at #{Time.now.hour + 1}:#{Time.now.min}")
    # this tests what the message body contains, not that it sends
  end
end
