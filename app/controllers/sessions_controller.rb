class SessionsController < ApplicationController
	def new
		# rendert view/sessions/new.html.erb
	end

	def create
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to bookmarks_path,
			notice: "Sie haben sich angemeldet"
		else
			flash.now.alert = "Fehlerhafte E-Mail-Adresse oder Passwort"
			render action: "new" # Wird view/sessions/new.html.erb aufgerufen
		end
	end


	def destroy
		session[:user_id] = nil
		redirect_to bookmarks_path,
		notice: "Sie haben Sich ausgeloggt."
	end

end
