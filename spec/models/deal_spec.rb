require 'spec_helper'

describe Deal do
  it "orders by created at" do
    lindeman = Deal.create!(title: "Andy1", content: "Lindeman", state: "published")
    chelimsky = Deal.create!(title: "David", content: "Chelimsky")

    expect(Deal.active).to eq([lindeman])
  end
  
  it "update name after deal created or updated" do
    lindeman = Deal.create!(title: "<p>Andy1</p>", content: "Lindeman", state: "published")
    expect(lindeman.name).to eq("Andy1")
    expect(lindeman.title).to eq("Andy1")
  end
end
