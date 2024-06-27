Return-Path: <linux-edac+bounces-1412-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45AF91AE29
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F791C21D02
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5751A0707;
	Thu, 27 Jun 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCcSwfYM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26DF19D8AA;
	Thu, 27 Jun 2024 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509600; cv=none; b=oPZzbGXc/hWHefUKNJgbDphPXvWi/ZkD0JH5qERA7W1D2Q51+73pYvkrp5AOL0CmEoso8GrnIGdk0Xs+8pXYYs46ZBrQt21OYrACM7EUbUnB5u8A1qtop67XTOXKAAPa3C6KLfXMUlPc0NKlx0uDUzgRIrPcT5meZIiwQLJywLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509600; c=relaxed/simple;
	bh=IYmmnV5RVqUUMm9QlI4vjGcOPFzp2z6XRNAi5GyWOUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhfrnnzNsdaybGUhOL4/w1xT4bV7LeK0F+OVPkrTsBlAGyEsXKoFUwtn1kI1ygHrNMheKEr58C5jJAXrh0KGZsYd3VExdpVmrKmq0QIOWXR7kzmbnXKOjSpe+OTTBq3xFYZSITRjpC8sV3wrkYyhVe0yOjvl2dwjw0HaugKf7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCcSwfYM; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so92837191fa.3;
        Thu, 27 Jun 2024 10:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509597; x=1720114397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkA9C4eBe9zrPFkOyR9chwI8BZqNOGe215GRsYCQ0Vk=;
        b=bCcSwfYM0PVWTMlMSVEMXxOPMG4h5s2baiUkcM2CKqXHRitM/SqfaaZO1x/8tR06X8
         RLgBocNRaE/OUtbXdTsI+0ZVkR/liNDmpv+369god0L001hQZgHfsPL1rxl3PhbFNHhj
         eanh78nBWybrtK0eEMRceq+bU1eKR7m63k8xNmtShVzFYC9dpJMJ7OWikthF7+ipndIl
         wda1CTxAapkXeqprA1kahCkH21eo9YREKsDCfw8k2+KUVTjyzh8hOF+N3BubaUsyaaI2
         dl3cek/0FSBCuW82ohZRi0wqP8IPkyGWO3JoHLFzSHHs6atYtT3zAbnT2GLMiq9Mvd0Z
         TGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509597; x=1720114397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkA9C4eBe9zrPFkOyR9chwI8BZqNOGe215GRsYCQ0Vk=;
        b=JVUoggwMnWMOLnLz1+WSnM9dWcWE4p2jocqS9jTQbiJhFacyaXOMb2HKABfR4yF+Ez
         osir4zdwZm48vZdCVNRRuyafE7cbGkyYwkFJIkAEOk5bR8uzDkt8z7CS7s+5skZfss1F
         i0uRP2iqg6KL0tsjkI38tNbS6V8rJgt26l6L4OEycpFw8z1WhVXs53+/C43XYLAjfmW0
         aerJrS0UMbsZEzyLkmRBHzGmjABkKG1p1rAsLY3HMci8vkRpPU7tAkDuSG1xKQ+G9GkB
         PqiMI1aQG13G2U6ef1H8RNez2zuKdeCGjYpZPnQvUl012mkBJTkNZtQ7hstBNlkkktHD
         OSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfaT2IM+iYEWnUT7WczIbu7zXVPymE31B2pG9oJCTdbyEkNRaNZoVx7r7EQsfm4h8tfCzO56w0QFrieRuoilOBBqle48MG8QEdtagscC7yJwhQWLpqcwF8vD1ER81YsR/J29C1yQDcuQ==
X-Gm-Message-State: AOJu0YxRFR7oM1YjRetzqINr/68Y0WJYjwZass2M7QVDMXCPdDwjMUWl
	nqhSU8caQ4EbB0D/ducyqf3/XeXUZtIRDdH+Aqsbx6ox3hf5eC1Z
X-Google-Smtp-Source: AGHT+IGRHdnaZ61P0qLag6rV5tFY8rbbLPkyQL7JrDkYZXnvm5q2UAt24A8bDte9VKFYXgoMVqZu3w==
X-Received: by 2002:a2e:97d8:0:b0:2eb:ef78:29c8 with SMTP id 38308e7fff4ca-2ec5797a37fmr91414371fa.14.1719509596861;
        Thu, 27 Jun 2024 10:33:16 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a344147sm3286201fa.15.2024.06.27.10.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:16 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH RESEND v6 09/18] EDAC/synopsys: Shorten out struct ecc_error_info.bankgrpnr field name
Date: Thu, 27 Jun 2024 20:32:16 +0300
Message-ID: <20240627173251.25718-10-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627173251.25718-1-fancer.lancer@gmail.com>
References: <20240627173251.25718-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

None of the ecc_error_info structure fields have "nr" suffix even though
each of them do represent some number (row number, column number, bank
number). Drop the suffix from the bankgrpnr field name for the sake of
unification then. Similarly drop the word "Number" from the CE/UE error
messages too since it doesn't give any helpful info there.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
 drivers/edac/synopsys_edac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index a874f6e4130d..8b7069bca600 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -268,17 +268,17 @@
  * @row:	Row number.
  * @col:	Column number.
  * @bank:	Bank number.
+ * @bankgrp:	Bank group number.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
- * @bankgrpnr:	Bank group number.
  */
 struct ecc_error_info {
 	u32 row;
 	u32 col;
 	u32 bank;
+	u32 bankgrp;
 	u32 bitpos;
 	u32 data;
-	u32 bankgrpnr;
 };
 
 /**
@@ -429,7 +429,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	regval = readl(base + ECC_CEADDR1_OFST);
 	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
 					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
+	p->ceinfo.bankgrp = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
 					ECC_CEADDR1_BNKGRP_SHIFT;
 	p->ceinfo.col = (regval & ECC_CEADDR1_COL_MASK);
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
@@ -443,7 +443,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	regval = readl(base + ECC_UEADDR0_OFST);
 	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
 	regval = readl(base + ECC_UEADDR1_OFST);
-	p->ueinfo.bankgrpnr = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
+	p->ueinfo.bankgrp = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
 					ECC_CEADDR1_BNKGRP_SHIFT;
 	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
 					ECC_CEADDR1_BNKNR_SHIFT;
@@ -478,9 +478,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ceinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Col %d Bank %d BankGroup Number %d Bit Position: %d Data: 0x%08x",
+				 "DDR ECC error type:%s Row %d Col %d Bank %d Bank Group %d Bit Position: %d Data: 0x%08x",
 				 "CE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrpnr, pinf->bitpos, pinf->data);
+				 pinf->bankgrp, pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
@@ -497,9 +497,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ueinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Col %d Bank %d BankGroup Number %d",
+				 "DDR ECC error type :%s Row %d Col %d Bank %d Bank Group %d",
 				 "UE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrpnr);
+				 pinf->bankgrp);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-- 
2.43.0


