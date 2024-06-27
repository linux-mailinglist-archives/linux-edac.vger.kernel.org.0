Return-Path: <linux-edac+bounces-1409-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E8091AE21
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF1B1F28397
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2703419DF59;
	Thu, 27 Jun 2024 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGqeaiKY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67619D8AA;
	Thu, 27 Jun 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509595; cv=none; b=oxznQDwK0wkrVU52yzLAKLUQ3woTaQUNVM/Auj7Cr/8A7fUN+tgAdjE+zaVBcSKyBQvSUNw37N87Obm7Vo1wpbixDJjQYquIH8awujAvdDd4cSlHv0+qNP7X0MSgT1WE++i0IqAWVcqnqq9dgSzPXsnm2jojJ8jCaN5EuPIipvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509595; c=relaxed/simple;
	bh=mWwGGM3T7flFv7fScT23U3dBjyUQBkyuSUomwoujOQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkhQdSkGA6+qq7Zy0ULLj2Qx42cT6u4YVzSRipqb3E0DoAxnboza9Dqg3fqhCKqSSet5mMOBNK91BkWJsHdImju4ugihykxLtLTvTxI3LWlyBR1CcutqYeGw2WjCIaPxS5fI4HmAybdsfvws+WdqIF67ML8FFHLAeejMzdqcqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGqeaiKY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cd8897c73so7382336e87.2;
        Thu, 27 Jun 2024 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509591; x=1720114391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdV0Lvy+a5+SJqvS1WBCJ7JSWbjxGckHrHXUW7MVCSc=;
        b=iGqeaiKYoRE2NT8BL2Nmog8t3h1267MTSJW+AQu1kwOIU/fjL5oGc3VLjwfOUfpfVY
         BsLn61wi3e2f4lHv++uOd2bFTNW6EuDH7vDF9QH3Rr6SvXSYZHFd7llouMYpNDB49j6D
         e+D38zMlRt/GX7vJuJGU5I6/FMkKk+CG3Zqp8RHCMN5SIU3a5njEpD0X7yHOoIrbC4ML
         Sokf7LO4MD0hDJBBhlR6FReJRIthzkkF1M+vGoKCO3CZ8NEN4eehgNySWPkDGxcCQm6D
         wst0iyQ5MnXrDA7cdPOGgDoqOlL7XSPJdMk5wtAVsI3VKlbsV5GA0MD/io0nmtwq7hQy
         quSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509591; x=1720114391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdV0Lvy+a5+SJqvS1WBCJ7JSWbjxGckHrHXUW7MVCSc=;
        b=QStX/riTuXMk4/wayJwAxaFzEAzxX7GqtUWwgQedlgL2RB0ETfVumZnVUWUp9syZNE
         B0G+ckJoYUjeX8oCaQfdoIXLDXDwnPR1hRM5Y+bNNxDb2UX3neWTO1BRrPvrKDy05Td4
         6E4kejnFbS8ZbqztdBVM4Rx1Fp7ZR0a0eAW1AnX+D5ehD14D64lrxksm6J9SLWYqESfg
         tSf39G7xsd9XKZ+Ck99ThpevzvsCLtCtyHsDoM/IAxFjb3bHlmguZk/TsY6WqUOI7UsV
         df/uk2z7OtB39F8u80uDHyivV4SNJiGysxa6hnXblfx72HXFMA8lBq/AZRqCGsiKdsYV
         /Evg==
X-Forwarded-Encrypted: i=1; AJvYcCVMlDHaJqjJG6tlHGUD3SnXlJstmDYyapQ/kA3xroYqCyN+awtnSDOAxipEzZgQLTdZezHoVUIvgCMILBfM8aIwbURZThQ3zSL5oCxtzeerFQaL8xUpLNEzsywSaNq1TT2vnaqiXlk6zw==
X-Gm-Message-State: AOJu0YzP2yDMYxNPQSo0NN2vtS00gXM8R5SWs5E8aJcFfsoY/xHONNjP
	m4D80XwFV8097MO7zvtY/JBlgJIoVHCILo8pcGvh5t9o+0m1gCxv
X-Google-Smtp-Source: AGHT+IFCW/oubEhvjv3B0kTePpucrzDUADEFWBF5xh655sCuWndfx77nKhIg84IyaO3jxlPiEXlPZQ==
X-Received: by 2002:ac2:5490:0:b0:52c:dcea:86e2 with SMTP id 2adb3069b0e04-52ce183259fmr8591235e87.1.1719509591505;
        Thu, 27 Jun 2024 10:33:11 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e71329ea0sm266215e87.303.2024.06.27.10.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:11 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6 06/18] EDAC/synopsys: Drop internal CE and UE counters
Date: Thu, 27 Jun 2024 20:32:13 +0300
Message-ID: <20240627173251.25718-7-fancer.lancer@gmail.com>
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

First of all these counters aren't exposed anyhow from the driver.
Secondly the EDAC core already tracks the total amount of the correctable
and uncorrectable errors (see mem_ctl_info.{ce_mc,ue_mc} fields usage).
Drop the useless internal counters then for good.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- Drop redundant empty line.
- Drop private counters access from the check_errors() method too.
---
 drivers/edac/synopsys_edac.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 3e98e907e2b9..07aaf4562847 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -304,8 +304,6 @@ struct synps_ecc_status {
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
  * @p_data:		Platform data.
- * @ce_cnt:		Correctable Error count.
- * @ue_cnt:		Uncorrectable Error count.
  * @poison_addr:	Data poison address.
  * @row_shift:		Bit shifts for row bit.
  * @col_shift:		Bit shifts for column bit.
@@ -319,8 +317,6 @@ struct synps_edac_priv {
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
 	const struct synps_platform_data *p_data;
-	u32 ce_cnt;
-	u32 ue_cnt;
 #ifdef CONFIG_EDAC_DEBUG
 	ulong poison_addr;
 	u32 row_shift[18];
@@ -592,13 +588,8 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	if (status)
 		return IRQ_NONE;
 
-	priv->ce_cnt += priv->stat.ce_cnt;
-	priv->ue_cnt += priv->stat.ue_cnt;
 	handle_error(mci, &priv->stat);
 
-	edac_dbg(3, "Total error count CE %d UE %d\n",
-		 priv->ce_cnt, priv->ue_cnt);
-
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS)
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 
@@ -624,12 +615,7 @@ static void check_errors(struct mem_ctl_info *mci)
 	if (status)
 		return;
 
-	priv->ce_cnt += priv->stat.ce_cnt;
-	priv->ue_cnt += priv->stat.ue_cnt;
 	handle_error(mci, &priv->stat);
-
-	edac_dbg(3, "Total error count CE %d UE %d\n",
-		 priv->ce_cnt, priv->ue_cnt);
 }
 
 /**
-- 
2.43.0


