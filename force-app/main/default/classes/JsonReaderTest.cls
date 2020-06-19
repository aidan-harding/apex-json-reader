/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 19/06/2020
 */

@IsTest
private class JsonReaderTest {

    @IsTest
    static void testBehavior() {
        String value = 'b';
        String jsonString = '{"a": "' + value + '"}';

        Test.startTest();
        Object result = new JsonReader(jsonString).read('a');
        Test.stopTest();

        System.assertEquals(value, result);
    }
}