package snippet;

public class Snippet {
	char* pResponseParser;
	pResponseParser = response;
	pResponseParser += 15; //move pointer to first data
	
	char lenStr[5];
	strncpy(lenStr, pResponseParser, 5);
	lenStr[4] = '\0';
	int dataLength = atoi(lenStr);
	
	pResponseParser += 5; //move to first object
	
	//loop length of data
	int objectCount = 0;
	while (objectCount < (dataLength / DATA_OBJECT_LENGTH)) {
		int ramOffset;
	
		char particle[12];
		char attractor[17];
	
		char *px;
		char *py;
		char *pg;
	
		char x[5];
		char y[5];
		char g[5];
		switch (*pResponseParser) {
	
		case 'P':
			strncpy(particle, pResponseParser, 12);
			particle[11] = '\0';
	
			px = &particle[2];
			strncpy(x, px, 5);
			x[4] = '\0';
	
			py = &particle[7];
			strncpy(y, py, 5);
			y[4] = '\0';
	
			ramOffset = numParticles * PARTICLE_SIZE;
			ram[ramOffset] = atoi(x);
			ram[ramOffset + 1] = atoi(y);
			ram[ramOffset + 2] = 0;
			ram[ramOffset + 3] = 0;
	
			numParticles += 1;
	
			break;
		case 'A':
			strncpy(attractor, pResponseParser, 17);
			attractor[16] = '\0';
	
			px = &attractor[2];
			strncpy(x, px, 5);
			x[4] = '\0';
	
			py = &attractor[7];
			strncpy(y, py, 5);
			y[4] = '\0';
	
			pg = &attractor[12];
			strncpy(g, pg, 5);
			g[4] = '\0';
	
			ramOffset = PARTICLE_END + numAttractors * ATTRACTOR_SIZE;
			ram[ramOffset + 1] = atoi(x);
			ram[ramOffset + 2] = atoi(y);
			ram[ramOffset + 3] = atof(g);
	
			numAttractors += 1;
	
			break;
		}
		objectCount += 1;
		pResponseParser += 22;
	
	}
}

