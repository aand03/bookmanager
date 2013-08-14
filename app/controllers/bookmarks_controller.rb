class BookmarksController < ApplicationController
	before_filter :require_login!

	def index
		@bookmarks = current_user.bookmarks.all
	end

	def show
		@bookmark = current_user.bookmarks.find(params[:id])
	end

	def new
		@bookmark = current_user.bookmarks.new
	end

	def edit
		@bookmark = current_user.bookmarks.find(params[:id])
	end

	def create
		@bookmark = current_user.bookmarks.new(bookmark_params)
		current_user.bookmarks << @bookmark

		if @bookmark.save
			redirect_to bookmarks_path,
			notice: "Favorit wurde erfolgreich angelegt."

		else
			render action: "new"
		end
	end 

	def update
		@bookmark = current_user.bookmarks.find(params[:id])
		if @bookmark.update_attributes(bookmark_params)
			redirect_to bookmarks_path,
			notice: "Favorit wurde erfolgreich geändert."

		else
			render action: "edit"
		end
	end

	def destroy
		@bookmark = current_user.bookmarks.find(params[:id])
		@bookmark.destroy
		flash[:notice] = "Favorit wurde erfolgreich gelöscht."
		redirect_to bookmarks_url,
		notice: "Favorit wurde erfolgreich gelöscht."

	end


	private
	def bookmark_params
		params.require(:bookmark).permit("title",
			"url", "comment")
	end

	private
	def require_login!
		unless user_signed_in?
			redirect_to login_path,
			alert: "Bitte melden Sie sich zuerst an."
		end
	end

end
