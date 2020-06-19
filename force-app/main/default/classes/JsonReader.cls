/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 19/06/2020
 * @description (if required)
 */

public class JsonReader {

    private Object theData;
    private static final Pattern JSON_SEARCH_PATH_PATTERN = Pattern.compile('(\\[\\d+\\])|([\\w]+)');

    public JsonReader(String jsonString) {
        theData = JSON.deserializeUntyped(jsonString);
    }

    public Object read(String jsonPath) {
        return read(new RegexFindIterator(JSON_SEARCH_PATH_PATTERN, jsonPath), theData);
    }

    private Object read(RegexFindIterator jsonPathIterator, Object thisData) {
        Object nextData = ((Map<String, Object>)thisData).get(jsonPathIterator.next());

        if(nextData != null && jsonPathIterator.hasNext()) {
            return read(jsonPathIterator, nextData);
        } else {
            return nextData;
        }
    }

    private class RegexFindIterator implements Iterator<String> {

        private Matcher matcher;
        private Boolean hasNext;

        public RegexFindIterator(Pattern pattern, String searchString) {
            matcher = pattern.matcher(searchString);
            hasNext = matcher.find();
        }

        public Boolean hasNext() {
            return hasNext;
        }

        public String next() {
            String result = matcher.group();
            hasNext = matcher.find();
            return result;
        }
    }
}