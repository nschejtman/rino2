package controllers;

import com.avaje.ebean.Ebean;
import models.team.Player;
import play.data.Form;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;

public class PlayerAPI extends Controller {
    public Result post() {
        final Form<Player> form = Form.form(Player.class).bindFromRequest();
        if (form.hasErrors()) return badRequest();
        else {
            form.get().save();
            return ok();
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
        else{
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

    public Result list(){
        return ok(Json.toJson(Ebean.find(Player.class).findList()));
    }


}
