(* ************************************************************************** *)
(* Project: Ocsigen Quick Howto : Parameters                                  *)
(* Description: Example of services with user_type                            *)
(* Author: db0 (db0company@gmail.com, http://db0.fr/)                         *)
(* Latest Version is on GitHub: http://goo.gl/sfvvq                           *)
(* ************************************************************************** *)

open Eliom_content
open Html5.D
open Eliom_parameter

(* ************************************************************************** *)
(* Application                                                                *)
(* ************************************************************************** *)

module Example =
  Eliom_registration.App
    (struct
      let application_name = "user_type definition"
     end)

(* ************************************************************************** *)
(* Page Skeletton                                                             *)
(* ************************************************************************** *)

let skeletton body_content =
  let css_uri =
    Xml.uri_of_string
      "http://twitter.github.com/bootstrap/assets/css/bootstrap.css" in
  Lwt.return
    (html
       (head (title (pcdata "Ocsigen Services Example"))
	  [css_link ~uri:css_uri ()])
       (body [div ~a:[a_class ["well"]] body_content]))

(* ************************************************************************** *)
(* Service with your own type                                                 *)
(* ************************************************************************** *)

(* Example of type of your own                                                *)

let of_string s = s
let to_string s = s

(* Service declaration                                                        *)
let my_type_service =
  Eliom_service.App.service
    ~path:["profile"]
    ~get_params:(user_type
		   ~of_string:of_string
		   ~to_string:to_string
		   "toto")
    ()

(* Link to this service                                                       *)
let my_type_service_link =
  a my_type_service [pcdata "Service with your own type"]
    ("Barbara")

(* Service definition                                                         *)
let _ =
  Example.register ~service:my_type_service
    (fun the_profile () ->
      skeletton
	[p [pcdata "I can read in your profile: "];
	 ul
	   [li [pcdata ("Your first name is: " ^ the_profile)];
	   ]])

(*
*)

(* ************************************************************************** *)
(* Services with no parameter at all                                          *)
(* ************************************************************************** *)

(* Service declaration                                                        *)
let main_service =
  Eliom_service.App.service
    ~path:["unit"]
    ~get_params:unit
    ()

(* Link to this service                                                       *)
let main_service_link =
  a main_service [pcdata "Service with no parameter"] ()

(* Service definition                                                         *)
let _ = 
  Example.register ~service:main_service
    (fun () () ->
    print_string "main_service\n";
      skeletton [h4 [pcdata "Welcome to my home page!"];
		 p [pcdata "Try some services on the following list :)"];
		 ul
		   [
                     li [my_type_service_link];
                     li [main_service_link];
		   ]
		])

