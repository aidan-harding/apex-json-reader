/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 19/06/2020
 * @description (if required)
 */

public class JsonReader {

    private Object theData;

    public JsonReader(String jsonString) {
        theData = JSON.deserializeUntyped(jsonString);
    }

    public Object read(String jsonPath) {
        return read(jsonPath.split('\\.'), theData);
    }

    private Object read(List<String> jsonPath, Object thisData) {
        Object nextData = ((Map<String, Object>)thisData).get(jsonPath[0]);
        jsonPath.remove(0);

        if(jsonPath.isEmpty()) {
            return nextData;
        } else {
            return read(jsonPath, nextData);
        }
    }
}