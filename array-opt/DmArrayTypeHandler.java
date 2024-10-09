package com.xxx;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedTypes;

import java.sql.*;

/**
 * dao层自定义类型处理器
 */
@MappedTypes(Object[].class)
public class DmArrayTypeHandler extends BaseTypeHandler<Object[]> {

    /**
     * 自定义类型名
     */
    private static final String TYPE_NAME_CTM = "DM_ARRAY";

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, Object[] parameter, JdbcType jdbcType) throws SQLException {
        Connection conn = ps.getConnection();
        Array array = conn.createArrayOf(TYPE_NAME_CTM, parameter);
        ps.setArray(i, array);
    }

    @Override
    public Object[] getNullableResult(ResultSet rs, String columnName) throws SQLException {
        // TODO
        return new Object[0];
    }

    @Override
    public Object[] getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        // TODO
        return new Object[0];
    }

    @Override
    public Object[] getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        // TODO
        return new Object[0];
    }
}
