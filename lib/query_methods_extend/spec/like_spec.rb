require "spec_helper"

module QueryMethodsExtend
  describe Like do
    before :all do
      run_migrate
    end

    describe "Like methods" do
      before :all do
        @first = Book.create(name: 'Ruby on rails advance', price: 10)
        @seconds = Book.create(name: 'PHP advance', price: 20)
      end

      context 'like method' do
        it "return first book" do
          expect(Book.like(name: 'rails')).to match_array(@first)
        end
        it "return seconds book" do
          expect(Book.like(name: 'PHP')).to match_array(@seconds)
        end
        it "return first and seconds book" do
          expect(Book.like(name: 'advance')).to match_array([@first, @seconds])
        end
      end

      context 'left like method' do
        it "return first book" do
          expect(Book.l_like(name: 'rails advance')).to match_array(@first)
        end
        it "return seconds book" do
          expect(Book.l_like(name: 'PHP advance')).to match_array(@seconds)
        end
        it "return first and seconds book" do
          expect(Book.l_like(name: 'advance')).to match_array([@first, @seconds])
        end
      end

      context 'right like method' do
        it "return first book" do
          expect(Book.r_like(name: 'Ruby')).to match_array(@first)
        end
        it "return seconds book" do
          expect(Book.r_like(name: 'PHP')).to match_array(@seconds)
        end
      end

      context 'regex like method' do
        it "return first book" do
          expect(Book.regex_like(name: '%rails%')).to match_array(@first)
        end
        it "return seconds book" do
          expect(Book.regex_like(name: '%PHP%')).to match_array(@seconds)
        end
        it "return first and seconds book" do
          expect(Book.regex_like(name: '%advance')).to match_array([@first, @seconds])
        end
      end
    end
  end
end