package com.example.tarea3.entities;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;

@Entity(tableName = "task_table")
public class Task {
    @PrimaryKey(autoGenerate = true)
    private int id;
    @NonNull
    private String content;


    @NonNull
    private boolean checked;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Task(@NonNull String content) {this.content = content;}



    public static List<Task> getTask() {
        ArrayList<Task> tasks = new ArrayList<>();
        tasks.add(new Task("Freddy"));
        tasks.add(new Task("Genesis" ));
        tasks.add(new Task("Samara"));
        tasks.add(new Task("Freddy"));
        tasks.add(new Task("Genesis" ));
        tasks.add(new Task("Samara"));
        tasks.add(new Task("Freddy"));
        tasks.add(new Task("Genesis"));
        tasks.add(new Task("Samara"));
        tasks.add(new Task("Freddy"));
        tasks.add(new Task("Genesis"));
        tasks.add(new Task("Samara"));

        return tasks;
    }

    @NonNull
    public String getContent() {
        return content;
    }

    @NonNull
    public boolean getChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public void setContent(@NonNull String content) {
        this.content = content;
    }
}
