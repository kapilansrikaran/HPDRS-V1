import React, { useState, useRef } from "react";
import { QrReader } from "react-qr-reader";

function StudentDashboard() {
  const [complaint, setComplaint] = useState(false);
  const [scanning, setScanning] = useState(false);
  const [showCamera, setShowCamera] = useState(false);
  const qrReaderRef = useRef(null);

  const handleScanClick = () => {
    setScanning(true);
    setShowCamera(true);

    // Automatically close the camera after 45 seconds
    setTimeout(() => {
      setScanning(false);
      setShowCamera(false);
    }, 45000);
  };

  const handleScan = (result) => {
    if (result) {
      console.log("Scanned data:", result);
      if (result === "start-scanning") {
        setScanning(true);
      } else if (result === "stop-scanning") {
        setScanning(false);
        setShowCamera(false);
      }
    }
  };

  const handleError = (error) => {
    console.error("QR Code Scanner Error:", error);
  };

  return (
    <div style={{ backgroundColor: "lightblue", padding: "20px" }}>
      <h1>Student Dashboard</h1>
      <div>
        <p>If your room has broken items, you can complain.</p>
        {complaint ? (
          <div>
            <p>Your complaint has been registered. Thank you!</p>
          </div>
        ) : (
          <div>
            <button id="scan" onClick={handleScanClick}>
              Scan
            </button>
            {showCamera && (
              <div
                style={{
                  width: "300px",
                  height: "500px",
                  margin: "auto",
                  alignItems: "center",
                  justifyContent: "center",
                }}
              >
                <QrReader
                  onScan={handleScan}
                  onError={handleError}
                  ref={qrReaderRef}
                />
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}

export default StudentDashboard;
