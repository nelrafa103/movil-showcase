package com.example.tarea3;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.ViewModelProvider;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;

import com.example.tarea3.entities.Task;
import com.google.android.material.textfield.TextInputEditText;

import java.util.List;

public class MainActivity2 extends AppCompatActivity {


    private ViewModel viewmodel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);


        viewmodel = new ViewModelProvider(this).get(ViewModel.class);


        Button button = findViewById(R.id.button2);

        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                TextInputEditText input = findViewById(R.id.input);
                String texto = String.valueOf(input.getText());
                Task task = new Task(texto);
                viewmodel.insert(task);
            }
        });





    }



}