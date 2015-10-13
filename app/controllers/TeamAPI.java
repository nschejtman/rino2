package controllers;

import com.avaje.ebean.Ebean;
import models.Team;
import play.data.Form;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;

public class TeamAPI extends Controller {
    public Result post() {
        final Form<Team> form = Form.form(Team.class).bindFromRequest();
        if (form.hasErrors()) return badRequest();
        else {
            form.get().save();
            return ok();
        }
    }

    public Result get(Long id) {
        final Team team = Ebean.find(Team.class, id);
        if (team == null) {
            return notFound();
        } else {
            return ok(Json.toJson(team));
        }
    }

    public Result delete(Long id) {
        final Team team = Ebean.find(Team.class, id);
        if (team == null) return notFound();
        else{
            team.delete();
            return ok();
        }
    }

    public Result put(Long id) {
        final Form<Team> form = Form.form(Team.class).bindFromRequest();
        if (form.hasErrors()) return badRequest();
        else {
            final Team team = form.get();
            team.setId(id);
            team.update();
            return ok();
        }
    }
    
}
