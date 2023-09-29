package com.example.tarea2;

import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.res.Configuration;
import android.os.Bundle;
import android.view.View;

import com.example.tarea2.databinding.ActivityThirdBinding;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.ArrayList;
import java.util.List;

public class Third_Activity extends AppCompatActivity {

    ActivityThirdBinding binding;


    private final List<String> cosas = new ArrayList<>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        cosas.add("Texto por aqui");

        binding = ActivityThirdBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        RecyclerView recyclerView = binding.recycler;

        int spanCount = 2;

        if (this.getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE) {
            spanCount = 4;
        }

        recyclerView.setHasFixedSize(true);
        //recyclerView.setLayoutManager(new LinearLayoutManager(getApplicationContext()));
        recyclerView.setLayoutManager(new GridLayoutManager(getApplicationContext(), spanCount));

        RecyclerAdapter adapter = new RecyclerAdapter(cosas);
        recyclerView.setAdapter(adapter);

        FloatingActionButton button = (FloatingActionButton) findViewById(R.id.fab);

        button.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                 String template = "Inserte algo por aqui";
                adapter.add(template);
                adapter.notifyDataSetChanged();
            }
        });




    }

    public void borrar(View v) {
        CardView tal = (CardView) v.getParent().getParent();
        tal.setVisibility(View.GONE);
    }


}