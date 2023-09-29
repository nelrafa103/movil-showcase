package com.example.tarea2;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import org.jetbrains.annotations.NotNull;

import java.util.List;

public class RecyclerAdapter extends RecyclerView.Adapter<RecyclerAdapter.StudenViewHolder> {

    private final List<String> cosas;

    public RecyclerAdapter(List<String> cosas) {
        this.cosas = cosas;
    }

    @NonNull
    @NotNull
    @Override
    public StudenViewHolder onCreateViewHolder(@NonNull @NotNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.componente, parent, false);

        return new RecyclerAdapter.StudenViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull @NotNull StudenViewHolder holder, int position) {
        String cosa = cosas.get(position);

        holder.content.setText(cosa);

    }

    @Override
    public int getItemCount() {
        return cosas.size();
    }



    public void add(String input) {
      cosas.add(input);
    }


    public static class StudenViewHolder extends RecyclerView.ViewHolder {

        TextView content;


        public StudenViewHolder(@NonNull @NotNull View itemView) {
            super(itemView);

            content = itemView.findViewById(R.id.texto);
        }
    }

}
