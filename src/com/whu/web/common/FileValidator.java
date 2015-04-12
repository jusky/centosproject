package com.whu.web.common;

import java.util.regex.Matcher; 
import java.util.regex.Pattern; 
import javax.servlet.http.HttpServletRequest; 
import org.apache.commons.validator.Field; 
import org.apache.commons.validator.GenericValidator; 
import org.apache.commons.validator.Validator; 
import org.apache.commons.validator.ValidatorAction; 
import org.apache.commons.validator.util.ValidatorUtils; 
import org.apache.struts.action.ActionMessages; 
import org.apache.struts.validator.Resources; 
/** 
* Struts自定义验证类. 
*/ 
public class FileValidator { 
         /** 
          * 判断文件类型 
          */ 
         public static boolean validateFileType(Object bean, ValidatorAction va, 
                            Field field, ActionMessages errors, Validator validator, 
                            HttpServletRequest request) { 
                   String value = ValidatorUtils.getValueAsString(bean, field 
                                     .getProperty()); 
                   String inputType = value.substring(value.lastIndexOf('.')); 
                   String type[] = field.getVarValue("fileTypeProperty").split(";"); 
                   if (!GenericValidator.isBlankOrNull(value)) { 
                            try { 
                                    boolean judge = false; 
                                     for (int i = 0; i < type.length; i++) { 
                                               Pattern p = Pattern.compile(type[i], 
                                                                 Pattern.CASE_INSENSITIVE); 
                                               Matcher m = p.matcher(inputType); 
                                               judge = m.matches(); 
                                               if (judge) { 
                                                        break; 
                                               } 
                                     } 
                                     if (!judge) { 
                                               errors.add(field.getKey(), Resources.getActionMessage( 
                                                                 validator, request, va, field)); 
                                               return false; 
                                     } 
                            } catch (Exception e) { 
                                     errors.add(field.getKey(), Resources.getActionMessage( 
                                                        validator, request, va, field)); 
                                     return false; 
                            } 
                   } 
                   return true; 
         } 
} 
