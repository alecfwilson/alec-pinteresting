class Views::Users::Show < Views::Base
	needs :user

	def content
		h1('Welcome')
		p(:class => 'test') {
		  text('Welcome')
		}
	end
end
