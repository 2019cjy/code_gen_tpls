package ${functions.packageName('service')};
import com.baomidou.mybatisplus.service.IService;
import ${functions.packageName('model')}.${name};

public interface ${functions.filePrefix('service')}${name}Service extends IService<${name}> {

    <#if (functions.properties('select_map')=='true')??>
    List<Map<String,Object>> findMaps(Map<String,Object> map);

    Map<String,Object> findMap(Map<String,Object> map);
    </#if>
}
