package fr.cfo.library.lomme;

import org.apache.commons.codec.Charsets;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.io.InputStream;

/**
 * Service able to determine url of catalog
 */
@Component
final class UrlProvider implements IUrlProvider {

    private String url = "";

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
    @PostConstruct
    protected void findUrl() {
        try {
            HttpResponse response = httpClient.execute(new HttpGet("http://www.ville-lomme.fr/cms/odysseemediatheque"));
            if (response.getStatusLine().getStatusCode() == 200) {
                InputStream content = response.getEntity().getContent();

                Document document = Jsoup.parse(content, Charsets.ISO_8859_1.name(), "");

                final Elements elements = document.getElementsByAttributeValue("title", "Catalogue médiathèque");
                Element first = elements.first();
                if (first != null) {
                    this.url = first.attr("href");
                }
            }
        } catch (IOException e) {
            // TODO : Add log - Look at @Sl4j from Lombok
        }
    }
}
