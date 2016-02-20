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

let unordered_list () =
  ul [
  	li [pcdata "Lorem ipsum dolor sit amet"];
	li [pcdata "Consectetur adipiscing elit"];
	li [pcdata "Integer molestie lorem at massa"];
	li [pcdata "Facilisis in pretium nisl aliquet"];
	li [pcdata "Nulla volutpat aliquam velit "; 
	    ul [
		li [pcdata "Phasellus iaculis neque"];
		li [pcdata "Purus sodales ultricies"];
		li [pcdata "Vestibulum laoreet porttitor sem"];
		li [pcdata "Ac tristique libero volutpat at"];
		];
	   ];
	li [pcdata "Faucibus porta lacus fringilla vel"];
	li [pcdata "Aenean sit amet erat nunc"];
	li [pcdata "Eget porttitor lorem"];
  ]

let ordered_list () =
  ol [
  	li [pcdata "Lorem ipsum dolor sit amet"];
	li [pcdata "Consectetur adipiscing elit"];
	li [pcdata "Integer molestie lorem at massa"];
	li [pcdata "Facilisis in pretium nisl aliquet"];
	li [pcdata "Nulla volutpat aliquam velit ";
	    ol [li [pcdata "Phasellus iaculis neque"];
		li [pcdata "Purus sodales ultricies"];
		li [pcdata "Vestibulum laoreet porttitor sem"];
		li [pcdata "Ac tristique libero volutpat at"]; ];
           ];	
	li [pcdata "Faucibus porta lacus fringilla vel"];
	li [pcdata "Aenean sit amet erat nunc"];
	li [pcdata "Eget porttitor lorem"];
  ]
let definition_list_example () =
  dl [dt [pcdata "Banana"]; 
  	dd [pcdata "fruit";] ;
	dd [ pcdata "jaune"];
      dt [pcdata "Pomme"];
        dd [pcdata "verte"]; 
	dd [pcdata "jaune"]; 
	dd [pcdata "rouge"]
	]

let my_table s () =
  table 
  ~caption:(caption[pcdata ("caption: " ^ s)])  
  ~a:(Html5.D.[a_class ["table " ^s]]) 
~thead:	(thead [ 
  	  tr [th[pcdata "#"]; th [pcdata "period"]; th [pcdata "time"]];
	 ] )
 [ 
	tr [ td[pcdata "1"]; td[pcdata "2"]; td[pcdata "3"]];
  	tr [ td[pcdata "a"]; td[pcdata "b"]; td[pcdata "c"]];
	 ] 

let css_uri =
    Xml.uri_of_string
    "http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"

let js_query =
    Xml.uri_of_string
    "https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"

let bootstrap =
    Xml.uri_of_string
    "https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"

let () =
  Table_app.register
    ~service:main_service
    (fun () () ->
      Lwt.return
      (html
        (head (title (pcdata "Ocsigen with bootsrap and jsquery"))
           [css_link ~uri:css_uri (); js_script ~uri:js_query (); js_script ~uri:bootstrap ()])
        (body [
             h1 [pcdata "Heading h1"];
             h2 [pcdata "Heading h2"];
             h3 [pcdata "Heading h3"];
             h4 [pcdata "Heading h4"];
             h5 [pcdata "Heading h5"];
	     definition_list_example();
	     h1 [pcdata "unordered list"];
	     unordered_list();
	     h1 [pcdata "ordered list"];
	     ordered_list();

	     my_table "table-bordered" ();
	     my_table "table-condensed" ();
	     my_table "table-striped" ();
           ])))
