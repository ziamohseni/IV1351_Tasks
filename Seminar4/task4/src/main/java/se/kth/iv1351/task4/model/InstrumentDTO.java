package se.kth.iv1351.task4.model;

/**
 *
 * @author Zia
 */
public interface InstrumentDTO {

  /**
   * @return the instrumentId
   */
  public int getInstrumentID();

  /**
   * @return the instrumentType
   */
  public String getInstrumentType();

  /**
   * @return the instrumentBrand
   */
  public String getInstrumentBrand();

  /**
   * @return the instrumentPrice
   */
  public double getInstrumentPrice();

  /**
   * @return the isAvailable
   */
  public boolean getIsAvailable();

}
