[%%shared
    open Eliom_lib
    open Eliom_content
    open Html5.D
]

module Table_app =
  Eliom_registration.App (
    struct
      let application_name = "table"
    end)

let main_service =
  Eliom_service.App.service ~path:[] ~get_params:Eliom_parameter.unit ()

let definition_list_example () =
  Html5.D.dl [dt [pcdata "Banana"]; 
  		dd [pcdata "fruit"];dd [ pcdata "jaune"];
	      dt [pcdata "Pomme"];
	        dd [pcdata "verte"]; dd [pcdata "jaune"]; dd [pcdata "rouge"]
		]
let my_table () =
  table ~caption:(caption[pcdata "100%"])
  [
  	tr [ td[pcdata "1"]; td[pcdata "2"]; td[pcdata "3"]];
  	tr [ td[pcdata "a"]; td[pcdata "b"]; td[pcdata "c"]];
  ]

let () =
  Table_app.register
    ~service:main_service
    (fun () () ->
      Lwt.return
        (Eliom_tools.F.html
           ~title:"table"
           ~css:[["css";"table.css"]]
           Html5.F.(body [
             h2 [pcdata "Welcome from Eliom's distillery!"];
	     definition_list_example();
	     my_table();
	     my_table();
	     my_table();
           ])))
