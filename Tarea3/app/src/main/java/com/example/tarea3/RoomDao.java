package com.example.tarea3;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import androidx.room.Update;

import com.example.tarea3.entities.Task;

import java.util.List;


@Dao
public interface RoomDao {


        @Insert(onConflict = OnConflictStrategy.IGNORE)
        void insert(Task task);

        @Query("DELETE FROM task_table")
        void deleteAll();

        @Query("SELECT * FROM task_table ORDER BY content ASC")
        LiveData<List<Task>> getAlphabetizedTask();


        @Update(onConflict = OnConflictStrategy.IGNORE)
        void update(Task task);


        @Delete
        void delete(Task task);
}
