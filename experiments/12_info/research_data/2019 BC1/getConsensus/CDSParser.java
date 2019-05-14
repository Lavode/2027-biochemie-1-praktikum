package getConsensus;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

public class CDSParser {

	private List<Integer> cds = new ArrayList<Integer>();
	private int nExons;
	private int cdsLength;

	public List<Integer> parseCDS (String cdsString) throws ParseException{
		String[] exonsStrs = cdsString.split(" ");
		nExons = exonsStrs.length;
		parseExons(exonsStrs);
		cdsLength = cds.size();
		return cds;
	}
	
	private void parseExons(String[] exonsStrs) throws ParseException{
		for(String exonStr : exonsStrs){
			String[] startStop = exonStr.split("-");
			int start = Integer.parseInt(startStop[0]);
			int stop = Integer.parseInt(startStop[1]);
			if(start >= stop){
				throw new ParseException("Error: the start of an interval is greater or equal to its stop", 0);
			}
			fillInterval(start, stop);
		}
	}
	
	private void fillInterval(int start, int stop) throws ParseException{
		for(int i = start; i <= stop; i ++){
			if(cds.contains(i)){
				throw new ParseException("Error: two exons are overlapping!", 0);
			}
			cds.add(i);
		}
	}
	
	public int getNExons(){
		return nExons;
	}
	
	public int getCDSlength(){
		return cdsLength;
	}

}
