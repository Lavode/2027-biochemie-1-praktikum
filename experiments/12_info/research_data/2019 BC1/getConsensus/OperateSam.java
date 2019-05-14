package getConsensus;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

public class OperateSam {

	private final char [] letters = {'A', 'T', 'C', 'G'};
	private List<Integer> cds;
	private String chromosome;
	private Path samFile;
	int[][] pileup;
	
	public OperateSam(String samPath) throws FileNotFoundException{
		if(new File(samPath).isFile()){
			samFile = Paths.get(samPath);
		}
		else{
			System.out.println(Paths.get(samPath));
			throw new FileNotFoundException("the sam file could not be found, please check its location");
		}
	}
	
	public String getCDSconsensus () throws IOException{
		for (String line : Files.readAllLines(samFile, Charset.defaultCharset())){
			Read read = new Read(line);
			if(!read.isValid()){
				continue;
			}
			if(read.getChrom().equals(chromosome)){
				pileup = read.fillList(cds, pileup);
			}
		}
		return getConsensusFromPileup();
	}
	
	public String getConsensusFromPileup(){
		String consensus = "";
		for(int k=0; k<cds.size(); k++){
			if(pileup[k][4]>0){
				int max = 0;
				int posMax = 0;
				for(int j=0; j<4; j++){
					if(pileup[k][j]>max){
						posMax = j;
						max = pileup[k][j];
					}
				}
				consensus+=letters[posMax];
			}
			else{
				consensus+='N';
			}
		}
		return consensus;
	}
	
	public void setCDSinfo(List<Integer> newCDS, String newChrom){
		cds = newCDS;
		chromosome = newChrom;
		pileup = new int[cds.size()][5];
	}
	
}
