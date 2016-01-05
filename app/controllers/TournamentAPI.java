package controllers;

import com.avaje.ebean.Ebean;
import models.team.Team;
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
        if (form.hasErrors()) {
            return badRequest(form.errorsAsJson());
        }
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

    public Result addTeam(Long tournamentId, Long teamId){
        final Tournament tournament = Ebean.find(Tournament.class, tournamentId);
        final Team team = Ebean.find(Team.class, teamId);
        if (tournament == null || team == null) return badRequest();
        else {
            tournament.getTeams().add(team);
            tournament.update();
            return ok();
        }
    }

    public Result removeTeam(Long tournamentId, Long teamId){
        final Tournament tournament = Ebean.find(Tournament.class, tournamentId);
        final Team team = Ebean.find(Team.class, teamId);
        if (tournament == null || team == null) return badRequest();
        else if (!tournament.getTeams().contains(team)) return badRequest();
        else {
            tournament.getTeams().remove(team);
            tournament.update();
            return ok();
        }
    }

    public Result getTeams(Long tournamentId){
        final Tournament tournament = Ebean.find(Tournament.class, tournamentId);
        if (tournament == null || tournament.getTeams().isEmpty()) {
            return notFound();
        } else {
            return ok(Json.toJson(tournament.getTeams()));
        }
    }
}
