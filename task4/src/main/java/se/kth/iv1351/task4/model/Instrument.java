package se.kth.iv1351.task4.model;

/**
 * This class represents an instrument.
 * It contains all the information related to an instrument.
 * 
 * @author Zia
 */
public class Instrument implements InstrumentDTO {
    private final int instrumentID;
    private final String instrumentType;
    private final String instrumentBrand;
    private final double instrumentPrice;
    private boolean isAvailable;

    /**
     * Creates a new instance of the instrument.
     *
     * @param instrumentID    the id of the instrument.
     * @param instrumentType  the type of the instrument.
     * @param instrumentBrand the brand of the instrument.
     * @param instrumentPrice the price of the instrument.
     * @param isAvailable     the availability of the instrument.
     */
    public Instrument(int instrumentID, String instrumentType, String instrumentBrand, double instrumentPrice,
            boolean isAvailable) {
        this.instrumentID = instrumentID;
        this.instrumentType = instrumentType;
        this.instrumentBrand = instrumentBrand;
        this.instrumentPrice = instrumentPrice;
        this.isAvailable = isAvailable;
    }

    /**
     * Gets the id of the instrument.
     *
     * @return the id of the instrument.
     */
    @Override
    public int getInstrumentID() {
        return instrumentID;
    }

    /**
     * Gets the type of the instrument.
     *
     * @return the type of the instrument.
     */
    @Override
    public String getInstrumentType() {
        return instrumentType;
    }

    /**
     * Gets the brand of the instrument.
     *
     * @return the brand of the instrument.
     */
    @Override
    public String getInstrumentBrand() {
        return instrumentBrand;
    }

    /**
     * Gets the price of the instrument.
     *
     * @return the price of the instrument.
     */
    @Override
    public double getInstrumentPrice() {
        return instrumentPrice;
    }

    /**
     * Gets the availability of the instrument.
     *
     * @return the availability of the instrument.
     */
    @Override
    public boolean getIsAvailable() {
        return isAvailable;
    }

    /**
     * Updates the availability of the instrument.
     */
    public void setIsAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }

    /**
     * Returns a string representation of the instrument.
     */
    @Override
    public String toString() {
        return "ID: " + instrumentID + ", type: " + instrumentType + ", brand: " + instrumentBrand + ", price: "
                + instrumentPrice + ", Available For Rent: " + isAvailable;
    }

}
