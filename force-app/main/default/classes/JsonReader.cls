/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 19/06/2020
 * @description (if required)
 */

public class JsonReader {

    private Object theData;
    private Object missingKeyResult = null;

    private static final Pattern JSON_SEARCH_PATH_PATTERN = Pattern.compile('(\\[\\d+\\])|([\\w]+)');

    public JsonReader(String jsonString) {
        theData = JSON.deserializeUntyped(jsonString);
    }

    public Object read(String jsonPath) {
        return read(new RegexFindIterator(JSON_SEARCH_PATH_PATTERN, jsonPath), theData);
    }

    private Object read(RegexFindIterator jsonPathIterator, Object thisData) {
        String thisKey = jsonPathIterator.next();

        Object nextData;
        if(thisKey.contains('[')) {
            List<Object> dataAsList = (List<Object>)thisData;
            Integer index = Integer.valueOf(thisKey.substring(1, thisKey.length()-1));
            if(index < dataAsList.size()) {
                nextData = dataAsList[index];
            } else {
                nextData = missingKeyResult;
            }
        } else {
            Map<String, Object> dataAsMap = (Map<String, Object>)thisData;
            if(dataAsMap.containsKey(thisKey)) {
                nextData = ((Map<String, Object>)thisData).get(thisKey);
            } else {
                nextData = missingKeyResult;
            }
        }

        if(nextData != null && nextData != missingKeyResult && jsonPathIterator.hasNext()) {
            return read(jsonPathIterator, nextData);
        } else {
            return nextData;
        }
    }
}