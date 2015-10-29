package controllers;

import play.mvc.Controller;
import play.mvc.Result;
import views.html.admin.*;

public class Admin extends Controller {

    public Result index() {
        return ok(index.render());
    }

    public Result players() {
        return ok(players.render());
    }

    public Result categories() {
        return ok(categories.render());
    }

    public Result tournaments() {
        return ok(tournaments.render());
    }

    public Result teams() {
        return ok(teams.render());
    }
}
