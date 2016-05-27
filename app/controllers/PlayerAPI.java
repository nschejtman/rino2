package controllers;

import com.avaje.ebean.Ebean;
import com.avaje.ebean.Expr;
import com.avaje.ebean.ExpressionList;
import com.avaje.ebean.Junction;
import models.team.Player;
import models.team.Team;
import play.data.Form;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;

import java.util.List;
import java.util.StringTokenizer;


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

    public Result search() {
        final String searchString = Form.form().bindFromRequest().data().get("searchString");
        final StringTokenizer sT = new StringTokenizer(searchString, " ");

        ExpressionList<Player> conjunction = Ebean.find(Player.class).where().conjunction();
        while (sT.hasMoreTokens()){
            final String token = "%" + sT.nextToken() + "%";
            conjunction = conjunction
                    .disjunction()
                    .add(Expr.ilike("firstName", token))
                    .add(Expr.ilike("lastName", token))
                    .endJunction();
        }
        final List<Player> options = conjunction.findList();

        return ok(Json.toJson(options));
    }


}
