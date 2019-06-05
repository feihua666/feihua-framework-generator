package com.feihua.framework.base.generator;

import feihua.jdbc.api.pojo.BasePo;
import org.apache.commons.lang3.StringUtils;
import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.dom.xml.Attribute;
import org.mybatis.generator.api.dom.xml.TextElement;
import org.mybatis.generator.api.dom.xml.XmlElement;
import org.mybatis.generator.codegen.mybatis3.ListUtilities;
import org.mybatis.generator.codegen.mybatis3.MyBatis3FormattingUtilities;
import org.mybatis.generator.codegen.mybatis3.xmlmapper.elements.AbstractXmlElementGenerator;
import org.mybatis.generator.config.PropertyRegistry;
import org.mybatis.generator.internal.util.StringUtility;

/**
 * 查询全部方法
 * Created by yangwei
 * Created at 2017/8/25 9:11
 */
public class SearchDsfElementGenerator extends
        AbstractXmlElementGenerator {

    public static String selectAllStatementId = "search#{param}s";

    public SearchDsfElementGenerator() {
        super();
    }
    public void addElements(XmlElement parentElement) {
        XmlElement answer = new XmlElement("select");
        selectAllStatementId = selectAllStatementId.replace("#{param}",getIntrospectedTable().getTableConfiguration().getDomainObjectName().replace("Po",""));

        answer.addAttribute(new Attribute(
                "id", selectAllStatementId));
        String resultMap = introspectedTable.getBaseResultMapId();
        if(introspectedTable.hasBLOBColumns()){
            resultMap = introspectedTable.getResultMapWithBLOBsId();
        }

        answer.addAttribute(new Attribute("resultMap",resultMap));

        context.getCommentGenerator().addComment(answer);

        StringBuilder sb = new StringBuilder();
        sb.append("select ");
        answer.addElement(new TextElement(sb.toString()));
        answer.addElement(getBaseColumnListElement());
        if (introspectedTable.hasBLOBColumns()) {
            answer.addElement(new TextElement(","));
            answer.addElement(getBlobColumnListElement());
        }

        sb.setLength(0);
        sb.append("from ");
        sb.append(introspectedTable
                .getAliasedFullyQualifiedTableNameAtRuntime());
        answer.addElement(new TextElement(sb.toString()));

        sb.setLength(0);
        sb.append(" where del_flag = ").append("'").append(BasePo.YesNo.N.name()).append("'");
        answer.addElement(new TextElement(sb.toString()));

        for (IntrospectedColumn introspectedColumn : ListUtilities.removeGeneratedAlwaysColumns(introspectedTable
                .getNonPrimaryKeyColumns())) {
            XmlElement isNotNullElement = new XmlElement("if"); //$NON-NLS-1$
            sb.setLength(0);
            sb.append(introspectedColumn.getJavaProperty());
            sb.append(" != null");
            sb.append(" and ");
            sb.append(introspectedColumn.getJavaProperty());
            sb.append(" != ''");
            isNotNullElement.addAttribute(new Attribute("test", sb.toString())); //$NON-NLS-1$


            sb.setLength(0);
            sb.append("and ");
            sb.append(MyBatis3FormattingUtilities
                    .getEscapedColumnName(introspectedColumn));
            sb.append(" = "); //$NON-NLS-1$
            sb.append(MyBatis3FormattingUtilities
                    .getParameterClause(introspectedColumn));

            isNotNullElement.addElement(new TextElement(sb.toString()));
            answer.addElement(isNotNullElement);
        }


        String orderByClause = introspectedTable.getTableConfigurationProperty(PropertyRegistry.TABLE_SELECT_ALL_ORDER_BY_CLAUSE);
        boolean hasOrderBy = StringUtility.stringHasValue(orderByClause);
        if (hasOrderBy) {
            sb.setLength(0);
            sb.append("order by "); //$NON-NLS-1$
            sb.append(orderByClause);
            answer.addElement(new TextElement(sb.toString()));
        }

        parentElement.addElement(answer);
    }
}
