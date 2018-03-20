/**
 * 
 */
package edu.buffalo.cse.jive.tracer.model;

/**
 * @author Shashank Raghunath
 * @email  sraghuna@buffalo.edu
 *
 */
public class TraceModel {
	private Object objectReference;
	private String fieldName;
	private Object fieldValue;

	public Object getObjectReference() {
		return objectReference;
	}

	public void setObjectReference(Object objectReference) {
		this.objectReference = objectReference;
	}

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public Object getFieldValue() {
		return fieldValue;
	}

	public void setFieldValue(Object fieldValue) {
		this.fieldValue = fieldValue;
	}

}
