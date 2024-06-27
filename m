Return-Path: <linux-edac+bounces-1407-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E591AE1D
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3151F27C51
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE9419B5BB;
	Thu, 27 Jun 2024 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBAgBWVD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B6919ADA2;
	Thu, 27 Jun 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509589; cv=none; b=jwoY5ywD33hkG6JNMLPLtiDLzzJ2i/O6XQxj405ym8Y4qY1tb98aDalqnYM5eJMezhRNrSHpIq39w3Hx51JZ+BNgucSioyMIW3TE0mQSM+TTXP415C7asAvxYJnAAraWLBRRSmZCq0xCsJfuDPu7gcG/OpPlTdl38qan1qke0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509589; c=relaxed/simple;
	bh=YOtJFZghKEdU1d1o3n8XQcr96fJGNKpvRNOANWULZe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCnZqs/A5cfHSyOewccXvGuZfTH4OFMUu68wFO5hHFf3Ce29Zj+zVYJl90RrMOie02p9+Gm6K7+iSDtXXTeWyI2BBoA0trZeh5oWRro+jwx7offA2rcp7C5+QyHBY5trvAhc/s5W75ktqquDPInODiEBmeWXlUimsmgP1IvoG/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBAgBWVD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cdf2c7454so10656326e87.1;
        Thu, 27 Jun 2024 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509586; x=1720114386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHJBwOhxjzjZz2a22XMFFd3S++2AA0bKdaTplGawDiw=;
        b=hBAgBWVDwVDnadz5XlzdUGm3rORDJfY9oqaUN+R/BUSj3265zhbmAlrm9Ai/8fBizB
         Zmj3mX4OYiebejvR+RLW0FqQgg15RihaHyapfKB55RIaxJb6cwMSERGcEV4iD2ZZc8p5
         vhg4sum42H+8TEHmyoFwKB6PVnpQA9zzicgi2qd+xzZw5ZGhPIg6Xl8sYhkIM2LZ/iZ8
         hNtKaHIbf6cyTU2r7JOL/c2qfslZXxsTcv+Mlx7IoT9RAZj5IUJKKLIjjQianTY281o1
         o8XFTWfSBS2EsEyblLxzJc+1LiE87JWUbkfbPzNSU391jWg1PtUBxlxLBAMwtobphfgd
         bqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509586; x=1720114386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHJBwOhxjzjZz2a22XMFFd3S++2AA0bKdaTplGawDiw=;
        b=jUp4FoFbRqDEtsmARhXAKyB/SzcSeKrAzs3BHi+KYbsfA1jfdnb8dqO27hW0J/ubzz
         xuDyrxVqyKiTu+u1PolUCXfTAtfmOcIbGbY5KQeJa08lpa7HXsvKyCA+TkcZ9eBHo4fa
         nkLRD1QiMwxFkg9Ms08BeICDtGgw1K+PJadGPMb1Yo7EkkD3ICAvnftnqS0N2NKJyqUq
         SO0So+yAiDwgrC8BL5XHW13XmOAoirltWUm0fco6UKUF4mv8dyS8kzMRv7rGPoDObSVk
         2RUSziZELRrN4TETejH3ubl/sBAmKa+Ela+GgPYiFshGqq1hQuHDXbO3oWVb1pl2LalA
         AFTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU2Xkf9wo18WB/V/SHqb1+9FvCfk7nfpL0jfhozRUbzTrEcghbYQdW9eQSTIF4MP0NO37V1pZMFCgO28HI05puz2ghsIqwl+iEUNUi9dqjYj5Z4cObQl+HsOBSHSgr6ImYddwfQcM/YA==
X-Gm-Message-State: AOJu0YxSfKvt8MiMvq7XBFOqnFliNLNoBkkZd2plqcTPgSDpVGMhWTG8
	RK8bMX4uTxX56CL8+z69Wbz6bHH9h1RwCeVgGjjnrusjZbkllW2m
X-Google-Smtp-Source: AGHT+IHfW+NESmWd/AJ8l91EGa76rIOSfdHDEzj4bjSG/ElE2JXyq6xBCGFd0i3y8ZXFM44Kf+je5A==
X-Received: by 2002:a05:6512:108c:b0:52c:dd25:9ac6 with SMTP id 2adb3069b0e04-52ce1835607mr14311724e87.29.1719509586182;
        Thu, 27 Jun 2024 10:33:06 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0ba53sm1430e87.50.2024.06.27.10.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:05 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
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
Subject: [PATCH RESEND v6 04/18] EDAC/synopsys: Fix reading errors count before ECC status
Date: Thu, 27 Jun 2024 20:32:11 +0300
Message-ID: <20240627173251.25718-5-fancer.lancer@gmail.com>
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

Aside with fixing the errors count CSR usage the commit e2932d1f6f05
("EDAC/synopsys: Read the error count from the correct register") all of
the sudden has also changed the order of the errors status check
procedure. So now the errors handler method first reads the number of CE
and UE and only then makes sure that any of these errors have actually
happened. It doesn't make sense. Fix that by getting back the correct
procedures order: first check the ECC status, then read the number of
errors.

Fixes: e2932d1f6f05 ("EDAC/synopsys: Read the error count from the correct register")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
 drivers/edac/synopsys_edac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 88db777f3d90..6d578f4b03b1 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -418,18 +418,18 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	base = priv->baseaddr;
 	p = &priv->stat;
 
-	regval = readl(base + ECC_ERRCNT_OFST);
-	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
-	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
-	if (!p->ce_cnt)
-		goto ue_err;
-
 	regval = readl(base + ECC_STAT_OFST);
 	if (!regval)
 		return 1;
 
 	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
 
+	regval = readl(base + ECC_ERRCNT_OFST);
+	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
+	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
+	if (!p->ce_cnt)
+		goto ue_err;
+
 	regval = readl(base + ECC_CEADDR0_OFST);
 	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
 	regval = readl(base + ECC_CEADDR1_OFST);
-- 
2.43.0


