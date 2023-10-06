package com.example.tarea3;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.room.Database;
import androidx.room.Room;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import androidx.room.RoomDatabase;
import androidx.sqlite.db.SupportSQLiteDatabase;

import com.example.tarea3.entities.Task;


@Database(entities = {Task.class}, version = 1, exportSchema = false)
    public abstract class TaskRoomDb extends RoomDatabase {

        public abstract RoomDao taskDao();

        private static volatile TaskRoomDb INSTANCE;
        private static final int NUMBER_OF_THREADS = 4;
        static final ExecutorService databaseWriteExecutor =
                Executors.newFixedThreadPool(NUMBER_OF_THREADS);

        static TaskRoomDb getDatabase(final Context context) {
            if (INSTANCE == null) {
                synchronized (Room.class) {
                    if (INSTANCE == null) {
                        INSTANCE = Room.databaseBuilder(context.getApplicationContext(),
                                        TaskRoomDb.class, "db")
                                .addCallback(sRoomDatabaseCallback)
                                .build();
                    }
                }
            }
            return INSTANCE;
        }



        private static RoomDatabase.Callback sRoomDatabaseCallback = new RoomDatabase.Callback() {
            @Override
            public void onCreate(@NonNull SupportSQLiteDatabase db) {
                super.onCreate(db);

                databaseWriteExecutor.execute(() -> {

                    RoomDao dao = INSTANCE.taskDao();
                    dao.deleteAll();

                    Task task = new Task("Hacer compras en el super");
                    dao.insert(task);
                    task = new Task("Ir a recoger a los niños");
                    dao.insert(task);
                });
            }
        };
    }


