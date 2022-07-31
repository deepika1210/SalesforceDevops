/**
 * @description       : 
 * @author            : deepika.ghose@10xgenomics.com
 * @group             : 
 * @last modified on  : 08-01-2022
 * @last modified by  : deepika.ghose@10xgenomics.com
**/
public with sharing class Calculator { 
    public integer add(Integer a,Integer b)
    { 
        return a+b; 
    }
    public integer subtract(Integer a,Integer b)
    {
        return a-b;
    }
    public integer mul(Integer a,Integer b)
    {
        return a*b;
    }
}
