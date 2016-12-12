package com.revature.middle;

import com.revature.beans.Type;
import com.revature.data.DatabaseAccessImplementation;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by achen on 12/12/2016.
 */
class TypeService {

    List<Type> getTypes() {
        return new DatabaseAccessImplementation().getTypes();
    }
}
