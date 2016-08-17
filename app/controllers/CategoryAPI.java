package controllers;

import com.avaje.ebean.Ebean;
import models.match.Match;
import models.tournament.Category;
import models.tournament.MatchDay;
import models.tournament.Tournament;
import play.data.Form;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;

public class CategoryAPI extends Controller {
    public Result post() {
        final Form<Category> form = Form.form(Category.class).bindFromRequest();

        if (form.hasErrors()) {
            return badRequest(form.errorsAsJson());
        } else {
            final Category category = form.get();
            category.save();
            return ok(Json.toJson(category));
        }
    }

    public Result get(Long id) {
        final Category category = Ebean.find(Category.class, id);
        if (category == null) {
            return notFound();
        } else {
            return ok(Json.toJson(category));
        }
    }

    public Result delete(Long id) {
        final Category category = Ebean.find(Category.class, id);
        if (category == null) return notFound();
        else {
            for (Tournament tournament : category.getTournaments()) {
                for (MatchDay matchDay : tournament.getMatchDays()) {
                    for (Match match : matchDay.getMatchList()) {
                        match.delete();
                    }
                    matchDay.delete();
                }
                tournament.delete();
            }
            category.delete();
            return ok();
        }
    }

    public Result put(Long id) {
        final Form<Category> form = Form.form(Category.class).bindFromRequest();
        if (form.hasErrors()) return badRequest();
        else {
            final Category category = form.get();
            category.setId(id);
            category.update();
            return ok();
        }
    }

    public Result list() {
        return ok(Json.toJson(Ebean.find(Category.class).findList()));
    }

}
