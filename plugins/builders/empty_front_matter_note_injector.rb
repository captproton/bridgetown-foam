# frozen_string_literal: true

class EmptyFrontMatterNoteInjector < SiteBuilder
  def build
    hook :site, :after_init do |site|
      Dir.glob(site.collections["notes"].relative_directory + "/**/*.md").each do |filename|
        raw_note_content = File.read(filename)
        raw_note_content.prepend(EMPTY_FRONT_MATTER) unless raw_note_content.start_with?("---")
        File.write(filename, raw_note_content)
      end
    end
  end

  def empty_template
    @empty_template ||= <<~BTRB
      ---
      ---

    BTRB
  end
end
