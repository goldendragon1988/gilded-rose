require 'spec_helper'

describe GildedRose do
  let!(:sell_in) { 5 }
  let!(:quality) { 5 }
  let!(:item) { Item.new(name, sell_in, quality) }

  describe "#update_quality" do
    context "any item" do
      let!(:name) { "Ether" }
      it "increases quality of other items" do
        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 4
      end

      it "decreases quality of other items" do
        item.sell_in = -1
        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 3
      end
    end

    context "Aged Brie" do
      let!(:name) { "Aged Brie" }
      it "checks if Aged Brie increases quality" do
        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 6
      end

      it "checks if Aged Brie increases quality twice" do
        item.sell_in = -1
        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 7
      end
    end

    context "Sulfuras" do
      let!(:name) { "Sulfuras, Hand of Ragnaros" }
      it "checks if Sulfuras quality doesn't change" do
        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 80
      end
      it "checks if Sulfuras sell_in decreases by 1" do
        GildedRose.new([item]).update_quality

        expect(item.sell_in).to eq 5
      end
    end

    context "Conjured" do
      let!(:name) { "Conjured item" }
      it "checks if conjured quality decreases by 2" do
        GildedRose.new([item]).update_quality

        expect(item.sell_in).to eq 4
        expect(item.quality).to eq 3
      end

      it "If sell_in has pass, quality degrades by 4" do
        item.sell_in = 0
        GildedRose.new([item]).update_quality

        expect(item.sell_in).to eq 0
        expect(item.quality).to eq 1
      end
    end

    context "Backstage passes" do
      let!(:name) { "Backstage passes to a TAFKAL80ETC concert" }
      it "checks if it increases by three when sell in 5 days or less" do
        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 8
      end


      it "checks if it increases by two when sell in 10 days or less" do
        item.sell_in= 10
        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 7
      end

      it "checks quality is zero when concert passed" do
        item.sell_in= 0
        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 0

      end

      it "checks if it increases by one when sell in is more than 10 days" do
        item.sell_in = 13
        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 6
      end
    end

    context "Quality validation" do
      let!(:name) { "Ether" }
      it "checks if it doesn't return a negative value" do
        item.quality = 0

        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 0
      end

     it "checks if it doesn't exceed 50" do
        item.name = "Aged Brie"
        item.quality = 50

        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 50
      end
    end
  end
end
