require "spec_helper"

module QueryMethodsExtend
  describe Union do
    before :all do
      run_migrate
    end

    describe "Union methods" do
      before :all do
        @first = Book.create(name: 'Ruby on rails advance', price: 10)
        @seconds = Book.create(name: 'PHP advance', price: 10)
        @three = Book.create(name: 'C# Programmer', price: 5)
      end

      it "return seconds and three books" do
        result = Book.where(name: 'PHP advance').union(Book.where(price: 5))
        expect(result).to match_array([@seconds, @three])
      end
    end
  end
end