package controllers;

import com.avaje.ebean.Ebean;
import models.match.Match;
import models.tournament.MatchDay;
import play.data.Form;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;

import java.util.List;

public class MatchDaysAPI extends Controller {

    public Result get(Long tid, Integer n) {
        final MatchDay matchday = Ebean.find(MatchDay.class).where().eq("tournament_id", tid).eq("number", n).findUnique();
        if (matchday == null) return badRequest();
        else return ok(Json.toJson(matchday));
    }

    public Result list(Long tid) {
        final List<MatchDay> matchdays = Ebean.find(MatchDay.class).where().eq("tournament_id", tid).findList();
        if (matchdays == null || matchdays.isEmpty()) return badRequest();
        else return ok(Json.toJson(matchdays));
    }

    public Result post() {
        return ok();
    }

    public Result putMatch(Long tid, Integer n) {
        final Form<Match> form = Form.form(Match.class).bindFromRequest();
        final MatchDay matchday = Ebean.find(MatchDay.class).where().eq("tournament_id", tid).eq("number", n).findUnique();
        if (form.hasErrors()) return badRequest(form.errorsAsJson());
        else {
            final Match match = form.get();
            matchday.getMatchList().add(match);
            matchday.update();
            match.save();
            return ok(Json.toJson(match));
        }
    }

    public Result getMatches(Long tid, Integer n) {
        final MatchDay matchday = Ebean.find(MatchDay.class)
                .select("matchList")
                .where()
                .eq("tournament_id", tid)
                .eq("number", n)
                .findUnique();
        return ok(Json.toJson(matchday.getMatchList()));
    }
}
