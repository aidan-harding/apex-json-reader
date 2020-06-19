/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 19/06/2020
 * @description (if required)
 */

public class JsonReader {

    private Object theData;
    private static final Pattern jsonPathSearchPattern = Pattern.compile('(\\[\\d+\\])|([\\w]+)');

    public JsonReader(String jsonString) {
        theData = JSON.deserializeUntyped(jsonString);
    }

    public Object read(String jsonPath) {
        return read(new RegexFindIterator(jsonPathSearchPattern, jsonPath), theData);
    }

    private Object read(RegexFindIterator jsonPathIterator, Object thisData) {
        Object nextData = ((Map<String, Object>)thisData).get(jsonPath[0]);
        jsonPath.remove(0);

        if(jsonPath.isEmpty()) {
            return nextData;
        } else {
            return read(jsonPath, nextData);
        }
    }

    private class RegexFindIterator implements Iterator<String> {

        private Matcher matcher;
        private Boolean hasNext;

        public RegexFindIterator(Pattern pattern, String searchString) {
            matcher = pattern.matcher(searchString);
            hasNext = matcher.find();
        }

        private Boolean hasNext() {
            return hasNext;
        }

        private String next() {
            String result = matcher.group();
            hasNext = matcher.find();
            return result;
        }
    }
}