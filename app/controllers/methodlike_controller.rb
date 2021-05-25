class MethodlikeController < ApplicationController
    def create
        @methodlike = MethodLike.new(user_id: current_user.id, methodpost_id: params[:methodpost_id])
        @methodlike.save
        redirect_to("/methodposts")
    end
    
    def destroy
        @methodlike = MethodLike.find_by(user_id: current_user.id, methodpost_id: params[:methodpost_id])
        @methodlike.destroy
        redirect_to("/methodposts")
    end
end
