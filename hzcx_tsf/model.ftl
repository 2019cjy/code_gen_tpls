package ${functions.packageName('model')};
<#if functions.properties('jsonField')=='true'>
import com.alibaba.fastjson.annotation.JSONField;
</#if>
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
<#if functions.properties('tableField')=='true'>
import com.baomidou.mybatisplus.annotation.TableField;
</#if>
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
<#if functions.properties('jsonFormat')=='true'>
import com.fasterxml.jackson.annotation.JsonFormat;
</#if>

import java.io.Serializable;
import java.util.Date;
/**
 * <p>
 * ${tableComment}
 * </p>
 *
 * @author ${author}
 * @since ${datetime}
 */
@TableName("${tableName}")
public class ${tpl.filePrefix}${name}${tpl.fileSuffix} extends Model<${tpl.filePrefix}${name}${tpl.fileSuffix}> {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    <#if idType.name == 'java.lang.String'>
    @TableId(value = "id", type = IdType.INPUT)
    <#else>
    @TableId(value = "${idName}", type = IdType.AUTO)
    </#if>
    private ${idType.simpleName} ${idName?lower_case};
    <#list fields as f>
    <#if (functions.properties('comment')=='doc')??>
    /**
     * ${f.comment}
     */
    <#else>
    //${f.comment}
    </#if>
    <#if functions.properties('jsonField')=='true'>
        <#if f.columnName?contains("_") && f.type.name = 'java.util.Date'>
    @JSONField(name = "${f.columnName}", format = "yyyy-MM-dd HH:mm:ss")
        </#if>
        <#if f.columnName?contains("_") && f.type.name != 'java.util.Date'>
    @JSONField(name = "${f.columnName}")
        </#if>
    </#if>
    <#if functions.properties('jsonFormat')=='true'>
        <#if f.type.name = 'java.util.Date'>
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
        </#if>
    </#if>
    <#if functions.properties('jsonProperty')=='true'>
        <#if f.columnName?contains("_")>
    @JsonFormat(value = "${f.name}")
        </#if>
    </#if>
    <#if funs.prop('tableField')=='true' && f.columnName?contains("_")>
    @TableField("${f.columnName}")
    </#if>
    private ${f.type.simpleName} ${f.name};
    </#list>

    //默认构造方法
    public ${tpl.filePrefix}${name}${tpl.fileSuffix}(){}


    public ${idType.simpleName} get${idName?cap_first}() {
        return ${idName?lower_case};
    }

    public ${tpl.filePrefix}${name}${tpl.fileSuffix} set${idName?cap_first}(${idType.simpleName} ${idName?lower_case}){
        this.${idName?lower_case} = ${idName?lower_case};return this;
    }

    <#list fields as f>
    <#if funs.prop("getter") == 'true'>
    public ${f.type.simpleName} get${f.name?cap_first}() {
        return ${f.name};
    }
    </#if>

    <#if funs.prop("setter") == 'true'>
    public ${tpl.filePrefix}${name}${tpl.fileSuffix} set${f.name?cap_first}( ${f.type.simpleName} ${f.name}) {
        this.${f.name} = ${f.name};return this;
    }
    </#if>

    </#list>
    @Override
    protected Serializable pkVal() {
        return this.${idName?lower_case};
    }

    @Override
    public String toString() {
        return "${tpl.filePrefix}${name}${tpl.fileSuffix}{" +
        "${idName?lower_case}=" + ${idName?lower_case} +
        <#list fields as f>
        ", ${f.name}=" + ${f.name} +
        </#list>
        "}";
    }
}
