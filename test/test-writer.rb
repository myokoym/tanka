require "tanka_renderer/writer"
require "cairo"

class WriterTest < Test::Unit::TestCase
  def setup
    @writer = TankaRenderer::Writer.new
  end

  class GuessFontTest < self
    def test_found
      part_of_name = "M"
      assert_match(/#{part_of_name}/, @writer.guess_font(part_of_name))
    end

    def test_not_found
      part_of_name = "ABCDE12345"
      assert_nil(@writer.guess_font(part_of_name))
    end
  end

  class DrawTest < self
    def test_ten_characters
      assert_nothing_raised_in_draw("1234567890")
    end

    private
    def assert_nothing_raised_in_draw(text)
      width =  200
      height = 200
      assert_nothing_raised do
        Cairo::ImageSurface.new(:argb32, width, height) do |surface|
          Cairo::Context.new(surface) do |context|
            @writer.draw(context, text)
          end
        end
      end
    end
  end
end
