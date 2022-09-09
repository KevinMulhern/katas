require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do

    describe "normal item" do
      context "before sell date" do
        it "decreases quality by 1" do
          items = [Item.new("normal", 1, 2)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(1)
        end

        it "cannot decrease quality below 0" do
          items = [Item.new("normal", 10, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it "decreases sell_in by 1" do
          items = [Item.new("normal", 10, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(9)
        end
      end

      context "on sell date" do
        it "decreases quality by 1" do
          items = [Item.new("normal", 0, 2)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(1)
        end

        it "cannot decrease quality below 0" do
          items = [Item.new("normal", 0, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it "decreases sell_in by 1" do
          items = [Item.new("normal", 10, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(9)
        end
      end

      context "after sell date" do
        it "decreases quality by 2" do
          items = [Item.new("normal", -1, 2)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it "cannot decrease quality below 0" do
          items = [Item.new("normal", -1, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it "decreases sell_in by 1" do
          items = [Item.new("normal", 10, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(9)
        end
      end
    end

    describe "Aged Brie" do
      context "before sell date" do
        it "increases quality by 1" do
          items = [Item.new("Aged Brie", 3, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(1)
        end

        it "cannot increase in quality beyond 50" do
          items = [Item.new("Aged Brie", 1, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end
      end

      context "on sell date" do
        it "increases quality twice as fast" do
          items = [Item.new("Aged Brie", 0, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(2)
        end

        it "cannot increase in quality beyond 50" do
          items = [Item.new("Aged Brie", 0, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end
      end

      context "after sell date" do
        it "increases in quality twice as fast" do
          items = [Item.new("Aged Brie", -1, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(2)
        end

        it "cannot increase in quality beyond 50" do
          items = [Item.new("Aged Brie", -1, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end
      end

      it "increases in quality the older it gets" do
        items = [Item.new("Aged Brie", 6, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(11)

        items = [Item.new("Aged Brie", 4, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(11)
      end

      it "increases in quality twice as fast after sell by date" do
        items = [Item.new("Aged Brie", -2, 8)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(10)
      end

      it "cannot have a higher quality than 50" do
        items = [Item.new("Aged Brie", -1, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq(50)
      end

      it "decreases sell in days" do
        items = [Item.new("Aged Brie", 10, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq(9)
      end
    end

    describe "Sulfuras" do
      context "before sell by date" do
        it "never has to be sold" do
          items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(10)
        end

        it "never decreases in quality" do
          items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end
      end

      context "on sell by date" do
        it "never has to be sold" do
          items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(0)
        end

        it "never decreases in quality" do
          items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end
      end

      context "after sell by date" do
        it "never has to be sold" do
          items = [Item.new("Sulfuras, Hand of Ragnaros", -1, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(-1)
        end

        it "never decreases in quality" do
          items = [Item.new("Sulfuras, Hand of Ragnaros", -1, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end

        it "cannot have a higher quality than 50" do
          items = [Item.new("Aged Brie", -1, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end
      end
    end

    describe "Backstage passes" do
      context "when sell in days is more than 10" do
        it "increases in quality by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(11)
        end

        it "cannot have a higher quality than 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end

        it "cannot have a lower quality than 0" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it "decreases sell in days" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(14)
        end
      end

      context "when sell in days is 10 or less" do
        it "increases in quality by 2" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(12)
        end

        it "cannot have a higher quality than 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end

        it "cannot have a lower quality than 0" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it "decreases sell in days" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(9)
        end
      end

      context "when sell in days is 5 or less" do
        it "increases in quality by 3" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(13)
        end

        it "cannot have a higher quality than 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end

        it "cannot have a lower quality than 0" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it "decreases sell in days" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(4)
        end
      end

      context "when sell in days is 0 or less" do
        it "drops quality to 0" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it "cannot have a higher quality than 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(50)
        end

        it "cannot have a lower quality than 0" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it "decreases sell in days" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(-1)
        end
      end
    end

    describe "Conjured" do
      context "before sell by date" do
        it "decreases in quality twice as fast as normal" do
          items = [Item.new("Conjured", 10, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(8)
        end

        it "cannot decrease quality below 0" do
          items = [Item.new("Conjured", 5, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it "decreases sell in days" do
          items = [Item.new("Conjured", 10, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(9)
        end
      end

      context "on sell by date" do
        it "decreases in quality four times as fast as normal" do
          items = [Item.new("Conjured", 0, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(6)
        end

        it "cannot decrease quality below 0" do
          items = [Item.new("Conjured", 0, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it "decreases sell in days" do
          items = [Item.new("Conjured", 0, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(-1)
        end
      end

      context "after sell by date" do
        it "decreases in quality four times as fast as normal" do
          items = [Item.new("Conjured", -1, 10)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(6)
        end

        it "cannot decrease quality below 0" do
          items = [Item.new("Conjured", -1, 0)]
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq(0)
        end

        it "decreases sell in days" do
          items = [Item.new("Conjured", -1, 50)]
          GildedRose.new(items).update_quality
          expect(items[0].sell_in).to eq(-2)
        end
      end
    end
  end
end
