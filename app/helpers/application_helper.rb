module ApplicationHelper
    def avatar_for(user)
        @avatar = user.avatar
        if @avatar.nil?
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
        else
            if !@avatar.url
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
            else
                cl_image_path @avatar, width: 150, height: 150, crop: :thumb, gravity: :face
            end
        end
    end
end
