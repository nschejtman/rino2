package controllers;

import com.avaje.ebean.Ebean;
import com.avaje.ebean.Expr;
import com.avaje.ebean.ExpressionList;
import models.team.Player;
import models.team.Team;
import play.data.Form;
import play.libs.F;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;

import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.stream.Collectors;


public class PlayerAPI extends Controller {
    public Result post() {
        final Form<Player> form = Form.form(Player.class).bindFromRequest();
        if (form.hasErrors()) return badRequest(form.errorsAsJson());
        else {
            final Player player = form.get();
            player.save();
            return ok(Json.toJson(player));
        }
    }

    public Result get(Long id) {
        final Player player = Ebean.find(Player.class, id);
        if (player == null) {
            return notFound();
        } else {
            return ok(Json.toJson(player));
        }
    }

    public Result delete(Long id) {
        final Player player = Ebean.find(Player.class, id);
        if (player == null) return notFound();
        else {
            player.delete();
            return ok();
        }
    }

    public Result put(Long id) {
        final Form<Player> form = Form.form(Player.class).bindFromRequest();
        if (form.hasErrors()) return badRequest();
        else {
            final Player player = form.get();
            player.setId(id);
            player.update();
            return ok();
        }
    }

    public Result list() {
        return ok(Json.toJson(Ebean.find(Player.class).findList()));
    }

    public Result searchWithTeam() {
        //Get data from form
        final Map<String, String> formData = Form.form().bindFromRequest().data();
        final String searchString = formData.get("searchString");
        final Long teamId = Long.parseLong(formData.get("teamId"));

        //Search players
        final List<Player> options = searchPlayers(searchString);

        //Begin magic!
        final List<F.Tuple<Player, List<Team>>> playerTeams = options.stream()

                //attach teams
                .map(player -> new F.Tuple<>(player, teamsOfPlayer(player.getId())))

                //filter those players that already play in the current team
                .filter(tuple -> {
                    boolean playerIsInCurrentTeam = false;
                    for (Team team : tuple._2) {
                        if (team.getId().equals(teamId)) {
                            playerIsInCurrentTeam = true;
                            break;
                        }
                    }
                    return !playerIsInCurrentTeam;
                })

                //collect results
                .collect(Collectors.toList());

        return ok(Json.toJson(playerTeams));
    }

    private List<Player> searchPlayers(String searchString) {
        final StringTokenizer sT = new StringTokenizer(searchString, " ");

        ExpressionList<Player> conjunction = Ebean.find(Player.class).where().conjunction();
        while (sT.hasMoreTokens()) {
            final String token = "%" + sT.nextToken() + "%";
            conjunction = conjunction
                    .disjunction()
                    .add(Expr.ilike("firstName", token))
                    .add(Expr.ilike("lastName", token))
                    .endJunction();
        }
        return conjunction.findList();
    }

    private List<Team> teamsOfPlayer(Long playerId) {
        return Ebean.find(Team.class).where().eq("players.id", playerId).findList();
    }


}
