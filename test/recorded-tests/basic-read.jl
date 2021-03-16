@testset "Basic reading" begin
    recordings_directory = joinpath(@__DIR__, "recordings")
    mkpath(recordings_directory)
    BrokenRecord.configure!(; path = recordings_directory)

    anonymous_auth = FHIRClientXML.AnonymousAuth()
    oauth2_auth = FHIRClientXML.OAuth2()
    FHIRClientXML.set_token!(oauth2_auth, "helloworld")
    jwt_auth = FHIRClientXML.JWTAuth()
    FHIRClientXML.set_token!(jwt_auth, "helloworld")
    username_password_auth_1 = FHIRClientXML.UsernamePassAuth("helloworld")
    FHIRClientXML.set_password!(username_password_auth_1, "helloworld")
    username_password_auth_2 = FHIRClientXML.UsernamePassAuth(; username = "helloworld")
    FHIRClientXML.set_password!(username_password_auth_2, "helloworld")
    auths = [
        anonymous_auth,
        oauth2_auth,
        jwt_auth,
        username_password_auth_1,
        username_password_auth_2,
    ]

    for (i, auth) in enumerate(auths)
        base_url = FHIRClientXML.BaseURL("https://hapi.fhir.org/baseR4")
        client = FHIRClientXML.Client(base_url, auth)
        @test FHIRClientXML.get_base_url(client) == base_url
        search_request_path = "/Patient?given=Jason&family=Argonaut"
        response_search_results_bundle = BrokenRecord.playback(() -> FHIRClientXML.request_xml(client, "GET", search_request_path), "recording-$(i)-1.bson")
        patient_id = response_search_results_bundle["Bundle"]["entry"][1]["resource"]["Patient"]["id"][:value]
        patient_request = "/Patient/$(patient_id)"
        patients = [
            BrokenRecord.playback(() -> FHIRClientXML.request_xml(client, "GET", patient_request), "recording-$(i)-2.bson")
            BrokenRecord.playback(() -> FHIRClientXML.request_xml(client, "GET", patient_request; body = Dict()), "recording-$(i)-3.bson")
            BrokenRecord.playback(() -> FHIRClientXML.request_xml(client, "GET", patient_request; query = Dict{String, String}()), "recording-$(i)-4.bson")
            BrokenRecord.playback(() -> FHIRClientXML.request_xml(client, "GET", patient_request; body = Dict(), query = Dict{String, String}()), "recording-$(i)-5.bson")
        ]
        for patient in patients
            patient_resource = patient["Patient"]
            @test patient isa AbstractDict
            @test patient_resource isa AbstractDict
            @test patient_resource["name"]["use"][:value] == "usual"
            @test patient_resource["name"]["text"][:value] == "Jason Argonaut"
            @test patient_resource["name"]["family"][:value] == "Argonaut"
            @test patient_resource["name"]["given"][:value] == "Jason"
            @test patient_resource["birthDate"][:value] == "1985-08-01"
        end
        Base.shred!(auth)
        Base.shred!(client)
    end

    for i in 1:length(auths)
        Base.shred!(auths[i])
    end
end
