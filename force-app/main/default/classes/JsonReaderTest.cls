/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 19/06/2020
 */

@IsTest
private class JsonReaderTest {

    @IsTest
    static void singleKey() {
        String value = 'b';
        String jsonString = '{"a": "' + value + '"}';

        Test.startTest();
        Object result = new JsonReader(jsonString).read('a');
        Test.stopTest();

        System.assertEquals(value, result);
    }

    @IsTest
    static void nestedKey() {
        String value = 'b';
        String jsonString = '{"a": { "a2": "' + value + '} }';

        Test.startTest();
        Object result = new JsonReader(jsonString).read('a.a2');
        Test.stopTest();

        System.assertEquals(value, result);
    }
}