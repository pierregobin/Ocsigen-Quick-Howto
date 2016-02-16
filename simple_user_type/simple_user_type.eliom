[%%shared
    open Eliom_lib
    open Eliom_content
    open Html5.D
]

module Simple_user_type_app =
  Eliom_registration.App (
    struct
      let application_name = "simple_user_type"
    end)

let to_string s = s
let of_string s = s

let main_service =
  Eliom_service.App.service 
  ~path:["user"] 
  ~get_params:Eliom_parameter.(user_type 
  	~to_string:to_string
	~of_string:of_string
	"name")
	()

let () =
  Simple_user_type_app.register
    ~service:main_service
    (fun s () ->
      Lwt.return
        (Eliom_tools.F.html
           ~title:"simple_user_type"
           ~css:[["css";"simple_user_type.css"]]
           Html5.F.(body [
             h2 [pcdata ("simple user type = " ^ s)];
           ])))
