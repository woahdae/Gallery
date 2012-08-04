class MiniTest::Spec
  class UrlMatcher < Struct.new(:subject)
    def matches?(expected)
      @subject  = URI.parse(subject).path
      @expected = URI.parse(expected).path
      @subject == @expected
    end

    def failure_message
      "Expected '#{@expected}', got '#{@subject}'"
    end
  end

  def equal_url(url)
    UrlMatcher.new(url)
  end
end
