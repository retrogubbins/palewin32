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

#ifndef __DXSOUNDSERVER__
#define __DXSOUNDSERVER__

#include <dsound.h>

#define	DXREPLAY_RATE				44100
#define	DXREPLAY_DEPTH				16
#define	DXREPLAY_SAMPLESIZE			(DXREPLAY_DEPTH/8)
#define	DXREPLAY_BUFFERLEN			(8*1024)
typedef void (*DXUSER_CALLBACK) (void *pBuffer,long bufferLen);

class	CDXSoundServer
{
public:

		CDXSoundServer(HWND hWnd);
		~CDXSoundServer();
		bool	open(DXUSER_CALLBACK pUserCallback);
		void	close(void);

		// Do *not* use these internal function, must be "public" only for thread reason.
		bool	update(void);

private:
		void				reset(void);
		DXUSER_CALLBACK		m_pUserCallback;
		LPDIRECTSOUND		m_pDS;
		HWND				m_hWnd;
		LPDIRECTSOUNDBUFFER	m_pPrimary;
		LPDIRECTSOUNDBUFFER	m_pBuffer;
		HANDLE				m_hThread;
		DWORD				m_writePos;
		volatile	bool	m_bThreadRunning;
		volatile	bool	m_bThreadKillRequired;
};

#endif
