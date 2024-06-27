Return-Path: <linux-edac+bounces-1405-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D223A91AE16
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DFD1C227EB
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A5E19AA61;
	Thu, 27 Jun 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPSbyvgo"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273419A2A8;
	Thu, 27 Jun 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509586; cv=none; b=gVfDBBL7lND5NrEGgrA9afLfmHQz3l41XhufNfhjkpbfrKVV6MuVw/+hMr3cEKBGfNvB1vdojfa5jr1E+XUzYVBkWYXIt33K/myIIxwI9Fa8uDgIRj2ay8MuMvz85jfP5EDM0P16ar8BpCUouTMJqyzXz4GeoK4EUbp/MaFglgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509586; c=relaxed/simple;
	bh=GMRjQRXM2B+IamPcPeH6iljBR5FyXdaIwmQIgh4RUqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEwEMPR6wJV6VLVrBeUeBlktR6Rjd2apIZAmB12YUxwfg5Fud6jzLYmp9icjpplsuWqZSkrvhnR23GliubPGpcoUoAZvtDMFdew3GSiz0TEWQo6aeanYYjWSIM1TRnUJiB/F9X3AkBEc+Q8mYnQKQaFlCkFqXaRdNo5UXR6JPxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPSbyvgo; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52cdfb69724so6679884e87.1;
        Thu, 27 Jun 2024 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509583; x=1720114383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xg/mOI5PvLezOW9iPAK+BlDobOkASDmuuCygc0x83oc=;
        b=gPSbyvgod36rSlbVV3Nl9X4ycSeWuLk+P5I86SLLpXRRHWUCaG9ptHhW+fDbNcL8yb
         DSaiyfG2DCiiZwz7OZGEHC6s5KdbrRIu+9Bufbagt7ziMsQTsk5Qlzm+D3q0Uw5GuPI6
         jqjakAIUkX0U6hBlFudNmJzDRJojMHifYrnz/gAbP6Nk6yfaQjY1JH0OyGVLDSMLmwYI
         XxxismZWZwHXdBMdL5AAXcwaF+XhAwWXzo4K3a3m7qn5E9FyFNn6hddfBUlQDBfI2S4L
         jlGnxghRgsa/vrlQ+Cw6y4xuwwISYsPfSigGw9PtH9ipq49YB5toUR+R53B1o36EeeHa
         I4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509583; x=1720114383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xg/mOI5PvLezOW9iPAK+BlDobOkASDmuuCygc0x83oc=;
        b=Pa6yVrEmmizltHleB0LKxUDw/T1lMqm9Ta9aCBBrUqYTXE3GqSysCBA2IAmO4ZuZtI
         8bmDJ3nuz3w9nfEN1rZnAWBaa79v8HqKg2Iz0GC/YBhsC73JgkfcTiBZRfqgjq9FaXal
         9FFFEOJdhiULb+o8n9sg53n5zRwJWhQ42WsRxgC2zJ0J2eECdnctdo92gN+oHED1eQt7
         n1U0Z8zHhKEdA0aIFq6plA2Njy5oYcLpk7UoEQTaoVp7JJ3WA9FwLzY4FhBUiJzK8egZ
         C4ITRapDjWGl2oSALN/y3D597XZk4dsk73nLdnA+p9NqknlZti8esKPKNts9oZyObX+K
         OM5A==
X-Forwarded-Encrypted: i=1; AJvYcCVp/+RF2404h3ARTuxnekMIlQLTCV6tlBxf+EYYHPGpfMT0XxGjHL0R5wZ2k0RU1jQn5jaxQQMT6ckkOojU45/PUYjB/ODVRkm7ddLhDlv2NPIocaq8ct9Y3hqMg8LH2co5axYqd1sXPg==
X-Gm-Message-State: AOJu0Yx+OvGB7ANmmNnnSQfbVprmDFFutH33I30RyFbTYSvTv3F6D5ts
	g/mG/6dRPS8odrtraK9Qa+ZijcinzTf5Jpz+m1Z8x7hA0sKLDXiz
X-Google-Smtp-Source: AGHT+IE34gX8JBOwnPguUm1i2MnbYns7iVf2oandtz2j/c+iSAlyGV2aNnU07ODLD48qTYE7Q+xPmA==
X-Received: by 2002:a05:6512:108a:b0:52c:e1cd:39be with SMTP id 2adb3069b0e04-52ce1cd3a9cmr11118640e87.8.1719509582697;
        Thu, 27 Jun 2024 10:33:02 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e71329b95sm268354e87.296.2024.06.27.10.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:02 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH RESEND v6 02/18] EDAC/synopsys: Fix mci->scrub_cap field setting
Date: Thu, 27 Jun 2024 20:32:09 +0300
Message-ID: <20240627173251.25718-3-fancer.lancer@gmail.com>
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

The mem_ctl_info.scrub_cap field is supposed to be set with the ECC
scrub-related flags. Instead the driver erroneously initializes it with
the SCRUB_HW_SRC flag ID. It's definitely wrong, but it hasn't caused any
problem so far since the structure field isn't used by the EDAC core. Fix
it anyway by using the SCRUB_FLAG_HW_SRC macro to initialize the field.

Fixes: ae9b56e3996d ("EDAC, synps: Add EDAC support for zynq ddr ecc controller")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index b6bdbc1289f3..2b23d5ef9cff 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -855,7 +855,7 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	/* Initialize controller capabilities and configuration */
 	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
-	mci->scrub_cap = SCRUB_HW_SRC;
+	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
 	mci->scrub_mode = SCRUB_NONE;
 
 	mci->edac_cap = EDAC_FLAG_SECDED;
-- 
2.43.0


