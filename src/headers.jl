function xml_headers!(headers::AbstractDict)
    headers["Accept"] = "application/xml"
    headers["Content-Type"] = "application/xml"
    return headers
end

function authentication_headers!(headers::AbstractDict, client::Client)::Nothing
    auth = get_auth(client)
    authentication_headers!(headers, auth)
    return nothing
end

function authentication_headers!(headers::AbstractDict, auth::AnonymousAuth)::Nothing
    return nothing
end

function authentication_headers!(headers::AbstractDict, oauth2::OAuth2)::Nothing
    headers["Authorization"] = "Bearer $(get_token(oauth2))"
    return nothing
end

function authentication_headers!(headers::AbstractDict, jwt_auth::JWTAuth)::Nothing
    headers["Authorization"] = "Bearer $(get_token(jwt_auth))"
    return nothing
end


function authentication_headers!(headers::AbstractDict, password_auth::UsernamePassAuth)::Nothing
    headers["Authorization"] = "Basic $(Base64.base64encode(string(get_username(password_auth), ':', get_password(password_auth))))"
    return nothing
end
