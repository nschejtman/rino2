package controllers;

import com.avaje.ebean.Ebean;
import models.tournament.Category;
import play.data.Form;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;

import java.util.List;

public class CategoryAPI extends Controller {
    public Result post() {
        final Form<Category> form = Form.form(Category.class).bindFromRequest();
        if (form.hasErrors()) return badRequest();
        else {
            form.get().save();
            return ok();
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
        else{
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

    public Result list(){
        return ok(Json.toJson(Ebean.find(Category.class).findList()));
    }
    
}
