class Mdq < Formula
  desc "Like jq but for Markdown"
  homepage "https://github.com/yshavit/mdq"
  url "https://github.com/yshavit/mdq/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "0a62a73f762e6ffa38dc914c585916d50d093c282a4805d6abd3cf1896a14293"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/"example.md").write <<~MARKDOWN
      # First Section
      - [x] Completed item
      - [ ] Uncompleted item
      # Second Section
      Some text
    MARKDOWN

    desired_output = "- [ ] Uncompleted item"
    assert_equal desired_output, shell_output("cat example.md | #{bin}/mdq '- [ ]'").strip
  end
end
