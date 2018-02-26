# frozen_string_literal: true

RSpec.describe PolishGeeks::DevTools::Commands::EmptyMethods::FileParser do
  subject(:file_parser) { described_class.new(file) }
  let(:file) { Tempfile.new('foo') }

  describe '#find_empty_methods' do
    context 'empty define_singleton_methods' do
      before do
        file.write("
          define_singleton_method(:a) {}
          define_singleton_method('b') { |_a, _b| }
          define_singleton_method :c do |_a, _b|
            #
            #
          end
          define_singleton_method :d do |_a, _b|
          end
          ")
        file.read
      end

      it { expect(file_parser.find_empty_methods).to eq([2, 4, 5, 10]) }
    end

    context 'empty define_methods with comments' do
      before do
        file.write("
          define_method(:a) {} # comment
          define_method('b') { |_a, _b| } # comment
          define_method :c do |_a, _b| # comment
            #
          end
          ")
        file.read
      end

      it { expect(file_parser.find_empty_methods).to eq([2, 4, 5]) }
    end

    context 'empty define_methods' do
      before do
        file.write("
          define_method(:a) {}
          define_method('b') { |_a, _b| }
          define_method :c do |_a, _b|
            #
          end
          ")
        file.read
      end

      it { expect(file_parser.find_empty_methods).to eq([2, 4, 5]) }
    end

    context 'singleton_methods and methods are defined' do
      before do
        file.write("
          define_singleton_method(:a) { puts rand(5) }
          define_singleton_method(:ab) { |_a, _b| rand(5) }
          define_singleton_method :c do |_a, _b|
            rand(5)
          end
          define_method(:d) { puts rand(5) }
          define_method(:e) { |_a, _b| rand(5) }
          define_method :f do |_a, _b|
            # comment
            # comment
            rand(5)
          end")
        file.read
      end

      it { expect(file_parser.find_empty_methods).to be_empty }
    end

    context 'empty one line method' do
      before do
        file.write(' def a; end ')
        file.read
      end

      it { expect(file_parser.find_empty_methods).to eq([1]) }
    end

    context 'empty one line method with comment' do
      before do
        file.write(' def a; end #comment ')
        file.read
      end

      it { expect(file_parser.find_empty_methods).to eq([1]) }
    end

    context 'empty body method' do
      before do
        file.write(" def a
                     end ")
        file.read
      end

      it { expect(file_parser.find_empty_methods).to eq([1]) }
    end

    context 'empty body method with comment' do
      before do
        file.write(" def a # comment
                     end #comment")
        file.read
      end

      it { expect(file_parser.find_empty_methods).to eq([1]) }
    end

    context 'empty method' do
      before do
        file.write(" def a
                      #
                      #
                     end ")
        file.read
      end

      it { expect(file_parser.find_empty_methods).to eq([1]) }
    end

    context 'method with comments inside' do
      before do
        file.write(" def a
                      # comment
                      # comment
                      # comment
                      rand(10)
                     end ")
        file.read
      end

      it { expect(file_parser.find_empty_methods).to be_empty }
    end

    context 'method which defines empty define_method inside' do
      before do
        file.write(" def a
                      define_method(:asd) {}
                     end ")
        file.read
      end

      it { expect(file_parser.find_empty_methods).to eq([2]) }
    end

    context 'method which defines empty define_singleton_method inside' do
      before do
        file.write(" def a
                      define_singleton_method(:asd) do
                        # comment
                      end
                     end ")
        file.read
      end

      it { expect(file_parser.find_empty_methods).to eq([2]) }
    end

    context 'method which defines define_method inside' do
      before do
        file.write(" def a
                      define_method(:asd) { rand(150) } #
                     end ")
        file.read
      end

      it { expect(file_parser.find_empty_methods).to be_empty }
    end
  end

  describe '#method_has_no_lines?' do
    it { expect(file_parser.send(:method_has_no_lines?, 2, 4)).to be_falsey }
    it { expect(file_parser.send(:method_has_no_lines?, 2, 3)).to be_truthy }
  end

  describe '#add_empty_method' do
    it { expect(file_parser.send(:add_empty_method, 2)).to eq [3] }
  end

  describe '#add_empty_method' do
    it { expect(file_parser.send(:add_empty_method, 2)).to eq [3] }
  end
end
