package controllers;

import com.avaje.ebean.Ebean;
import models.team.Player;
import models.team.Team;
import play.data.Form;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;

import javax.persistence.PersistenceException;

public class TeamAPI extends Controller {
    public Result post() {
        final Form<Team> form = Form.form(Team.class).bindFromRequest();
        if (form.hasErrors()) {
            return badRequest(form.errorsAsJson());
        } else {
            final Team team = form.get();
            try {
                team.save();
            } catch (PersistenceException e) {
                return badRequest(Json.toJson(e.getMessage()));
            }
            return ok(Json.toJson(team));
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

    public Result list(){
        return ok(Json.toJson(Ebean.find(Team.class).findList()));
    }

    public Result addPlayer(Long teamId, Long playerId){
        final Player player = Ebean.find(Player.class, playerId);
        final Team team = Ebean.find(Team.class, teamId);
        if (player == null || team == null) return badRequest();
        else {
            team.getPlayers().add(player);
            team.update();
            return ok(Json.toJson(player));
        }
    }

    public Result removePlayer(Long teamId, Long playerId){
        final Player player = Ebean.find(Player.class, playerId);
        final Team team = Ebean.find(Team.class, teamId);
        if (player == null || team == null) return badRequest();
        else if (!team.getPlayers().contains(player)) return badRequest();
        else {
            team.getPlayers().remove(player);
            team.update();
            return ok();
        }
    }
    
}
