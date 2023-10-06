package com.example.tarea3;

import android.app.Application;

import androidx.lifecycle.LiveData;

import com.example.tarea3.entities.Task;

import java.util.List;

public class TaskRepo {

    private RoomDao roomDao;
    private LiveData<List<Task>> tasks;

    TaskRepo(Application application) {
        TaskRoomDb db = TaskRoomDb.getDatabase(application);
        roomDao = db.taskDao();
        tasks = roomDao.getAlphabetizedTask();
    }

    LiveData<List<Task>> getAllTasks() {
        return tasks;
    }


    void insert(Task task) {
        TaskRoomDb.databaseWriteExecutor.execute(() -> {
            roomDao.insert(task);
        });
    }

    void update(Task task) {
        TaskRoomDb.databaseWriteExecutor.execute(() -> {
            roomDao.update(task);
        });
    }

    void delete(Task task) {
        TaskRoomDb.databaseWriteExecutor.execute(() -> {
            roomDao.delete(task);
        });
    }
}
