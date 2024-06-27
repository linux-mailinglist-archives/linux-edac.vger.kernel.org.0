Return-Path: <linux-edac+bounces-1404-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADC191AE13
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FA9283AA9
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E084E19A2AE;
	Thu, 27 Jun 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjDR7ufs"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34F214D6EB;
	Thu, 27 Jun 2024 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509584; cv=none; b=fFwLCcjIYr06/4Xtayjjyt36BtRksCEO7RW2CtCpw+eUCuG0iiBP355sbpX2nVw54ZSCuAK4zzt8IQCSixvX9D6N3jH5nro6OlxE4dWdHyVBWR8tFqDOSA8meDf1QgBLna0xEnE3zSVJrKMLTXAON86MNarLX64IgnQpL/1C7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509584; c=relaxed/simple;
	bh=IGqoI1S+U/xadOXVQGKg1/V6BqAU0zViZUVMBKXGKmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PurQuO6YGrTx2k4E7VMiI3x0EZMQD2Y05b/eEspw8N1s3C5C3T9TepNCNGFGNvWpxx2CJQMnYH51hlJkpLMOYcBOQQAlJakWakXb8FkNUd8c9Czy1RVAskPzQ9krvNinuAsUwqmTqDHAjUMv/LQWlKIvRTu63fhwK4kqEX1yzp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjDR7ufs; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec595d0acbso65288351fa.1;
        Thu, 27 Jun 2024 10:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509581; x=1720114381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGUmsAPKsf36nNLG3WX1Sp+D1yRbsuEFCsAACInpqbo=;
        b=ZjDR7ufsR9xY4b2BJjp9GGSKpnrqvoyAlOZWG3AaGcfBJoJ9peNVE2fIMVP5MuR6su
         eue3Xqa3a+gzZ4sOer4gtlFqYiQDrAAQcCdUedNELesthCIGJTp/EzmU+lTcDFi5vI3l
         McVbYblE2AdVgRriZ7yyEGb8v65UBggjwR36hg00mxfc9CUFBXgX9q28lwF2E9Sv/SSf
         L/UMhg5NEFOCccQBI2wkDLX2zA1bfJSsHUOAoMVRZCHM4LAniav6Nm57P1hSUDekdtaG
         B5gz825GQOjKz7N5iFg9rtF8o8vcfnOeXVSH0MxdRSNFFe5X5cXPDVOFOqeyJ3ax0Hsm
         LqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509581; x=1720114381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGUmsAPKsf36nNLG3WX1Sp+D1yRbsuEFCsAACInpqbo=;
        b=tcYD7ghc36HH+z9QRFfqPfyRJHCarILYq4tje+X6MR4whNejZjEJMGF35kZe6pGcal
         7G+K1DH7iE/EgUrxpSZj0w8WLWxwOjnwFJd4ZwEZrLqHMmFwm/n9YCr+vaSS5sYEqjGf
         th8Ur2mNwxFmEy59YgeTAo9Ped3UbzwkZahXKPSBA06ntfhLWEdZOrW/dWBBXxQrFG3f
         YnqFZL7v73X833wf+DL9SY1mvQbY+vYeukhjRMyCO1j6vBO8B3SJ+GTl/wbjuN1DKjFy
         gCZr+82PtEfK5VEZIv+pK+Krq1AsAiFNDUZxs2m5am/eJK0QKglYuOzqm86b9yQTlrpA
         c5tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZOa7fQu5oN46J3T8sUTxFRTU6S76/EkZrP+pztvhWtsCxk2qeR3TS1KH5S+LAu44ekUc/Gt0XzFtJHeJf35V7tXUfbNdqOqRAqwQsFYtasTSdqXaOAOnoewlFcYH3ih3KtLFM6JarTw==
X-Gm-Message-State: AOJu0YxgzIOi7IQD5oF5w/La0LD5o89B99+wlY50JrZ32ja6QUNuLY4L
	JyzNOFdhiduZ7PkLa6ou7aTA6b24KpKZHBgBbaHwVTGZeF0r4ta5
X-Google-Smtp-Source: AGHT+IGmprKT3Qysp0kTAlE196IhhFvhMCZyhvJXbMat0AkcSp0/SXIjWpvLF2Ogcpd18NH19z/C2A==
X-Received: by 2002:a2e:8396:0:b0:2ec:558d:4e0a with SMTP id 38308e7fff4ca-2ec5b30bd73mr107833561fa.19.1719509580936;
        Thu, 27 Jun 2024 10:33:00 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a35babcsm3131151fa.67.2024.06.27.10.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:00 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Manish Narani <manish.narani@xilinx.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH RESEND v6 01/18] EDAC/synopsys: Fix generic device type detection procedure
Date: Thu, 27 Jun 2024 20:32:08 +0300
Message-ID: <20240627173251.25718-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627173251.25718-1-fancer.lancer@gmail.com>
References: <20240627173251.25718-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

First of all the enum dev_type constants describe the memory DRAM chips
used at the stick, not the entire DQ-bus width (see the enumeration kdoc
for details). So what is returned from the zynqmp_get_dtype() function and
then specified to the dimm_info->dtype field is definitely incorrect
because the DDR controller DQ-bus width doesn't determine a strict
DDR-chips configuration on the attached memory device.

Secondly the DRAM chips type has nothing to do with the data bus width
specified in the MSTR.data_bus_width CSR field. The CSR field just
determines the _part_ of the whole DQ-bus currently used to access the data
from the all DRAM memory chips. So it doesn't indicate the individual
chips type.

Thirdly in case of the DW uMCTL2 controllers the DRAM chips type can be
firmly determined only in case of the DDR4 protocol by means of the
MSTR.device_config field state (the field is supposed to be set by the system
firmware though). From this and the rest of the perspective the
zynqmp_get_dtype() implementation is incorrect.

Finally the DW uMCTL2 DDRC ECC capability doesn't depend on the memory
chips type. Moreover it doesn't depend on the utilized data bus width in
runtime either. The IP-core reference manual says in [1,2] that the ECC
support can't be enabled during the IP-core synthesis for the DRAM data
bus widths other than 16, 32 or 64. At the same time the bus width mode
(MSTR.data_bus_width) doesn't change the ECC feature availability. Thus it
was wrong to determine the ECC state with respect to the DQ-bus width
mode. From this perspective the zynqmp_get_ecc_state() implementation is
incorrect either. It shouldn't rely on the currently utilized DQ-bus
part or the attached DDR-chip types.

Fix all of the mistakes described above in the zynqmp_get_dtype() and
zynqmp_get_ecc_state() methods: determine the actual DRAM chips data width
only for the DDR4 protocol and return that it's UNKNOWN in the rest of the
cases; determine the ECC availability by the ECCCFG0.ecc_mode field state
only (that field can't be modified anyway if the IP-core was synthesized
with no ECC support).

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p. 421.
[2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
Databook, Version 3.91a, October 2020, p. 633.

Fixes: b500b4a029d5 ("EDAC, synopsys: Add ECC support for ZynqMP DDR controller")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

---

Changelog v2:
- Include "linux/bitfield.h" header file to get the FIELD_GET macro
  definition. (@tbot)

Changelog v6:
- Fix the zynqmp_get_dtype() method kdoc.
- Split up the commit log into paragraphs.
---
 drivers/edac/synopsys_edac.c | 55 +++++++++++++++---------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index ea7a9a342dd3..b6bdbc1289f3 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -664,36 +664,35 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
 }
 
 /**
- * zynqmp_get_dtype - Return the controller memory width.
+ * zynqmp_get_dtype - Return the DDR memory chips type.
  * @base:	DDR memory controller base address.
  *
- * Get the EDAC device type width appropriate for the current controller
+ * Get the attached DDR chips type based on the current controller
  * configuration.
  *
- * Return: a device type width enumeration.
+ * Return: type of the memory DRAM chips.
  */
 static enum dev_type zynqmp_get_dtype(const void __iomem *base)
 {
-	enum dev_type dt;
-	u32 width;
-
-	width = readl(base + CTRL_OFST);
-	width = (width & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
-	switch (width) {
-	case DDRCTL_EWDTH_16:
-		dt = DEV_X2;
-		break;
-	case DDRCTL_EWDTH_32:
-		dt = DEV_X4;
-		break;
-	case DDRCTL_EWDTH_64:
-		dt = DEV_X8;
-		break;
-	default:
-		dt = DEV_UNKNOWN;
+	u32 regval;
+
+	regval = readl(base + CTRL_OFST);
+	if (!(regval & MEM_TYPE_DDR4))
+		return DEV_UNKNOWN;
+
+	regval = (regval & DDRC_MSTR_CFG_MASK) >> DDRC_MSTR_CFG_SHIFT;
+	switch (regval) {
+	case DDRC_MSTR_CFG_X4_MASK:
+		return DEV_X4;
+	case DDRC_MSTR_CFG_X8_MASK:
+		return DEV_X8;
+	case DDRC_MSTR_CFG_X16_MASK:
+		return DEV_X16;
+	case DDRC_MSTR_CFG_X32_MASK:
+		return DEV_X32;
 	}
 
-	return dt;
+	return DEV_UNKNOWN;
 }
 
 /**
@@ -730,19 +729,11 @@ static bool zynq_get_ecc_state(void __iomem *base)
  */
 static bool zynqmp_get_ecc_state(void __iomem *base)
 {
-	enum dev_type dt;
-	u32 ecctype;
+	u32 regval;
 
-	dt = zynqmp_get_dtype(base);
-	if (dt == DEV_UNKNOWN)
-		return false;
+	regval = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
 
-	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
-	if ((ecctype == SCRUB_MODE_SECDED) &&
-	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
-		return true;
-
-	return false;
+	return (regval == SCRUB_MODE_SECDED);
 }
 
 /**
-- 
2.43.0


