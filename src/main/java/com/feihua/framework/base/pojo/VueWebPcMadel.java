package com.feihua.framework.base.pojo;

import java.util.List;

/**
 * Created by yangwei
 * Created at 2019/4/4 13:38
 */
public class VueWebPcMadel {
    /**
     * java 属性
     */
    List<String> properties;
    /**
     * 模型名
     */
    private String modelName = "";
    /**
     *
     */
    private String crudUrl = "";
    /**
     * 模块简单注释，用来提示成功或失败
     */
    private String moduleSimpleComment = "";


    public List<String> getProperties() {
        return properties;
    }

    public void setProperties(List<String> properties) {
        this.properties = properties;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getCrudUrl() {
        return crudUrl;
    }

    public void setCrudUrl(String crudUrl) {
        this.crudUrl = crudUrl;
    }

    public String getModuleSimpleComment() {
        return moduleSimpleComment;
    }

    public void setModuleSimpleComment(String moduleSimpleComment) {
        this.moduleSimpleComment = moduleSimpleComment;
    }
}
