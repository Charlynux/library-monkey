package fr.cfo.library.lomme;

import org.apache.commons.codec.Charsets;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.io.InputStream;

/**
 * Created by charles on 08/04/15.
 */
public class UrlProvider implements IUrlProvider {

    private String url;

    private final HttpClient httpClient;

    public UrlProvider(HttpClient httpClient) {
        this.httpClient = httpClient;
    }

    @Override
    public String getUrl() {
        return url;
    }

    /**
     * Go to CMS site and find the new IP address.
     */
    protected void findUrl() {
        try {
            HttpResponse response = httpClient.execute(new HttpGet("http://www.ville-lomme.fr/cms/odysseemediatheque"));
            if (response.getStatusLine().getStatusCode() == 200) {
                InputStream content = response.getEntity().getContent();

                Document document = Jsoup.parse(content, Charsets.ISO_8859_1.name(), "");

                final Elements elements = document.getElementsByAttributeValue("title", "Catalogue médiathèque");
                Element first = elements.first();

                this.url = first.attr("href");
            }
        } catch (IOException e) {
            // TODO : Add log - Look at @Sl4j from Lombok
        }
    }
}
