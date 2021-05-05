User.first_or_create do |user|
    user.email = "visualbasic2013@hotmail.com"
    user.password = "thevncore"
    user.password_confirmation = "thevncore"
    user.role = "root"
end