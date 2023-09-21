package com.example.tarea1;

import static android.webkit.ConsoleMessage.MessageLevel.LOG;

import androidx.appcompat.app.AppCompatActivity;

import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.TextView;

import com.google.android.material.textfield.TextInputLayout;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    private String megusta = "si";

    private DatePickerDialog dialog;

    private ArrayList<String> lenguajes = new ArrayList<>();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
         Button enviar = (Button) findViewById(R.id.button2);


       Button limpiar = (Button) findViewById(R.id.button);


       limpiar.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {

                EditText nombre_component = (EditText) findViewById(R.id.editTextText);
                EditText apellido_component = (EditText) findViewById(R.id.editTextText3);
                EditText fecha_component = (EditText) findViewById(R.id.editTextDate);

                RadioGroup grupo = (RadioGroup) findViewById(R.id.radioGroup);
                Spinner genero_component = (Spinner) findViewById(R.id.spinner);

                CheckBox c = (CheckBox) findViewById(R.id.checkBox);
                CheckBox cpp = (CheckBox) findViewById(R.id.checkBox2);
                CheckBox java = (CheckBox) findViewById(R.id.checkBox3);
                CheckBox js = (CheckBox) findViewById(R.id.checkBox4);
                CheckBox go = (CheckBox) findViewById(R.id.checkBox5);
                CheckBox python = (CheckBox) findViewById(R.id.checkBox6);


                nombre_component.setText("");
                apellido_component.setText("");
                genero_component.setSelection(0);
                fecha_component.clearAnimation();

                // Checkboxes

                c.setChecked(false);
                python.setChecked(false);
                js.setChecked(false);

                cpp.setChecked(false);
                go.setChecked(false);
                java.setChecked(false);


                grupo.clearCheck();
            }
        });



        enviar.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {

               EditText nombre_component = (EditText) findViewById(R.id.editTextText);
                //RadioGroup megusta = (RadioGroup) findViewById(R.id.radioGroup);


                String nombre = nombre_component.getText().toString();
                EditText apellido_component = (EditText) findViewById(R.id.editTextText3);
                String apellido = apellido_component.getText().toString();

                EditText fecha_component = (EditText) findViewById(R.id.editTextDate);
                String fecha = fecha_component.getText().toString();

                Spinner genero_component = (Spinner) findViewById(R.id.spinner);

                String genero = genero_component.getSelectedItem().toString();


                if(nombre.isEmpty() || genero.isEmpty() || fecha.isEmpty() || apellido.isEmpty() || lenguajes.size() == 0) {

                    int width = 600;
                    int height = 600;

                    PopupWindow pop = new PopupWindow(MainActivity.this);
                    LinearLayout layout = new LinearLayout(MainActivity.this);

                    pop.showAtLocation(findViewById(R.id.layout_princ),Gravity.CENTER,300,300);


                } else {
                    Intent act2 = new Intent(MainActivity.this,MainActivity3.class);
                    act2.putExtra("nombre",nombre);
                    act2.putExtra("fecha",fecha);
                    act2.putExtra("gustos",megusta);
                    act2.putExtra("apellido",apellido);
                    act2.putExtra("genero",genero);
                    act2.putStringArrayListExtra("lenguajes",lenguajes);
                    startActivity(act2);
                }

             //   changeActo(nombre,fecha,apellido,genero);
              ;


            }

        });
    }

    private void changeActo(String nombre,String fecha, String apellido,String genero) {
        Intent act2 = new Intent(this,MainActivity3.class);

    }
    public void onRadioButtonClicked(View view) {
        boolean checker = ((RadioButton) view).isChecked();

        CheckBox c = (CheckBox) findViewById(R.id.checkBox);
        CheckBox cpp = (CheckBox) findViewById(R.id.checkBox2);
        CheckBox java = (CheckBox) findViewById(R.id.checkBox3);
        CheckBox js = (CheckBox) findViewById(R.id.checkBox4);
        CheckBox go = (CheckBox) findViewById(R.id.checkBox5);
        CheckBox python = (CheckBox) findViewById(R.id.checkBox6);

        if(view.getId() == R.id.radioButton5 && checker) {
            megusta = "no me gusta la programacion";

            c.setEnabled(false);
            cpp.setEnabled(false);
            java.setEnabled(false);
            js.setEnabled(false);
            go.setEnabled(false);
            python.setEnabled(false);
        } else if(view.getId() == R.id.radioButton4 && checker){
            megusta = "me gusta la programacion";

            c.setEnabled(true);
            cpp.setEnabled(true);
            java.setEnabled(true);
            js.setEnabled(true);
            go.setEnabled(true);
            python.setEnabled(true);
        }
    }


  public void onCheckButtonClicked(View view) {
      boolean checker = ((CheckBox) view).isChecked();
      String texto = ((CheckBox) view).getText().toString();
      if(checker) {
        lenguajes.add(texto);
        //Log.d("Porqui", texto);
     } else {
          lenguajes.remove(texto);
      }

  }


}