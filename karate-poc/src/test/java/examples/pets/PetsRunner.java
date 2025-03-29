package examples.pets;

import com.intuit.karate.junit5.Karate;

public class PetsRunner {

    @Karate.Test
    Karate searchPet(){
        return Karate.run().tags("@ValidacionTipoDatos").relativeTo(getClass());
    }
}
