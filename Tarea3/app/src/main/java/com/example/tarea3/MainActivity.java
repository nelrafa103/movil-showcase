package com.example.tarea3;

import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.lifecycle.ViewModelProvider;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.tarea3.adapters.TaskAdapter;
import com.example.tarea3.databinding.ActivityMainBinding;
import com.example.tarea3.entities.Task;

import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;

import java.util.List;

public class MainActivity extends AppCompatActivity {


    private ActivityMainBinding binding;
    private ViewModel viewmodel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        ActivityMainBinding binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());


        RecyclerView recyclerView = binding.recycler;

        int spanCount = 1;

        if (this.getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
            spanCount = 2;
        }
        recyclerView.setHasFixedSize(true);

        final TaskAdapter adapter = new TaskAdapter(new TaskAdapter.TaskDiff());
        recyclerView.setAdapter(adapter);
        recyclerView.setLayoutManager(new GridLayoutManager(getApplicationContext(), spanCount));


        viewmodel = new ViewModelProvider(this).get(ViewModel.class);


        viewmodel.getAllTasks().observe(this, tasks -> {
            adapter.submitList(tasks);
        });



        Button boton = findViewById(R.id.button);




        boton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                  Intent intent = new Intent(MainActivity.this,MainActivity2.class);
                  startActivity(intent);
            }
        });


    }

    public void funcion(View v) {
        int counter = 0;
        List<Task> tasks =  viewmodel.getAllTasks().getValue();
        for (Task task : tasks) {
            CardView cardView = (CardView) v.getParent().getParent();
            CheckBox check = cardView.findViewById(R.id.checkBox);
            if (task.getContent().equals(check.getText())) {
                viewmodel.delete(task);
                break;
            }
        }
    }

    public void funcion2(View v) {
      CardView cardView = (CardView) v.getParent().getParent();
      CheckBox check = cardView.findViewById(R.id.checkBox);

      if(check.isChecked()) {
          List<Task> tasks =  viewmodel.getAllTasks().getValue();
          for (Task task : tasks) {
              if (task.getContent().equals(check.getText())) {
                  task.setChecked(true);
                  viewmodel.update(task);
                  break;
              }
          }
      }
    }
}