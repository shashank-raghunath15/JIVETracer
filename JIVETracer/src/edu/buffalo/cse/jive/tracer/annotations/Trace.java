/**
 * 
 */
package edu.buffalo.cse.jive.tracer.annotations;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.LOCAL_VARIABLE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

@Documented
@Retention(RUNTIME)
@Target({ FIELD, LOCAL_VARIABLE })
/**
 * @author Shashank Raghunath
 * @email  sraghuna@buffalo.edu
 *
 */
public @interface Trace {

}
