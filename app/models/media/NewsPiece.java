package models.media;


import com.avaje.ebean.Model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class NewsPiece extends Model {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    Long id;
}