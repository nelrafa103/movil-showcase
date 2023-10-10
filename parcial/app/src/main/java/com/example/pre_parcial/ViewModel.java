package com.example.pre_parcial;

import android.app.Application;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;

import com.example.pre_parcial.models.Product;

import java.util.List;

public class ViewModel extends AndroidViewModel {


    private final LiveData<List<Product>> products;

    public ViewModel(@NonNull Application application, LiveData<List<Product>> products) {
        super(application);
        this.products = products;
    }


    public LiveData<List<Product>> getProducts() {
        return products;
    }

    public void insert(Product product) {
        products.getValue().add(product);
        //
    }
}
