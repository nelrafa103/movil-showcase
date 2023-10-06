package com.example.tarea3.adapters;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.DiffUtil;
import androidx.recyclerview.widget.ListAdapter;
import androidx.recyclerview.widget.RecyclerView;

import com.example.tarea3.R;
import com.example.tarea3.entities.Task;

import org.jetbrains.annotations.NotNull;

public class TaskAdapter extends ListAdapter<Task, TaskAdapter.TaskViewHolder> {

    public TaskAdapter(@NonNull DiffUtil.ItemCallback<Task> diffCallback) {
        super(diffCallback);
    }

    @NonNull
    @NotNull
    @Override
    public TaskViewHolder onCreateViewHolder(@NonNull @NotNull ViewGroup parent, int viewType) {
        return TaskViewHolder.create(parent);
    }

    @Override
    public void onBindViewHolder(@NonNull @NotNull TaskViewHolder holder, int position) {
        Task current = getItem(position);
        holder.bind(current.getContent());
    }


    public static class TaskDiff extends DiffUtil.ItemCallback<Task> {

        @Override
        public boolean areItemsTheSame(@NonNull Task oldItem, @NonNull Task newItem) {
            return oldItem == newItem;
        }

        @Override
        public boolean areContentsTheSame(@NonNull Task oldItem, @NonNull Task newItem) {
            return oldItem.getContent().equals(newItem.getContent());
        }
    }

    static class TaskViewHolder extends RecyclerView.ViewHolder {
        private final TextView Item;

        private TaskViewHolder(View itemView) {
            super(itemView);
            Item = itemView.findViewById(R.id.checkBox);
        }

        public void bind(String text) {
            Item.setText(text);
        }

        static  TaskViewHolder create(ViewGroup parent) {
            View view = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.activity_main3, parent, false);
            return new TaskViewHolder(view);
        }

    }
}
