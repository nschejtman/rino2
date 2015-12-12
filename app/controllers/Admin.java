package controllers;

import play.mvc.Controller;
import play.mvc.Result;

public class Admin extends Controller {

    public Result index() {
        return ok(views.html.admin.index.render());
    }

    public Result categories() {
        return ok(views.html.admin.categories.render());
    }

    public Result tournaments() {
        return ok(views.html.admin.tournaments.render());
    }

    public Result tournamentTables(){
        return ok(views.html.admin.tournament.tables.render());
    }

    public Result teams(){
        return ok(views.html.admin.teams.render());
    }

    public Result players() {
        return ok(views.html.admin.players.render());
    }

    public Result tournamentTeams(){
        return ok(views.html.admin.tournament.teams.render());
    }
}
