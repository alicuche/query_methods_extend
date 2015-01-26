require "spec_helper"

module QueryMethodsExtend
  describe OrExtend do
    before :all do
      run_migrate
    end

    describe "Or methods" do
      before :all do
        @first = Book.create(name: 'Ruby on rails advance', price: 10)
        @seconds = Book.create(name: 'PHP advance', price: 10)
        @three = Book.create(name: 'C# Programmer', price: 5)
      end

      context 'or with agruments' do
        it "return seconds and three books" do
          expect(Book.or(name: 'PHP advance', price: 5)).to match_array([@seconds, @three])
        end
      end

      context 'or no agurments' do
        it "return first and seconds book" do
          expect(Book.where(name: 'PHP advance').or.where(price: 5)).to match_array([@seconds, @three])
        end
      end
    end
  end
end