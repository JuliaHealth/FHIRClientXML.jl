```@meta
CurrentModule = FHIRClientXML
```

# Examples

## Basic example

```@repl
using FHIRClientXML
base_url = FHIRClientXML.BaseURL("https://hapi.fhir.org/baseR4")
auth = FHIRClientXML.AnonymousAuth()
client = FHIRClientXML.Client(base_url, auth)
bundle = FHIRClientXML.request_xml(client, "GET", "/Patient?given=Jason&family=Argonaut")
patients = bundle["Bundle"]["entry"];
patient_id = patients[1]["resource"]["Patient"]["id"][:value]
patient = FHIRClientXML.request_xml(client, "GET", "/Patient/$(patient_id)")
patient["Patient"]["name"]
patient["Patient"]["address"]
```
