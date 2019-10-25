package ${functions.packageName('model')};
<#if functions.properties('jsonFormat')=='true'>
import com.alibaba.fastjson.annotation.JSONField;
</#if>
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
<#if functions.properties('tableField')=='true'>
import com.baomidou.mybatisplus.annotation.TableField;
</#if>
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;



import lombok.Data;
import lombok.ToString;
import lombok.experimental.Accessors;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
<#list fields as f>
<#if f.type.simpleName == "BigDecimal">
import java.math.BigDecimal;
    <#break/>
</#if>
</#list>
import java.util.Date;
/**
 * <p>
 * ${tableComment!''}
 * </p>
 *
 * @author ${author}
 * @since ${datetime}
 */
@Data
@ToString
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = true)
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
     * ${f.comment!''}
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
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
        </#if>
    </#if>
     <#if functions.properties('jsonProperty')=='true'>
        <#if f.columnName?contains("_")>
    @JsonProperty(value = "${f.name}")
        </#if>
     </#if>
    <#if funs.prop('tableField')=='true' && f.columnName?contains("_")>
    @TableField("${f.columnName}")
    </#if>
    private ${f.type.simpleName} ${f.name};
    </#list>

    /**
     * 默认构造方法
     */
    public ${tpl.filePrefix}${name}${tpl.fileSuffix}(){}

    <#if funs.prop("getter") == 'true'>
    public ${idType.simpleName} get${idName?cap_first}() {
        return ${idName?lower_case};
    }
    </#if>
    <#if funs.prop("setter") == 'true'>
    public ${tpl.filePrefix}${name}${tpl.fileSuffix} set${idName?cap_first}(${idType.simpleName} ${idName?lower_case}){
        this.${idName?lower_case} = ${idName?lower_case};return this;
    }
    </#if>

    <#if funs.prop("getter") == 'true' || funs.prop("setter") == 'true'>
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
    </#if>


    @Override
    protected Serializable pkVal() {
        return this.${idName?lower_case};
    }

    <#if funs.prop("toString") == 'true'>
    @Override
    public String toString() {
        return "${tpl.filePrefix}${name}${tpl.fileSuffix}{" +
        "${idName?lower_case}=" + ${idName?lower_case} +
        <#list fields as f>
            ", ${f.name}=" + ${f.name} +
        </#list>
        "}";
    }
    </#if>

}
