package fr.cfo.library.lomme;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.ProtocolVersion;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.entity.StringEntity;
import org.apache.http.message.BasicHttpResponse;
import org.apache.http.message.BasicStatusLine;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Paths;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.*;

@RunWith(MockitoJUnitRunner.class)
public class UrlProviderTest {

    /**
     * Url where the catalog url could be find
     */
    private static final String CMS_URL = "http://www.ville-lomme.fr/cms/odysseemediatheque";

    /**
     * Class under test
     */
    private UrlProvider urlProvider;

    @Mock
    private HttpClient httpClient;

    @Before
    public void setUp() {
        urlProvider = new UrlProvider(httpClient);
    }

    @Test
    public void should_return_url_from_cms_page() throws Exception {
        when(httpClient.execute(any(HttpGet.class))).thenReturn(responseFromFile("odyssee-mediatheque"));

        urlProvider.findUrl();

        assertThat(urlProvider.getUrl()).isEqualTo("http://195.132.121.21/");
    }

    @Test
    public void should_let_default_url_when_site_return_blank_page() throws Exception {
        when(httpClient.execute(any(HttpGet.class))).thenReturn(responseWith("<hmtl></html>"));

        urlProvider.findUrl();

        assertThat(urlProvider.getUrl()).isEqualTo("");
    }

    private HttpResponse responseFromFile(String bodyFileName) throws IOException {
        final String responseBody = new String(Files.readAllBytes(Paths.get(String.format("src/test/resources/pages/%s.html", bodyFileName))));
        return responseWith(responseBody);
    }

    private HttpResponse responseWith(String responseBody) throws UnsupportedEncodingException {
        int statusCode = HttpStatus.SC_OK;
        HttpResponse response = new BasicHttpResponse(new BasicStatusLine(
                new ProtocolVersion("HTTP", 1, 1), statusCode, ""));
        response.setStatusCode(statusCode);
        response.setEntity(new StringEntity(responseBody));
        return response;
    }
}