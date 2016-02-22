[%%shared
    open Eliom_lib
    open Eliom_content
    open Html5.D
]

module Form_app =
  Eliom_registration.App (
    struct
      let application_name = "form"
    end)

let main_service =
  Eliom_service.App.service ~path:[] ~get_params:Eliom_parameter.unit ()

let () =
  Form_app.register
    ~service:main_service
    (fun () () ->
      Lwt.return
        (Eliom_tools.F.html
           ~title:"form"
           ~css:[["css";"form.css"]]
           Html5.F.(body [
             h2 [pcdata "Welcome from Eliom's distillery!"];
           ])))
