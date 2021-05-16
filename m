Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856B038205C
	for <lists+linux-edac@lfdr.de>; Sun, 16 May 2021 20:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhEPSbS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 16 May 2021 14:31:18 -0400
Received: from smtp-out-01.aalto.fi ([130.233.228.120]:63808 "EHLO
        smtp-out-01.aalto.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhEPSbR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 16 May 2021 14:31:17 -0400
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 May 2021 14:31:17 EDT
Received: from smtp-out-01.aalto.fi (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id A7689115854_A1625BB
        for <linux-edac@vger.kernel.org>; Sun, 16 May 2021 18:20:11 +0000 (GMT)
Received: from kosh.localdomain (kosh.org.aalto.fi [130.233.224.196])
        by smtp-out-01.aalto.fi (Sophos Email Appliance) with ESMTP id 73D2E11584C_A1625BF
        for <linux-edac@vger.kernel.org>; Sun, 16 May 2021 18:20:11 +0000 (GMT)
Received: by kosh.localdomain (Postfix, from userid 1751673)
        id 706F42C03BB; Sun, 16 May 2021 21:20:11 +0300 (EEST)
Date:   Sun, 16 May 2021 21:20:11 +0300
From:   Pekka Honkanen <pekka.honkanen@aalto.fi>
To:     linux-edac@vger.kernel.org
Subject: Comet Lake EDAC support
Message-ID: <20210516182011.GA370551@kosh.org.aalto.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aalto.fi; h=date:from:to:subject:message-id:mime-version:content-type; s=its18; bh=rn+IVd7ZteBrfBJBZhGYeMMu+IDJ6f+8aeYxE7vdaVw=; b=p9ZDJW3bzCSy8v8owgJUuDH5E0/qOnhDZyNLVtaDhwDyFbN/AwozRTU3YQghojahnPCEHbz40uG43lKWtBsKQs/ZiDf3UlQOJrewttk7N8DQXJWx1+VBD6NoZ+8yf43N4LIj5kbKx7KLsIZjs26Pzn7CI3zE3klaxKuJ2d16mz/5MC0MKYeEAsjRM1QHtpyTzPyM2rW5QZmFToseJv2Ob4JQPP1ZWo+MSZqEjXysZi4t+evRkJZb0EkLPxjdqZuJ4+vvEv2eHBpCbXPM1IGIXXVoOZuqlPNUW5MpDHIPYGotSiLCLHlOO2VIp97+GHKN8QSdLGJc7b2zqhZAc6sePQ==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

It looks like Intel Comet Lake (the Xeon W-1200 family) has no EDAC
support yet. This was a little surprising - Comet Lake has been around
for about a year. But maybe everyone went for Ryzen instead and I am
the only Intel user left ;-).

According to Intel docs the ECC registers are same as Coffee Lake.

Coffee Lake:
https://www.intel.com/content/www/us/en/products/docs/processors/core/8th-gen-core-family-datasheet-vol-2.html

Comet Lake:
https://cdrdv2.intel.com/v1/dl/getContent/621887

In fact it looks like the Host bridge and MCHBAR sections were just
copy pasted over, with some information omitted. The host bridge PCI
Device ID 0x3eXX mentioned in the document is not correct. I have a
W-1290P, and the Device ID is 0x9b33. I suppose it is possible that the
document is not accurate for ECC registers either.

The PCI IDs list mentions several other values as Comet Lake-S or 10th
Gen Core DRAM Controller Device ID, but I don't know if these are Xeon
or not (i.e. relevant for EDAC).

Anyway, I hope support can be added with just the new PCI Device ID(s).
I tried this and EDAC probes fine, and edac-util also shows expected
output:

titan% edac-util -v
mc0: 0 Uncorrected Errors with no DIMM info
mc0: 0 Corrected Errors with no DIMM info
edac-util: No errors to report.

However I am not sure how to verify this actually works. I have a
Gigabyte W480M motherboard, and the BIOS does not expose ACPI EINJ
table. Looking at the Intel docs, the DRAM controller registers mention
error injection capabilities, but it is not clear how to do this, or if
it is at all possible as the BIOS might disable the ECC injection.

Is there some other way?

The patch:

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 9a9ff5ad611a..32512b7328ec 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -76,12 +76,16 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_9    0x3ec6
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_10   0x3eca
 
+/* Comet Lake-S */
+#define PCI_DEVICE_ID_INTEL_IE31200_HB_CML_1	0x9b33
+
 /* Test if HB is for Skylake or later. */
 #define DEVICE_ID_SKYLAKE_OR_LATER(did)                                        \
 	(((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_8) ||                        \
 	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
 	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
-	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))
+	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ||                          \
+	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_CML_1))
 
 #define IE31200_DIMMS			4
 #define IE31200_RANKS			8
@@ -587,6 +591,7 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_8),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_9),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_10), PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CML_1),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
 	{ 0, } /* 0 terminated list. */
 };
 MODULE_DEVICE_TABLE(pci, ie31200_pci_tbl);
