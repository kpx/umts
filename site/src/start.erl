-module (start).
-compile(export_all).
-include_lib("nitrogen/include/wf.hrl").

-include("umts_db.hrl").
-define(NBR_NEWLY,9).
main() -> #template { file="./templates/bare.html" }.

title() -> "Login".

body() ->
    [#panel{id = newly, body = [
            #container_12{body = 
                [#panel{id = logo,
				          body = [#h1{text = "UMTS"},
					              #p{body = "The ultimate magic trading system"}]
				        },
		
                #link{text="Goto 10 (Index)", url = "index"},
                #grid_8{id = cardbox,
				  alpha=true, 
				  prefix=2, 
				  suffix=2, 
				  omega=true, 
                  body=timestamp()
              }]}]}].
                
timestamp()->
    UserId = wf:user(),
    User = umts_db:get_user(UserId),
    Show = 
    [#flash{},#h2{text="Added cards since last login"},
        [index:card(umts_db:get_card( W#wtts.id )) ||
            W <- umts_db:get_updated_wtts(),
            W#wtts.timestamp > User#users.lastlogin]],
    umts_db:update_lastlogin(UserId, now()),
    Show.


