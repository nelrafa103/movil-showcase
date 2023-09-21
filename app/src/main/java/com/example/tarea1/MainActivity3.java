package com.example.tarea1;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;

import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

import java.util.ArrayList;

public class MainActivity3 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main3);

        Intent intent = getIntent();
        TextView nombre_component = findViewById(R.id.nombre1);
        TextView apellido_comonent = findViewById(R.id.apellido2);
        TextView fecha_component = (TextView) findViewById(R.id.fecha1);
        TextView genero_component = (TextView) findViewById(R.id.genero1);
        TextView gustos_component = (TextView) findViewById(R.id.gusto1);
        TextView lenguajes_component = (TextView) findViewById(R.id.lenguajes);




        String nombre = intent.getStringExtra("nombre");
        String apellido = intent.getStringExtra("apellido");
        String fecha = intent.getStringExtra("fecha");
        String genero = intent.getStringExtra("genero");
        String gustos = intent.getStringExtra("gustos");
        ArrayList<String> lenguajes = intent.getStringArrayListExtra("lenguajes");

        String lenguajes_string = "";

        for(String item: lenguajes) {
            Log.d("Aqui esta:", item);
            lenguajes_string += (item + ", ");
        }


        nombre_component.setText(nombre);
        apellido_comonent.setText(apellido);
        fecha_component.setText(fecha);
        gustos_component.setText(gustos);
        genero_component.setText(genero);
        lenguajes_component.setText(lenguajes_string);



    }
}