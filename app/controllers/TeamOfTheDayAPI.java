package controllers;

import com.avaje.ebean.Ebean;
import com.avaje.ebean.Query;
import models.media.TeamOfTheDay;
import play.data.Form;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;

public class TeamOfTheDayAPI extends Controller {

    public Result get() {
        final String queryString = "order by DATE desc limit 1";
        final Query<TeamOfTheDay> queryObj = Ebean.createQuery(TeamOfTheDay.class, queryString);
        final TeamOfTheDay teamOfTheDay = queryObj.findUnique();
        return ok(Json.toJson(teamOfTheDay));
    }

    public Result post() {
        final Form<TeamOfTheDay> form = Form.form(TeamOfTheDay.class).bindFromRequest();
        if (form.hasErrors()) {
            return badRequest(form.errorsAsJson());
        } else {
            final TeamOfTheDay teamOfTheDay = form.get();
            teamOfTheDay.save();
            return ok(Json.toJson(teamOfTheDay));
        }
    }


}
