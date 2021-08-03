public with sharing class CPF {


    public virtual class BaseException extends Exception {}
    public class OtherException extends BaseException {}

    private static final Integer FACTOR_DIGIT_1 = 10;
    private static final Integer FACTOR_DIGIT_2 = 11;
    private static final Integer MAX_DIGITS_1 = 9;
    private static final Integer MAX_DIGITS_2 = 10;
    
    public static String value;

    public CPF(String cpf) {
        if(!validate(cpf)) throw new OtherException('Invalid CPF');
        value = cpf;
    }

    private static String extractDigits(String cpf) {
        return cpf.replaceAll('[^0-9]', '');
    }

    private static Boolean isInvalidLength(String cpf) {
        return cpf.length() != 11;
    }

    private static Boolean isRepeatedNumberSequence(String cpf) {
        String[] splitedCPF = cpf.split('');
        String firstDigit = splitedCPF[0];
        Integer i = 1; 
        while(firstDigit == splitedCPF[i] && i < FACTOR_DIGIT_1) i++;
        if(i == FACTOR_DIGIT_1) return true;
        else return false;
    }

    private static Integer calculateDigit(String cpf, Integer factor, Integer max) {
        String[] splitedCPF = cpf.split('');
        Integer total = 0;
        for(Integer i = 0; i < max; i++) {
            total += Integer.valueOf(splitedCPF[i]) * factor--;
        }
        return (math.mod(total,11) < 2) ? 0 : (11 - math.mod(total,11));
    }

    private static String getCheckDigit(String cpf) {
        return cpf.right(2);
    }

    private static Boolean compareCalculatedWithGiven(String cpf, Integer digit1, Integer digit2) {
        System.debug(digit1);
        System.debug(digit2);
        Integer calculatedCheckDigit = 10*digit1+digit2;
        System.debug(calculatedCheckDigit);
        System.debug(getCheckDigit(cpf));
        return calculatedCheckDigit == Integer.valueOf(getCheckDigit(cpf));
    }

    public static Boolean validate(String cpf) {
        cpf = extractDigits(cpf);
        System.debug(cpf);
        if (isInvalidLength(cpf)) {
            return false;
        }    
        if (isRepeatedNumberSequence(cpf)) {
            return false;
        }
        Integer digit1 = calculateDigit(cpf, FACTOR_DIGIT_1, MAX_DIGITS_1);
        Integer digit2 = calculateDigit(cpf, FACTOR_DIGIT_2, MAX_DIGITS_2);
        return compareCalculatedWithGiven(cpf, digit1, digit2);

    }

}