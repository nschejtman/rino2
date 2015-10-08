package controllers;

import models.Player;
import play.data.Form;
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


}
