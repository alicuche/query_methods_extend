require "spec_helper"

module QueryMethodsExtend
  describe Association do
    before :all do
      run_migrate
    end

    describe "Or methods" do
      before :all do
        @store1 = Store.create(address: 'Vietnam')
        @store2 = Store.create(address: 'USA')
        @store3 = Store.create(address: 'Japan')

        @cate1 = @store1.categories.create(name: 'Php')
        @cate2 = @store1.categories.create(name: 'Rails')
        @cate3 = @store1.categories.create(name: 'C#')
        @cate4 = @store2.categories.create(name: 'Java')
        @cate5 = @store3.categories.create(name: 'Unknow')

        @book1 = @cate1.books.create(name: 'Ruby on rails advance', price: 10)
        @book2 = @cate1.books.create(name: 'PHP advance', price: 15)
        @book3 = @cate2.books.create(name: 'Java every day', price: 20)
        @book4 = @cate2.books.create(name: 'C# 24 days', price: 25)
        @book5 = @cate4.books.create(name: 'Unknown', price: 30)
      end

      it "return 3 categories" do
        result = Store.where('stores.address = ? OR stores.address = ?', 'Vietnam', 'USA').categories
        expect(result).to match_array([@cate1, @cate2, @cate3, @cate4])
      end

      it "return 4 books" do
        result = Store.where(address: 'Vietnam').categories.books
        expect(result).to match_array([@book1, @book2, @book3, @book4])
      end

      it "return 2 books" do
        result = Store.where(address: 'Vietnam').categories.books.where('books.price <= 15')
        expect(result).to match_array([@book1, @book2])
      end
    end

  end
end