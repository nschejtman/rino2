package controllers;

import com.avaje.ebean.Ebean;
import models.match.Match;
import models.tournament.MatchDay;
import models.tournament.Tournament;
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

    public Result post(Long tid) {
        final Tournament tournament = Ebean.find(Tournament.class, tid);
        if (tournament == null) return notFound();
        final Form<MatchDay> form = Form.form(MatchDay.class).bindFromRequest();
        if (form.hasErrors()){
            return badRequest(form.errorsAsJson());
        } else {
            final MatchDay matchDay = form.get();
            tournament.getMatchDays().add(matchDay);
            tournament.update();
            matchDay.save();
            return ok(Json.toJson(matchDay));
        }
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

    public Result delete(Long tid, Integer n){
        try {
            final MatchDay matchday = Ebean.find(MatchDay.class).where().eq("tournament_id", tid).eq("number", n).findUnique();
            if (matchday == null) return badRequest();
            else{
                final List<Match> matchList = matchday.getMatchList();
                if (matchList != null) {
                    for (Match match : matchList){
                        match.delete();
                    }
                }
                matchday.delete();
                return ok();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return badRequest(e.getMessage());
        }
    }
}
