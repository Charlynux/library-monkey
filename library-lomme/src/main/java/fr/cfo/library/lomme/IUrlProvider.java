package fr.cfo.library.lomme;

/**
 * Lomme's library website is only defined by an IP address.
 * <p/>
 * This IP could change, this component must be able to find the new IP.
 */
public interface IUrlProvider {

    /**
     * Provide the current url to access library website.
     *
     * @return
     */
    String getUrl();

}
