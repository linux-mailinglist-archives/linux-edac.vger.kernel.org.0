Return-Path: <linux-edac+bounces-2995-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8245BA2C870
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 17:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9E6188B748
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 16:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4514E2C2;
	Fri,  7 Feb 2025 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cf07wSuE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05671624EE;
	Fri,  7 Feb 2025 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945165; cv=none; b=UO3ReajKWoJ8xLJR78vO5cSax5HV0zI01NtexJN6jcAwCYso/a9c+8LlHkA7CI75MzxTb4Nvtkdzcvwr/hoFj3tpkTj00n3lutttzb4qEfxtzyqLdd2HIifVLM2pnAu9CV8OTtIL7M4BBvFG2XCXsM4Xj4xPhEcgTehRm6WTqVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945165; c=relaxed/simple;
	bh=h1ico0shNpVFoXoFMO3cZc/R+V/9f8vdfpmtbm/i4rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/E9YctroUawhXgDpJkbkrGBGwARbi2D/bbIf5hJwVpcxSBEG4bwihI0TsJSM/IYxWirjQZOonw9WtazvUDNeaG843cGjL++v+IGNhLmhXboTsxnpzwth6DI872+40rgRj9mlLhgbf3Qd+usyJmQuww8b88qbeDIwaEkcWPKRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cf07wSuE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738945164; x=1770481164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h1ico0shNpVFoXoFMO3cZc/R+V/9f8vdfpmtbm/i4rg=;
  b=Cf07wSuEbZypo7/V90QzerBCe04Yf6OJEzG+mkCRxeMCG7aWSeFdBg/S
   ktgd5dh5NCbF26oUjtKuQ1Ndvhw8rJxIAzRhxFW2yyEQhei0PX+NLSZWM
   vVzuqQiC50s1iAFQRtVIbblBK23h/j3V8Bu5b4lAL5vFfqxHNQNorjzo5
   BMR7hfWP3t02Vwmz039pLTHu00oCXkf+rv/fakHXnvOFxWV+8BUTpPR/A
   qzmJa/XRrsvDPI7kKm5aGQjGiOhPb3xPc0hRLyL/ofNFxII7VJ4ACd6Z/
   po6tezDhytkryoy6tZ+VYdRDPr4c4bQDHVhE5BSPup1Px3YQaD+0DBpbg
   g==;
X-CSE-ConnectionGUID: 86xgk4BOSMWV9VYL3/jMrA==
X-CSE-MsgGUID: YpA/B3llT1a3Uwh9V/r4ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="57006879"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="57006879"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:19:23 -0800
X-CSE-ConnectionGUID: hfxB+t9qT8iiSCIi1mTexg==
X-CSE-MsgGUID: 12YV2YpLSoGLDe9PiieJYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116502493"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:19:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-edac@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/2] PCI: Handle TLP Log in Flit mode
Date: Fri,  7 Feb 2025 18:18:36 +0200
Message-Id: <20250207161836.2755-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207161836.2755-1-ilpo.jarvinen@linux.intel.com>
References: <20250207161836.2755-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Flit mode introduced in PCIe r6.0 alters how the TLP Header Log is
presented through AER and DPC Capability registers. The TLP Prefix Log
Register is not present with Flit mode and the register becomes
extension for TLP Header Log (PCIe r6.1 secs 7.8.4.12 & 7.9.14.13).

Adapt pcie_read_tlp_log() and struct pcie_tlp_log to read and store
also the extended TLP Header Log when the link is in Flit mode. As
Prefix Log and Extended TLP Header are not present at the same time,
C union can be used.

Determining whether the error occurred while the Link was in Flit mode
is bit complicated. In case of AER, Advanced Error Capabilities and
Control Register directly tells whether the error was logged in Flit
mode or not (PCIe r6.1 sec 7.8.4.7). DPC Capability (PCIe r6.1 sec
7.9.14), unfortunately, does not contain the same information.

Unlike AER, the DPC capability does not provide way to discern whether
the error was logged in Flit mode (this is confirmed by PCI WG to be an
oversight in the spec). DPC will bring link down immediately following
an error, which make it impossible to acquire the Flit mode status
directly from the Link Status 2 register because Flit Mode Status is
only set in certain Link states (PCIe r6.1 sec 7.5.3.20). As a
workaround, use the flit_mode value stored into the struct pci_bus.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h             |  3 +-
 drivers/pci/pcie/aer.c        |  1 +
 drivers/pci/pcie/dpc.c        | 18 +++++++++--
 drivers/pci/pcie/tlp.c        | 56 ++++++++++++++++++++++++-----------
 include/linux/aer.h           | 12 ++++++--
 include/ras/ras_event.h       | 12 ++++----
 include/uapi/linux/pci_regs.h |  6 +++-
 7 files changed, 77 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9c6a4a980678..07cc9be6f80b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -554,7 +554,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
-		      unsigned int tlp_len, struct pcie_tlp_log *log);
+		      unsigned int tlp_len, bool flit,
+		      struct pcie_tlp_log *log);
 unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc);
 void pcie_print_tlp_log(const struct pci_dev *dev,
 			const struct pcie_tlp_log *log, const char *pfx);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 508474e17183..9c3e8299ad50 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1245,6 +1245,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG,
 					  aer + PCI_ERR_PREFIX_LOG,
 					  aer_tlp_log_len(dev, aercc),
+					  aercc & PCI_ERR_CAP_TLP_LOG_FLIT,
 					  &info->tlp);
 		}
 	}
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 242cabd5eeeb..df42f15c9829 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -219,7 +219,9 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 		goto clear_status;
 	pcie_read_tlp_log(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
 			  cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
-			  dpc_tlp_log_len(pdev), &tlp_log);
+			  dpc_tlp_log_len(pdev),
+			  pdev->subordinate->flit_mode,
+			  &tlp_log);
 	pcie_print_tlp_log(pdev, &tlp_log, dev_fmt(""));
 
 	if (pdev->dpc_rp_log_size < PCIE_STD_NUM_TLP_HEADERLOG + 1)
@@ -398,11 +400,21 @@ void pci_dpc_init(struct pci_dev *pdev)
 
 	/* Quirks may set dpc_rp_log_size if device or firmware is buggy */
 	if (!pdev->dpc_rp_log_size) {
+		u16 flags;
+		int ret;
+
+		ret = pcie_capability_read_word(pdev, PCI_EXP_FLAGS, &flags);
+		if (ret)
+			return;
+
 		pdev->dpc_rp_log_size =
 				FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, cap);
+		if (FIELD_GET(PCI_EXP_FLAGS_FLIT, flags))
+			pdev->dpc_rp_log_size += FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE4,
+							   cap) << 4;
+
 		if (pdev->dpc_rp_log_size < PCIE_STD_NUM_TLP_HEADERLOG ||
-		    pdev->dpc_rp_log_size > PCIE_STD_NUM_TLP_HEADERLOG + 1 +
-					    PCIE_STD_MAX_TLP_PREFIXLOG) {
+		    pdev->dpc_rp_log_size > PCIE_STD_MAX_TLP_HEADERLOG + 1) {
 			pci_err(pdev, "RP PIO log size %u is invalid\n",
 				pdev->dpc_rp_log_size);
 			pdev->dpc_rp_log_size = 0;
diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
index 0860b5da837f..890d5391d7f5 100644
--- a/drivers/pci/pcie/tlp.c
+++ b/drivers/pci/pcie/tlp.c
@@ -7,6 +7,7 @@
 
 #include <linux/aer.h>
 #include <linux/array_size.h>
+#include <linux/bitfield.h>
 #include <linux/pci.h>
 #include <linux/string.h>
 
@@ -21,6 +22,9 @@
  */
 unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc)
 {
+	if (aercc & PCI_ERR_CAP_TLP_LOG_FLIT)
+		return FIELD_GET(PCI_ERR_CAP_TLP_LOG_SIZE, aercc);
+
 	return PCIE_STD_NUM_TLP_HEADERLOG +
 	       ((aercc & PCI_ERR_CAP_PREFIX_LOG_PRESENT) ?
 		dev->eetlp_prefix_max : 0);
@@ -49,6 +53,7 @@ unsigned int dpc_tlp_log_len(struct pci_dev *dev)
  * @where: PCI Config offset of TLP Header Log
  * @where2: PCI Config offset of TLP Prefix Log
  * @tlp_len: TLP Log length (Header Log + TLP Prefix Log in DWORDs)
+ * @flit: TLP Logged in Flit mode
  * @log: TLP Log structure to fill
  *
  * Fill @log from TLP Header Log registers, e.g., AER or DPC.
@@ -56,28 +61,34 @@ unsigned int dpc_tlp_log_len(struct pci_dev *dev)
  * Return: 0 on success and filled TLP Log structure, <0 on error.
  */
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
-		      unsigned int tlp_len, struct pcie_tlp_log *log)
+		      unsigned int tlp_len, bool flit, struct pcie_tlp_log *log)
 {
 	unsigned int i;
 	int off, ret;
-	u32 *to;
+
+	if (tlp_len > ARRAY_SIZE(log->dw))
+		tlp_len = ARRAY_SIZE(log->dw);
 
 	memset(log, 0, sizeof(*log));
 
 	for (i = 0; i < tlp_len; i++) {
-		if (i < PCIE_STD_NUM_TLP_HEADERLOG) {
+		if (i < PCIE_STD_NUM_TLP_HEADERLOG)
 			off = where + i * 4;
-			to = &log->dw[i];
-		} else {
+		else
 			off = where2 + (i - PCIE_STD_NUM_TLP_HEADERLOG) * 4;
-			to = &log->prefix[i - PCIE_STD_NUM_TLP_HEADERLOG];
-		}
 
-		ret = pci_read_config_dword(dev, off, to);
+		ret = pci_read_config_dword(dev, off, &log->dw[i]);
 		if (ret)
 			return pcibios_err_to_errno(ret);
 	}
 
+	/*
+	 * Hard-code non-Flit mode to 4 DWORDs, for now. The exact length
+	 * can only be known if the TLP is parsed.
+	 */
+	log->header_len = flit ? tlp_len : 4;
+	log->flit = flit;
+
 	return 0;
 }
 
@@ -94,22 +105,31 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 void pcie_print_tlp_log(const struct pci_dev *dev,
 			const struct pcie_tlp_log *log, const char *pfx)
 {
-	char buf[11 * (PCIE_STD_NUM_TLP_HEADERLOG + ARRAY_SIZE(log->prefix)) +
-		 sizeof(EE_PREFIX_STR)];
+	/* EE_PREFIX_STR fits the extended DW space needed for the Flit mode */
+	char buf[11 * PCIE_STD_MAX_TLP_HEADERLOG + 1];
 	unsigned int i;
 	int len;
 
 	len = scnprintf(buf, sizeof(buf), "%#010x %#010x %#010x %#010x",
 			log->dw[0], log->dw[1], log->dw[2], log->dw[3]);
 
-	if (log->prefix[0])
-		len += scnprintf(buf + len, sizeof(buf) - len, EE_PREFIX_STR);
-	for (i = 0; i < ARRAY_SIZE(log->prefix); i++) {
-		if (!log->prefix[i])
-			break;
-		len += scnprintf(buf + len, sizeof(buf) - len,
-				 " %#010x", log->prefix[i]);
+	if (log->flit) {
+		for (i = PCIE_STD_NUM_TLP_HEADERLOG; i < log->header_len; i++) {
+			len += scnprintf(buf + len, sizeof(buf) - len,
+					 " %#010x", log->dw[i]);
+		}
+	} else {
+		if (log->prefix[0])
+			len += scnprintf(buf + len, sizeof(buf) - len,
+					 EE_PREFIX_STR);
+		for (i = 0; i < ARRAY_SIZE(log->prefix); i++) {
+			if (!log->prefix[i])
+				break;
+			len += scnprintf(buf + len, sizeof(buf) - len,
+					 " %#010x", log->prefix[i]);
+		}
 	}
 
-	pci_err(dev, "%sTLP Header: %s\n", pfx, buf);
+	pci_err(dev, "%sTLP Header%s: %s\n", pfx,
+		log->flit ? " (Flit)" : "", buf);
 }
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 947b63091902..02940be66324 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -22,12 +22,20 @@
  */
 #define PCIE_STD_NUM_TLP_HEADERLOG     4
 #define PCIE_STD_MAX_TLP_PREFIXLOG     4
+#define PCIE_STD_MAX_TLP_HEADERLOG	(PCIE_STD_NUM_TLP_HEADERLOG + 10)
 
 struct pci_dev;
 
 struct pcie_tlp_log {
-	u32 dw[PCIE_STD_NUM_TLP_HEADERLOG];
-	u32 prefix[PCIE_STD_MAX_TLP_PREFIXLOG];
+	union {
+		u32 dw[PCIE_STD_MAX_TLP_HEADERLOG];
+		struct {
+			u32 _do_not_use[PCIE_STD_NUM_TLP_HEADERLOG];
+			u32 prefix[PCIE_STD_MAX_TLP_PREFIXLOG];
+		};
+	};
+	u8 header_len;		/* Length of the Logged TLP Header in DWORDs */
+	bool flit;		/* TLP was logged when in Flit mode */
 };
 
 struct aer_capability_regs {
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index e5f7ee0864e7..14c9f943d53f 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -309,7 +309,7 @@ TRACE_EVENT(aer_event,
 		__field(	u32,		status		)
 		__field(	u8,		severity	)
 		__field(	u8, 		tlp_header_valid)
-		__array(	u32, 		tlp_header, 4	)
+		__array(	u32, 		tlp_header, PCIE_STD_MAX_TLP_HEADERLOG)
 	),
 
 	TP_fast_assign(
@@ -318,10 +318,10 @@ TRACE_EVENT(aer_event,
 		__entry->severity	= severity;
 		__entry->tlp_header_valid = tlp_header_valid;
 		if (tlp_header_valid) {
-			__entry->tlp_header[0] = tlp->dw[0];
-			__entry->tlp_header[1] = tlp->dw[1];
-			__entry->tlp_header[2] = tlp->dw[2];
-			__entry->tlp_header[3] = tlp->dw[3];
+			int i;
+
+			for (i = 0; i < PCIE_STD_MAX_TLP_HEADERLOG; i++)
+				__entry->tlp_header[i] = tlp->dw[i];
 		}
 	),
 
@@ -334,7 +334,7 @@ TRACE_EVENT(aer_event,
 		__print_flags(__entry->status, "|", aer_correctable_errors) :
 		__print_flags(__entry->status, "|", aer_uncorrectable_errors),
 		__entry->tlp_header_valid ?
-			__print_array(__entry->tlp_header, 4, 4) :
+			__print_array(__entry->tlp_header, PCIE_STD_MAX_TLP_HEADERLOG, 4) :
 			"Not available")
 );
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..2c801c0c968a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -486,6 +486,7 @@
 #define   PCI_EXP_TYPE_RC_EC	   0xa	/* Root Complex Event Collector */
 #define  PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
 #define  PCI_EXP_FLAGS_IRQ	0x3e00	/* Interrupt message number */
+#define  PCI_EXP_FLAGS_FLIT	0x8000	/* Flit Mode Supported */
 #define PCI_EXP_DEVCAP		0x04	/* Device capabilities */
 #define  PCI_EXP_DEVCAP_PAYLOAD	0x00000007 /* Max_Payload_Size */
 #define  PCI_EXP_DEVCAP_PHANTOM	0x00000018 /* Phantom functions */
@@ -795,6 +796,8 @@
 #define  PCI_ERR_CAP_ECRC_CHKC		0x00000080 /* ECRC Check Capable */
 #define  PCI_ERR_CAP_ECRC_CHKE		0x00000100 /* ECRC Check Enable */
 #define  PCI_ERR_CAP_PREFIX_LOG_PRESENT	0x00000800 /* TLP Prefix Log Present */
+#define  PCI_ERR_CAP_TLP_LOG_FLIT	0x00040000 /* TLP was logged in Flit Mode */
+#define  PCI_ERR_CAP_TLP_LOG_SIZE	0x00f80000 /* Logged TLP Size (only in Flit mode) */
 #define PCI_ERR_HEADER_LOG	0x1c	/* Header Log Register (16 bytes) */
 #define PCI_ERR_ROOT_COMMAND	0x2c	/* Root Error Command */
 #define  PCI_ERR_ROOT_CMD_COR_EN	0x00000001 /* Correctable Err Reporting Enable */
@@ -1061,8 +1064,9 @@
 #define  PCI_EXP_DPC_CAP_RP_EXT		0x0020	/* Root Port Extensions */
 #define  PCI_EXP_DPC_CAP_POISONED_TLP	0x0040	/* Poisoned TLP Egress Blocking Supported */
 #define  PCI_EXP_DPC_CAP_SW_TRIGGER	0x0080	/* Software Triggering Supported */
-#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE	0x0F00	/* RP PIO Log Size */
+#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE	0x0F00	/* RP PIO Log Size [3:0] */
 #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
+#define  PCI_EXP_DPC_RP_PIO_LOG_SIZE4	0x2000	/* RP PIO Log Size [4] */
 
 #define PCI_EXP_DPC_CTL			0x06	/* DPC control */
 #define  PCI_EXP_DPC_CTL_EN_FATAL	0x0001	/* Enable trigger on ERR_FATAL message */
-- 
2.39.5


