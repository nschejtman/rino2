package controllers;

import play.mvc.Controller;
import play.mvc.Result;

public class Admin extends Controller {

    public Result index(){
        return ok(views.html.admin.index.render());
    }

    public Result categories(){
        return ok(views.html.admin.categories.render());
    }

    public Result tournaments(){
        return ok(views.html.admin.tournaments.render());
    }

    public Result teams(){
        return ok(views.html.admin.teams.render());
    }

    public Result players(){
        return ok(views.html.admin.players.render());
    }

    public Result cups(){
        return ok(views.html.admin.cups.render());
    }
}
