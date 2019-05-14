package getConsensus;

import java.util.List;

public class Read {
	
	private boolean header;
	private String chromosome;
	private String sequence;
	private int start;
	private int mapQuality;
	private int length;
	
	public Read(String samLine){
		if(samLine.startsWith("@")){
			header = true;
		}
		else{
			header = false;
			String [] splat = samLine.split("\t");
			start = Integer.parseInt(splat[3]);
			mapQuality = Integer.parseInt(splat[4]);
			sequence = splat[9];
			length = sequence.length();
			chromosome = splat[2];
		}
	}
	
	public boolean isValid(){
		return !header && mapQuality > 200 && length > 20;
	}

	public int[][] fillList(List<Integer> cds, int[][] pileup){
		for(int n = 0; n < length; n++){
			int position = start + n;
			if(cds.contains(position)){
				int index = cds.indexOf(position);
				switch(sequence.charAt(n)){
				case 'A': pileup[index][0]++;
					break;
				case 'T': pileup[index][1]++;
					break;
				case 'C': pileup[index][2]++;
					break;
				case 'G': pileup[index][3]++;
					break;
				}
				pileup[index][4]++;
			}
		}
		return pileup;
	}
	
	public String getChrom(){
		return chromosome;
	}
	
}
