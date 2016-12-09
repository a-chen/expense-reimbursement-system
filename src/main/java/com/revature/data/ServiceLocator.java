package com.revature.data;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * /**
 * Lookup and cache services. Reduces performance
 * overhead of looking up services.
 *
 * Created by achen on 12/2/2016.
 */
class ServiceLocator {
    private static DataSource ers;
    private static Properties env; //environment properties

    static {
        InputStream stream = ServiceLocator.class.getClassLoader().getResourceAsStream(
                "jndi.properties");
        env = new Properties();
        try {
            env.load(stream);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    synchronized static DataSource getERSDatabase() {
        if (ers == null) {
            ers = lookupERS();
        }
        return ers;
    }

    private static DataSource lookupERS() {
        try {
            Context ctxt = new InitialContext(env);
            DataSource ds = (DataSource) ctxt.lookup(env.getProperty("ersdb"));
            return ds;
        } catch (NamingException e) {
            e.printStackTrace();
            return null; //datasource could not be found
        }

    }
}
