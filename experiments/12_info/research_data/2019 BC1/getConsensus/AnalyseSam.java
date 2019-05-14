package getConsensus;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.List;



public class AnalyseSam {

	public static void main(String[] args) throws IOException, ParseException {

		String chromosome = "chr9";
		String strand = "+";
		String cdsLocation = "130835445-130835523 130854064-130854237 130854801-130855096 130862763-130863035 130872129-130872213 130872860-130873037 130874868-130875052 130878415-130878567 130880068-130880157 130880500-130880664 130883969-130885683";


		

		String samPath = "reads.sam";
		
// 0) objects initialization
		
		CDSParser cdsParser = new CDSParser();
		OperateSam operateSam = new OperateSam(samPath);
		String consensus;
				
// 1) reading gene locus information

		List<Integer> cds = cdsParser.parseCDS(cdsLocation);
		operateSam.setCDSinfo(cds, chromosome);
		
// 2) get consensus sequence from SAM file
		
		consensus = operateSam.getCDSconsensus();
					
// 3) compute reverse complement if negative strand

		if(strand.equals("-")){
			consensus = getReverseComplement(consensus);
		}
		
// 4) write consensus to file
		
		PrintWriter writer = null;
		writer = new PrintWriter("sequence.txt");
		writer.write(consensus);
		writer.close();
	}
	
	
	
	public static String getReverseComplement(String sequence){
		String reverseComplement = "";
		for(int p=sequence.length()-1; p>=0; p--){
			switch(sequence.charAt(p)){
			case 'A': reverseComplement += 'T';
				break;
			case 'T': reverseComplement += 'A';
				break;
			case 'C': reverseComplement += 'G';
				break;
			case 'G': reverseComplement += 'C';
				break;
			case 'N': reverseComplement += 'N';
				break;
			}
		}
		return reverseComplement;
	}

}
