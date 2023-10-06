package com.example.tarea3;

import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.lifecycle.ViewModelProvider;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;

import com.example.tarea3.entities.Task;

import java.util.List;

public class MainActivity3 extends AppCompatActivity {


    private ViewModel viewmodel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main3);

        viewmodel = new ViewModelProvider(this).get(ViewModel.class);

        Button button = findViewById(R.id.button3);

    }
}