public with sharing class OrderNumber {

    public String value;

    public OrderNumber(Datetime issueDate, Integer sequence) {
        this.value = String.valueOf(issueDate.year()) + (String.valueOf(sequence)).leftPad(8,'0');
    }
}
