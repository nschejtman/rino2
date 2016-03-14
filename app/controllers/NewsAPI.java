package controllers;

import com.avaje.ebean.Ebean;
import models.media.NewsPiece;
import play.mvc.Controller;
import play.data.Form;
import play.libs.Json;
import play.mvc.Result;

import java.util.Collections;
import java.util.List;

public class NewsAPI extends Controller{
    public Result post() {
        final Form<NewsPiece> form = Form.form(NewsPiece.class).bindFromRequest();
        if (form.hasErrors()) return badRequest(form.errorsAsJson());
        else {
            final NewsPiece newsPiece = form.get();
            newsPiece.save();
            return ok(Json.toJson(newsPiece));
        }
    }

    public Result get(Long id) {
        final NewsPiece newsPiece = Ebean.find(NewsPiece.class, id);
        if (newsPiece == null) {
            return notFound();
        } else {
            return ok(Json.toJson(newsPiece));
        }
    }

    public Result delete(Long id) {
        final NewsPiece newsPiece = Ebean.find(NewsPiece.class, id);
        if (newsPiece == null) return notFound();
        else{
            newsPiece.delete();
            return ok();
        }
    }

    public Result put(Long id) {
        final Form<NewsPiece> form = Form.form(NewsPiece.class).bindFromRequest();
        if (form.hasErrors()) return badRequest();
        else {
            final NewsPiece newsPiece = form.get();
            newsPiece.setId(id);
            newsPiece.update();
            return ok();
        }
    }

    public Result list(){
        final List<NewsPiece> list = Ebean.find(NewsPiece.class).findList();
        Collections.sort(list);
        return ok(Json.toJson(list));
    }
}
