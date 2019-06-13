package com.feihua.framework.base.generator;

/**
 * Created by yangwei
 * Created at 2019/6/6 10:59
 */
public class Utils {

    public static String cutEndPo(String  str){
        if (str.endsWith("Po")){
            return str.substring(0,str.length() - 2);
        }
        return str;
    }
}
