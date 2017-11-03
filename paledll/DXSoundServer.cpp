/*********************************************************************************

	DXSoundServer - Written by Arnaud Carré (aka Leonard / OXYGENE)
	Part of the "Leonard Homepage Articles".
	http://leonard.oxg.free.fr
	Read the complete article on my web page for information:

	PART 2: Using the Direct Sound API.
	How to make a SoundServer under windows, to play various sound.
	WARNING: This sample plays a 44.1Khz, 16bits, mono sound. Should be quite easy to modify ! :-)

	arnaud.carre@freesurf.fr

*********************************************************************************/

#include "DXSoundServer.h"


CDXSoundServer::CDXSoundServer(HWND hWnd)
{
		m_hWnd = hWnd;
		reset();
}

CDXSoundServer::~CDXSoundServer()
{
		close();
}

void	CDXSoundServer::reset(void)
{
		m_pDS = NULL;
		m_pPrimary = NULL;
		m_pBuffer = NULL;
		m_bThreadRunning = false;
		m_bThreadKillRequired = false;
		m_hThread = INVALID_HANDLE_VALUE;
		m_writePos = 0;
}

static	DWORD WINAPI __stdcall threadRout(void *pObject)
{

	CDXSoundServer *pDS = (CDXSoundServer *)pObject;
	if (pDS)
	{
		while ( pDS->update() )
		{
			Sleep(20);
		}
	}
    return 0;
}

bool	CDXSoundServer::open(DXUSER_CALLBACK pUserCallback)
{
		// First, create a DirectSound object (link your app with DSOUND.LIB)
		m_pUserCallback = pUserCallback;
		HRESULT hRes = ::DirectSoundCreate(0, &m_pDS, 0);
		if (hRes == DS_OK)
		{	// Then we have to set a cool cooperative level :-)
			hRes = m_pDS->SetCooperativeLevel(m_hWnd,DSSCL_EXCLUSIVE | DSSCL_PRIORITY);
			if (hRes == DS_OK)
			{	// Create the primary audio buffer.
				DSBUFFERDESC bufferDesc;
				memset(&bufferDesc, 0, sizeof(DSBUFFERDESC));
				bufferDesc.dwSize = sizeof(DSBUFFERDESC);
				bufferDesc.dwFlags = DSBCAPS_PRIMARYBUFFER|DSBCAPS_STICKYFOCUS;
				bufferDesc.dwBufferBytes = 0;
				bufferDesc.lpwfxFormat = NULL;
				hRes = m_pDS->CreateSoundBuffer(&bufferDesc,&m_pPrimary, NULL);
				if (hRes == DS_OK)
				{	// And set its own internal format (44.1Khz, mono, 16bits)
					WAVEFORMATEX format;
					memset(&format, 0, sizeof(WAVEFORMATEX));
					format.wFormatTag = WAVE_FORMAT_PCM;
					format.nChannels = 1;		// mono
					format.nSamplesPerSec = DXREPLAY_RATE;
					format.nAvgBytesPerSec = DXREPLAY_SAMPLESIZE * DXREPLAY_RATE;
					format.nBlockAlign = DXREPLAY_SAMPLESIZE;
					format.wBitsPerSample = DXREPLAY_DEPTH;
					format.cbSize = 0;
					hRes = m_pPrimary->SetFormat(&format);
					if (hRes == DS_OK)
					{	// Now create a normal sound buffer.
						DSBUFFERDESC bufferDesc;
						memset(&bufferDesc,0,sizeof(bufferDesc));
						bufferDesc.dwSize = sizeof(bufferDesc);
						bufferDesc.dwFlags = DSBCAPS_GETCURRENTPOSITION2|DSBCAPS_STICKYFOCUS;
						bufferDesc.dwBufferBytes = DXREPLAY_BUFFERLEN;
						bufferDesc.lpwfxFormat = &format;		// Same format as primary
						hRes = m_pDS->CreateSoundBuffer(&bufferDesc,&m_pBuffer,NULL);
						if (hRes == DS_OK)
						{	// Start playing buffer
							hRes = m_pBuffer->Play(0, 0, DSBPLAY_LOOPING);
							if (hRes == DS_OK)
							{	// And finally create and launch the thread rout.
								DWORD	tmp;
								m_hThread = (HANDLE)CreateThread(NULL,0,(LPTHREAD_START_ROUTINE)threadRout,(void *)this,0,&tmp);
								m_bThreadRunning = true;
								return true;
							}
						}
					}
				}
			}
		}
		return false;		// TODO: Catch all the errors !! :-)
}

bool	CDXSoundServer::update(void)
{
DWORD	playPos,unusedWriteCursor;
DWORD	writeLen;
LPVOID	p1,p2;
DWORD	l1,l2;



		HRESULT hRes;
		hRes = m_pBuffer->GetCurrentPosition(&playPos,&unusedWriteCursor);
		if (hRes != DS_OK) playPos = 0;

		if (m_writePos < playPos)
			writeLen = playPos - m_writePos;
		else
			writeLen = DXREPLAY_BUFFERLEN - (m_writePos - playPos);

        while (DS_OK != m_pBuffer->Lock(m_writePos,writeLen,&p1,&l1,&p2,&l2,0))
		{
			m_pBuffer->Restore();
			m_pBuffer->Play(0, 0, DSBPLAY_LOOPING);
		}

		if (m_pUserCallback)
		{
			if ((p1) && (l1>0)) m_pUserCallback(p1,l1);
			if ((p2) && (l2>0)) m_pUserCallback(p2,l2);
		}
		m_pBuffer->Unlock(p1,l1,p2,l2);
		m_writePos += writeLen;

		if (m_writePos >= DXREPLAY_BUFFERLEN) m_writePos -= DXREPLAY_BUFFERLEN;

		if (m_bThreadKillRequired) m_bThreadRunning = false;
		return (!m_bThreadKillRequired);
}

void	CDXSoundServer::close(void)
{

		while (m_bThreadRunning)
		{
			m_bThreadKillRequired = true;
		}
		if (m_hThread != INVALID_HANDLE_VALUE) CloseHandle(m_hThread);
		if (m_pBuffer) m_pBuffer->Release();
		if (m_pPrimary) m_pPrimary->Release();
		if (m_pDS) m_pDS->Release();
		reset();
}


