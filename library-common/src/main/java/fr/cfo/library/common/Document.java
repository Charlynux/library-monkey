package fr.cfo.library.common;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Date;

/**
 * Represents a document from the library.
 */
@Data
@AllArgsConstructor
public class Document {

    /**
     * Title of the document
     */
    private String title;

    /**
     * Date to restore the document
     */
    private Date returnDate;

}
