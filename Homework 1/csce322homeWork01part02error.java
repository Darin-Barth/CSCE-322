import java.io.IOException;
import org.antlr.v4.runtime.*;

class csce322homeWork01part02error extends BaseErrorListener{
    @Override
	public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line,
				int position, String msg, RecognitionException e) {
	System.err.println( msg );

	// replace with code to process syntax errors
	String sentence=offendingSymbol.toString();
	String[] token=sentence.split("'",3);
	System.out.println( "DANGER: Line "+line+" contains the symbol "+token[1]+"." );
	
	System.exit(0);
    }	
}
