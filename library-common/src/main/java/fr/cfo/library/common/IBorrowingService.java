package fr.cfo.library.common;

import java.util.Date;
import java.util.List;

/**
 * Define a service allowing access to borrowed documents.
 * <p/>
 * This kind of service suppose to have credentials, that's why user and password are arguments for each method.
 */
public interface IBorrowingService {

    /**
     * Renew all documents the user have borrowed.
     *
     * @param user
     * @param password
     */
    void renewAllDocuments(final String user, final String password);

    /**
     * List all documents the user have borrowed.
     *
     * @param user
     * @param password
     * @return
     */
    List<Document> listAllDocuments(final String user, final String password);
}
