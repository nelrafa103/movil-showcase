package com.example.tarea3;

import android.app.Application;

import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;

import com.example.tarea3.entities.Task;

import java.util.List;

public class ViewModel extends AndroidViewModel {

    private TaskRepo repo;

    private final LiveData<List<Task>> tasks;

    public  ViewModel (Application application) {
        super(application);
        repo = new TaskRepo(application);
        tasks = repo.getAllTasks();
    }

    public LiveData<List<Task>> getAllTasks() { return tasks; }

    public void insert(Task task) { repo.insert(task); }

    public void delete(Task task ) { repo.delete(task);}

    public void update(Task task) {repo.update(task);}
}
