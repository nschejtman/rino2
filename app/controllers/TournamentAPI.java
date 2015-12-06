package controllers;

import com.avaje.ebean.Ebean;
import models.tournament.Tournament;
import play.data.Form;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;

public class TournamentAPI extends Controller {
    public Result list(String active) {
        if (active == null) {
            return ok(Json.toJson(Ebean.find(Tournament.class).findList()));
        } else {
            return ok(Json.toJson(Ebean.find(Tournament.class).where().eq("active", active.equals("true")).findList()));
        }
    }

    public Result post() {
        final Form<Tournament> form = Form.form(Tournament.class).bindFromRequest();
        if (form.hasErrors()) return badRequest();
        else {
            final Tournament tournament = form.get();
            tournament.save();
            return ok(Json.toJson(tournament));
        }
    }

    public Result get(Long id) {
        final Tournament tournament = Ebean.find(Tournament.class, id);
        if (tournament == null) {
            return notFound();
        } else {
            return ok(Json.toJson(tournament));
        }
    }

    public Result delete(Long id) {
        final Tournament tournament = Ebean.find(Tournament.class, id);
        if (tournament == null) return notFound();
        else {
            tournament.delete();
            return ok();
        }
    }

    public Result put(Long id) {
        final Form<Tournament> form = Form.form(Tournament.class).bindFromRequest();
        if (form.hasErrors()) return badRequest();
        else {
            final Tournament tournament = form.get();
            tournament.setId(id);
            tournament.update();
            return ok();
        }
    }
}
