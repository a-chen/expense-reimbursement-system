package com.revature.middle;

import com.revature.beans.Status;
import com.revature.beans.Type;
import com.revature.data.DatabaseAccessImplementation;

import java.util.List;

/**
 * Created by achen on 12/12/2016.
 */
public class StatusService {

    List<Status> getStatuses() {
        return new DatabaseAccessImplementation().getStatuses();
    }
}
