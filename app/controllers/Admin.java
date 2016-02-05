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

    public Result tournamentsTables(){
        return ok(views.html.admin.tournament.tables.render());
    }

    public Result teams(){
        return ok(views.html.admin.teams.render());
    }

    public Result players() {
        return ok(views.html.admin.players.render());
    }

    public Result tournamentsTeams(){
        return ok(views.html.admin.tournament.teams.render());
    }

    public Result teamsPlayers(){
        return ok(views.html.admin.team.players.render());
    }

    public Result tournamentsFixtures(){
        return ok(views.html.admin.tournament.fixtures.render());
    }

    public Result news(){
        return ok(views.html.admin.media.news.render());
    }
}
