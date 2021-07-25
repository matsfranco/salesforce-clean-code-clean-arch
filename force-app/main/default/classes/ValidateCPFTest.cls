@isTest
public with sharing class ValidateCPFTest {

    @isTest
    public static void commonCpf() {
        System.assertEquals(false, ValidadeCPF.validate('86446442799'),'Failed to validate a sequence with typing mistake');
    }

    @isTest
    public static void repeatedNumberSequence() {
        System.assertEquals(false,ValidadeCPF.validate('00000000000'),'Failed to validate a repeated number sequence');
    }

    @isTest
    public static void typingMistake() {
        System.assertEquals(false, ValidadeCPF.validate('86446442799'),'Failed to validate a sequence with typing mistake');

    }

    @isTest
    public static void withSeparators() {
        System.assertEquals(true, ValidadeCPF.validate('864.464.227-84'),'Failed to validade a correct sequence with special chars');
    }

    @isTest
    public static void invalidSequence() {
        System.assertEquals(true, ValidadeCPF.validate('91720489726'),'Failed to validade a correct sequence');
    }

    @isTest
    public static void invalidSequenceWithLiterals() {
        System.assertEquals(false, ValidadeCPF.validate('a1720489726'),'Failed to validade a sequence with literal char');
    }

    @isTest
    public static void emptySequence() {
        System.assertEquals(false,ValidadeCPF.validate(''),'Failed to validate a empty sequence');
    }

}
