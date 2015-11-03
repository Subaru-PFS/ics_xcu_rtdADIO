import sys
import cython

from libc.stdint cimport uint32_t

cdef extern from "aDIO_library.h":
    struct aDIODeviceDescriptor:
        pass
    ctypedef aDIODeviceDescriptor *DeviceHandle

    int OpenDIO_aDIO(DeviceHandle * Device,
                     uint32_t nDevice)
    int LoadPort0BitDir_aDIO(
        DeviceHandle Device,
        unsigned char Bit7,
        unsigned char Bit6,
        unsigned char Bit5,
        unsigned char Bit4,
        unsigned char Bit3,
        unsigned char Bit2,
        unsigned char Bit1,
        unsigned char Bit0
    )
    int ReadPort_aDIO(DeviceHandle Device,
                      int PortNum,
                      unsigned char *val)
    int WritePort_aDIO(DeviceHandle Device,
                       int PortNum,
                       unsigned char Data)

    int CloseDIO_aDIO(DeviceHandle Device)

cdef class ADIO:
    cdef DeviceHandle deviceHandle
    cdef int minor
    cdef int portNum
    cdef unsigned char port0mask
    
    def __init__(self, mask):
        self.minor = 0          # Seems to be defined by the kernel module.
        self.portNum = 0
        self.port0mask = mask
        self.deviceHandle = <DeviceHandle> 0

        self.connect()

    def __dealloc__(self):
        if self.deviceHandle != <DeviceHandle> 0:
            CloseDIO_aDIO(self.deviceHandle)
        
    def connect(self):
        ret = OpenDIO_aDIO(&self.deviceHandle, self.minor)
        if ret != 0:
            raise RuntimeError("failed to open ADIO device. errno=%d" % ret)

        # Set output bits. 
        ret = LoadPort0BitDir_aDIO(self.deviceHandle,
                                   self.port0mask & 0x80,
                                   self.port0mask & 0x40,
                                   self.port0mask & 0x20,
                                   self.port0mask & 0x10,
                                   self.port0mask & 0x08,
                                   self.port0mask & 0x04,
                                   self.port0mask & 0x02,
                                   self.port0mask & 0x01)
        if ret != 0:
            raise RuntimeError("failed to configure ADIO port 0. errno=%d" % ret)

    def disconnect(self):
        if self.deviceHandle != <DeviceHandle> 0:
            ret = CloseDIO_aDIO(self.deviceHandle)
            if ret != 0:
                raise RuntimeError("failed to close ADIO port 0. errno=%d" % ret)
            self.deviceHandle = <DeviceHandle> 0
            
    def status(self):
        cdef unsigned char val
        ret = ReadPort_aDIO(self.deviceHandle,
                            self.portNum,
                            &val)
        if ret != 0:
            raise RuntimeError("failed to read ADIO port 0. errno=%d" % ret)

        return val


    def _set(self, unsigned newVal):
        cdef unsigned char val
        ret = WritePort_aDIO(self.deviceHandle,
                             self.portNum,
                             newVal)
        if ret != 0:
            raise RuntimeError("failed to set ADIO port 0 mask. errno=%d" % ret)

        return self.status()

    def set(self, unsigned char bitMask):
        curMask = self.status()

        return self._set((curMask | bitMask) & self.port0mask)

    def clear(self, unsigned char bitMask):
        curMask = self.status()

        return self._set((curMask & ~bitMask) & self.port0mask)
    
    



