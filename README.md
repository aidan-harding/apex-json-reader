# JSON Reader

Read values from JSON by specifying simple paths like 'a.b' or 'a.b[2].c'. 

##Examples

Basic usage:

    String jsonString = '{"a": { "a2": "expected"} }';
    
    Object result = new JsonReader(jsonString).read('a.a2');
    
    System.assertEquals('expected', result);

With lists:

    String jsonString = '{"a": { "a2": ["x", ["expected"]] } }';

    Object result = new JsonReader(jsonString).read('a.a2[1][0]');

    System.assertEquals('expected', result);

Specifying behaviour for missing keys:

    String jsonString = '{"a": { "a2": "expected"} }';
    final String NO_RESULT = 'no result';

    Object result = new JsonReader(jsonString)
            .setMissingKeyResult(NO_RESULT)
            .read('a.nope');

    System.assertEquals(NO_RESULT, result);

## License

MIT, see [LICENSE](LICENSE)

