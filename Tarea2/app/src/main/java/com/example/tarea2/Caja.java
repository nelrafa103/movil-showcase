package com.example.tarea2;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;

import androidx.annotation.NonNull;

import com.example.tarea2.Componente;
import com.example.tarea2.R;
import com.google.android.material.textfield.TextInputEditText;

import java.util.ArrayList;

public class Caja extends ArrayAdapter<Componente> {


    public Caja(@NonNull Context context, ArrayList<Componente> componentes) {
        super(context,0, componentes);
    }

    @Override
    public View getView(int posicion, View view, ViewGroup parent) {
        Componente componente = getItem(posicion);
        if (view == null) {
            // Inflar la vista de fila si no existe una vista reutilizable
            view = View.inflate(getContext(), R.layout.componente, null);
        }
        TextInputEditText input = view.findViewById(R.id.texto);
        input.setText(componente.getContenido());
        return view;
    }

}
