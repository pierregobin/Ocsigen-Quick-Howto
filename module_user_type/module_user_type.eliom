[%%shared
    open Eliom_lib
    open Eliom_content
    open Html5.D
]

module Module_user_type_app =
  Eliom_registration.App (
    struct
      let application_name = "module_user_type"
    end)

module Profile = struct
	let to_string s = s
	let of_string s = s
end

let main_service =
  Eliom_service.App.service 
  ~path:["user"] 
  ~get_params:Eliom_parameter.(
  	user_type 
	~of_string:Profile.of_string
	~to_string:Profile.to_string
	"name") ()

let () =
  Module_user_type_app.register
    ~service:main_service
    (fun s () ->
      Lwt.return
        (Eliom_tools.F.html
           ~title:"module_user_type"
           ~css:[["css";"module_user_type.css"]]
           Html5.F.(body [
             h2 [pcdata ("module user type : " ^ Profile.of_string s)];
           ])))
