require "spec_helper"

module QueryMethodsExtend
  describe Operators do
    before :all do
      run_migrate
    end

    describe "Operators methods" do
      before :all do
        @first = Book.create(name: 'Ruby on rails advance', price: 10)
        @seconds = Book.create(name: 'PHP advance', price: 20)
      end

      context 'like method' do
        it "return match array is true" do
          expect(Book.lt(price: 15)).to match_array(@first)
          expect(Book.gt(price: 15)).to match_array(@seconds)
          expect(Book.lteq(price: 10)).to match_array(@first)
          expect(Book.gteq(price: 10)).to match_array([@first, @seconds])
        end
      end
    end
  end
end