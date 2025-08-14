package com.myapp.util;

import java.util.List;
import com.myapp.model.UserBean;
import com.myapp.model.RoleBean;

public class JsonUtil {
	public static String toJson(Object obj) {
        if (obj == null) {
            return "null";
        }
        
        if (obj instanceof String) {
            return "\"" + escapeJson((String) obj) + "\"";
        }
        
        if (obj instanceof Number || obj instanceof Boolean) {
            return obj.toString();
        }
        
        if (obj instanceof List) {
            @SuppressWarnings("unchecked")
            List<Object> list = (List<Object>) obj;
            StringBuilder sb = new StringBuilder("[");
            for (int i = 0; i < list.size(); i++) {
                if (i > 0) sb.append(",");
                sb.append(toJson(list.get(i)));
            }
            sb.append("]");
            return sb.toString();
        }
        
        if (obj instanceof UserBean) {
            return userBeanToJson((UserBean) obj);
        }
        
        // For simple objects, create a basic JSON representation
        return "{}";
    }
    
    public static String createJsonResponse(boolean success, String message) {
        return "{\"success\":" + success + ",\"message\":\"" + escapeJson(message) + "\"}";
    }
    
    private static String userBeanToJson(UserBean user) {
        StringBuilder sb = new StringBuilder("{");
        sb.append("\"userId\":").append(user.getUserId()).append(",");
        sb.append("\"username\":\"").append(escapeJson(user.getUsername())).append("\",");
        sb.append("\"fullName\":\"").append(escapeJson(user.getFullName())).append("\",");
        sb.append("\"roleId\":").append(user.getRoleId()).append(",");
        sb.append("\"status\":\"").append(escapeJson(user.getStatus())).append("\",");
        
        if (user.getRole() != null) {
            sb.append("\"role\":{");
            sb.append("\"roleId\":").append(user.getRole().getRoleId()).append(",");
            sb.append("\"roleName\":\"").append(escapeJson(user.getRole().getRoleName())).append("\",");
            sb.append("\"permissions\":\"").append(escapeJson(user.getRole().getPermissions())).append("\"");
            sb.append("},");
        }
        
        // Remove trailing comma if present
        if (sb.charAt(sb.length() - 1) == ',') {
            sb.setLength(sb.length() - 1);
        }
        
        sb.append("}");
        return sb.toString();
    }
    
    public static String roleToJson(RoleBean role) {
        if (role == null) return "null";
        
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"roleId\":").append(role.getRoleId()).append(",");
        json.append("\"roleName\":").append(escapeJson(role.getRoleName())).append(",");
        json.append("\"permissions\":").append(escapeJson(role.getPermissions()));
        json.append("}");
        
        return json.toString();
    }
    
    public static String roleListToJson(List<RoleBean> roles) {
        if (roles == null) return "[]";
        
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < roles.size(); i++) {
            if (i > 0) json.append(",");
            json.append(roleToJson(roles.get(i)));
        }
        json.append("]");
        
        return json.toString();
    }
    
    private static String escapeJson(String str) {
        if (str == null) return "null";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
