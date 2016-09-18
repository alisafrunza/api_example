module ApplicationHelper
	def can_be_refreshed?(login)
		return true if login.next_refresh_possible_at.blank?
		Time.now > login.next_refresh_possible_at
	end
end
