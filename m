Return-Path: <linux-edac+bounces-1411-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C275091AE27
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF56B29411
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DA21A00D4;
	Thu, 27 Jun 2024 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0MFNQgu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF1A19E82A;
	Thu, 27 Jun 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509598; cv=none; b=mfI+Itr22Mfy6bn/5LNuKSGdliSgUFisyQRauROxFFg886FSnxyvkqF5plolKTwOzjkewdY4o63KmjxN9bioI+6VY4CxNyyUZo3FKlDwigiArkBAoNAmRCxsjDknv7dDzpxuTTWDlDhpiusTDGp4pUsFQ6qcEFKu1tVMY0IezJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509598; c=relaxed/simple;
	bh=p7oHM7MGVmPiOZ0vfHFaAlxRLz7ebsoUuJS4/69jI88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqPdtM3GgYJ3tLigOKEx4P9ApQ4anfFKncBDgUVaCoFT2g2bEUnqS2WJEwVSlPsgnJMuxHmv4NCEQAj1ZEyzyqgNsc/kAY7WqDJ9rIb/ImbnjnksK3sLBIiFroGl5REzcYKe63tv1lXrx5jw0XdhG/nEjcHWYkRmIohxL6Evht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0MFNQgu; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52cd8897c73so7382412e87.2;
        Thu, 27 Jun 2024 10:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509595; x=1720114395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziWLoLb1L3jlDDlpD4pGgKPeAwHfP5+Esch84xE6s3M=;
        b=j0MFNQgu66rfTR5Fgde8oLj+a9twHHOFEAQEEIqyYphg2W1g6rCKXl7XUqXPVuv9bf
         3IHmpq0t9qr4Xo6Y8D7a92VbZxwktjJngb8UQjJ1qEHjPpdMhJ+GmqUTdOTiOTeNJp2S
         g+hvmrqsdmRUt6HP5aoP7AW44hit4pW/wmCtjoXqWBM5SlUCQV5TiIjalFZ8sPfHgS9K
         322gYN16ERn751sRIkX5saa4MiNyD+4LcqjKHGP2Wl/Ndr7bjcqNkg4aK4X/gbpfRwaF
         76q58NI/4Rctt0EAcZvP3FTQur0tOIXolwhERHweFM3fwrOvPy57GHuu0onSOdOJDMxh
         M66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509595; x=1720114395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziWLoLb1L3jlDDlpD4pGgKPeAwHfP5+Esch84xE6s3M=;
        b=A8KOiFZ1fAIngDh41v2iMkUuiOQJVCBbYueWRca2DRZnKscw362sSLCCdMWZfZBzwZ
         tEUO4GUji+VZd/37z+pLp5JGGBZxwfSKGBzIud2eMGdOTa1m9cvlwb3jLpARjULsjnxa
         BhKymHo0HSEqv4UpzRdw5iqm+TWnMN1z0PlFOi8isXKioYb7xFSfy+qUM8AgzA9X9UMG
         DuU3M60Hcd3v642flLqNzbTD9cQRJVKPnwHbqHCsrPFmAgoY/PKTZ3DDZ8g+FzaraP+6
         9r7cevwA1ii9FwZEpU97BX39E1OFIi05ZrsJmzkTe/B00HSDB2TPZAC1e1Sl6e17mUdv
         icVg==
X-Forwarded-Encrypted: i=1; AJvYcCWEbMbeeLYlyDcHg675eCPJzF563Fb3iDKozUFgDAaVCBC3duxT2KW9xP9qCOUYUezoE03vOqDcFT6xyxNyHdKPLbUBuP7DguaeklmPDW2ScCy8xI/leHSJJ8/v+gui2ZfKZEFiyfQDfw==
X-Gm-Message-State: AOJu0Yw9pIiUN0CtjF6472+g3sCc7GwQWhBkOfIAV9JewQh1Dcjstogn
	K6suKW6KGEciuyyGUHzI6bJqDedslqym1iGpDYs9lSN5sMDzRKgw
X-Google-Smtp-Source: AGHT+IHmwYXIdxJj/BScO+PhdrJzeWT6z+YAeWeFQ1/IysOsVfjcQ9j62BrTqBrmC7tZ9SsZzT6tKQ==
X-Received: by 2002:a05:6512:39cc:b0:52c:fd46:bf07 with SMTP id 2adb3069b0e04-52cfd46c32bmr6375867e87.49.1719509595075;
        Thu, 27 Jun 2024 10:33:15 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0bb46sm1395e87.15.2024.06.27.10.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:14 -0700 (PDT)
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
Subject: [PATCH RESEND v6 08/18] EDAC/synopsys: Drop struct ecc_error_info.blknr field
Date: Thu, 27 Jun 2024 20:32:15 +0300
Message-ID: <20240627173251.25718-9-fancer.lancer@gmail.com>
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

Even though the ECC(C|U)ADDR1 CSR description indeed says it's a "Block
number" in the DW uMCTL2 DDRC IP-core databooks, the corresponding
register field is named as ECC(C|U)ADDR1.ecc_(un)corr_col (which means ECC
(un)corrected column) and in the rest of the document it's referred as the
SDRAM address column. Thus use the already available ecc_error_info.col
field to read the column number to and drop the questionable
ecc_error_info.blknr field for good.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
 drivers/edac/synopsys_edac.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 230818a3969e..a874f6e4130d 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -173,7 +173,7 @@
 #define ECC_CEADDR0_RNK_MASK		BIT(24)
 #define ECC_CEADDR1_BNKGRP_MASK		0x3000000
 #define ECC_CEADDR1_BNKNR_MASK		0x70000
-#define ECC_CEADDR1_BLKNR_MASK		0xFFF
+#define ECC_CEADDR1_COL_MASK		0xFFF
 #define ECC_CEADDR1_BNKGRP_SHIFT	24
 #define ECC_CEADDR1_BNKNR_SHIFT		16
 
@@ -271,7 +271,6 @@
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
  * @bankgrpnr:	Bank group number.
- * @blknr:	Block number.
  */
 struct ecc_error_info {
 	u32 row;
@@ -280,7 +279,6 @@ struct ecc_error_info {
 	u32 bitpos;
 	u32 data;
 	u32 bankgrpnr;
-	u32 blknr;
 };
 
 /**
@@ -433,7 +431,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 					ECC_CEADDR1_BNKNR_SHIFT;
 	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
 					ECC_CEADDR1_BNKGRP_SHIFT;
-	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ceinfo.col = (regval & ECC_CEADDR1_COL_MASK);
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
 	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
 		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
@@ -449,7 +447,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 					ECC_CEADDR1_BNKGRP_SHIFT;
 	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
 					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ueinfo.col = (regval & ECC_CEADDR1_COL_MASK);
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
 out:
 	spin_lock_irqsave(&priv->reglock, flags);
@@ -480,10 +478,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ceinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->bank,
-				 pinf->bankgrpnr, pinf->blknr,
-				 pinf->bitpos, pinf->data);
+				 "DDR ECC error type:%s Row %d Col %d Bank %d BankGroup Number %d Bit Position: %d Data: 0x%08x",
+				 "CE", pinf->row, pinf->col, pinf->bank,
+				 pinf->bankgrpnr, pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
@@ -500,9 +497,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ueinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d BankGroup Number %d Block Number %d",
-				 "UE", pinf->row, pinf->bank,
-				 pinf->bankgrpnr, pinf->blknr);
+				 "DDR ECC error type :%s Row %d Col %d Bank %d BankGroup Number %d",
+				 "UE", pinf->row, pinf->col, pinf->bank,
+				 pinf->bankgrpnr);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-- 
2.43.0


