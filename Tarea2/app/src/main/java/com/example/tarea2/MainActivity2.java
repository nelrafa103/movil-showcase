package com.example.tarea2;

import android.content.Intent;
import android.os.Bundle;

import com.example.tarea2.ui.slideshow.SlideshowFragment;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.tabs.TabLayout;

import androidx.cardview.widget.CardView;
import androidx.viewpager.widget.ViewPager;
import androidx.appcompat.app.AppCompatActivity;

import android.view.View;
import android.widget.Button;
import android.widget.ListView;

import com.example.tarea2.ui.main.SectionsPagerAdapter;
import com.example.tarea2.databinding.ActivityMain2Binding;

import java.util.ArrayList;

public class MainActivity2 extends AppCompatActivity {

    private ActivityMain2Binding binding;
    public ArrayList<Componente> componentes = new ArrayList<Componente>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {


        super.onCreate(savedInstanceState);

        binding = ActivityMain2Binding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        SectionsPagerAdapter sectionsPagerAdapter = new SectionsPagerAdapter(this, getSupportFragmentManager());
        //  ViewPager viewPager = binding.viewPager;
        // viewPager.setAdapter(sectionsPagerAdapter);
        TabLayout tabs = binding.tabs;
        //   tabs.setupWithViewPager(viewPager);
         Caja adaptador = new Caja(this, componentes);


        ListView listView = (ListView) findViewById(R.id.lista);
        listView.setAdapter(adaptador);


        int i = 0;

        while (i < 5) {
            System.out.println("Aqui ");
            Componente nuevo = new Componente("Inserte algo por aqui");
            adaptador.add(nuevo);
            i++;
        }


        FloatingActionButton button = (FloatingActionButton) findViewById(R.id.fab);

        button.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                Componente nuevo = new Componente("Inserte algo por aqui");
                adaptador.add(nuevo);
            }
        });



        Button boton = (Button) findViewById(R.id.boton_ahi);
        boton.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                Intent act2 = new Intent(MainActivity2.this,Third_Activity.class);
                startActivity(act2);

            }
        });






    }

 public void borrar(View v) {
        CardView tal = (CardView) v.getParent().getParent();
        tal.setVisibility(View.GONE);
 }
}