require "rubygems"
require "irb/completion"

begin
	require "interactive_editor"
rescue LoadError => err
	warn "Couldn't load interactive_editor: #{err}"
end

begin
	require "awesome_print"
	AwesomePrint.irb!
rescue LoadError => err
	warn "Couldn't load awesome_print: #{err}"
end

IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = File::expand_path("~/.irbhistory")

railsrc_path = File.expand_path("~/.irbrc_rails")
if (ENV["RAILS_ENV"] || defined? Rails) && File.exists?(railsrc_path)
	begin
		load railsrc_path
	rescue Exception
		warn "Could not load: #{railsrc_path} because of #{$!.message}"
	end
end

class Object
	def view_methods
		case self.class
		when Class
			self.public_methods.sort - Object.public_methods
		when Module
			self.public_methods.sort - Module.public_methods
		else
			self.public_methods.sort - Object.new.public_methods
		end
	end
end
