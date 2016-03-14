package models.media;


import com.avaje.ebean.Model;
import play.data.validation.Constraints;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.util.Date;

@Entity
public class NewsPiece extends Model implements Comparable<NewsPiece> {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;
    String imgUrl;
    @Constraints.Required(message = "No se puede crear noticia sin fecha")
    Date date;
    @Constraints.Required(message = "No se puede crear noticia sin título")
    String title;
    @Constraints.Required(message = "No se puede crear noticia sin cuerpo")
    String body;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    @Override
    public int compareTo(NewsPiece o) {
        return o.date.compareTo(this.date); // compare in reverse order for descending order
    }
}
