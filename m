Return-Path: <linux-edac+bounces-2419-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0949BB4DB
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 13:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889FCB24C17
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 12:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAF11B0F3E;
	Mon,  4 Nov 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="sWq1ZFCj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706E18DF85
	for <linux-edac@vger.kernel.org>; Mon,  4 Nov 2024 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724189; cv=none; b=AU8oCHjmIboQ/efTBxtKT44p2MHdTbBA7tMW5AirK8VXepL++EqPDRHDS1bByG1r58kdT3mFL8IWWc6fqmMV5hH1fMIpORha5U8SzOVRyQbgBAUTTTyMSe/TztpXHXQ7uvNgAt3PMVqXNjk2vv/TTW96vPuYSwpo9qKYHhvhAFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724189; c=relaxed/simple;
	bh=y65Z9oR1AobPza3jObL8ZvTUxd4wiVcgtKvXh7x/n68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZhb5jT8nM9qbP63Ym3BkdajpIZD9NWId5y2UfpUuB4KlZfq6/IRKchLWhiT7VD+xy2SDO+c5fnpm5xJNP+Kfs5yEZJgCpTG52wwzeJQ19aPLWfZOrmXeBERxe1ygNtWDgoASXA5KrRbvYpjVHmbD7dh00n07t/NRCkGlqYsJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=sWq1ZFCj; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so3188171e87.1
        for <linux-edac@vger.kernel.org>; Mon, 04 Nov 2024 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730724186; x=1731328986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNTV90YBUHHTjeRnFlpu7gZOlU+a1vOHJ7xyySOcw8Y=;
        b=sWq1ZFCjsT0UCfcos+Fb4V2d1vp8qLVQl3WyJdrXUNQAQFPT4LrycZBLvREN0Wlv0L
         BA3f+1o1VLxLBYa4hJghHKjghEE8CNmMw5VPWqANSIoH1poOnbP1qUUKfZYZnYgrtgQr
         zsFL2dnvB38brlZwxyVXSEBmuA17hwPO/Jbx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724186; x=1731328986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNTV90YBUHHTjeRnFlpu7gZOlU+a1vOHJ7xyySOcw8Y=;
        b=hWwxLXoudiA5Gw4AUs3giH7gkNBVEY6yE/ivy5TUSzGpuDGGyI+0zrg7dZrTKVVWs3
         Ph9obycbu/eILMdeJ8Yd2yzKnnVPIBu4am8hoxRhSwycpvjpzzSEy4dUnENWdhvl2rxn
         ivTYZ29tYeGJQU/fD7UBfqpmOFF5dk5LZtXLlKR6tqCTMrDGfhPVBtG/ESXiqz2/qYGm
         Qjk6izJiby21cQk+hyfQy7y6d+22dO7kl40etdAurynlzwqXzCYu7lealhIyMWBqSx7V
         CtwXIZpCMF1hKQT5xeK/d0CeOoK/vQ15HjiHjOHP83t1I/kwYFjQNvgZJN2trjsBDwyA
         EDTg==
X-Forwarded-Encrypted: i=1; AJvYcCV05PUdu81zF6Y0ymYpx5v3B28+5zazvSYPIs4DUHAh2KaEk5GFGh7rZAVSUQf+FFVAThOHdCAcQyJU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2golRzCWvo17A6qCGxpjmfcXPuJfyYPRH55Rfz/dvn//nio7v
	sFTnzY/e8r9jyVGLCUs8job2cRTbqrQkLDrE/xvy3rD3iIK2xHBzQYs6eLf7UXs=
X-Google-Smtp-Source: AGHT+IEy6uobz47gBvKsl93Jub6o83LrpDnTRo9WUDj6iez5RGxE8Qorg13pXqCkFU93icg9uB8fTg==
X-Received: by 2002:a05:6512:3195:b0:53a:1a81:f006 with SMTP id 2adb3069b0e04-53b7ecf3f38mr9840399e87.31.1730724186140;
        Mon, 04 Nov 2024 04:43:06 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057071fasm60567525ad.84.2024.11.04.04.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:43:05 -0800 (PST)
From: Orange Kao <orange@aiven.io>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: bp@alien8.de,
	james.morse@arm.com,
	orange@kaosy.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	rric@kernel.org,
	Orange Kao <orange@aiven.io>
Subject: [PATCH 1/3] EDAC/igen6: Avoid segmentation fault when rmmod
Date: Mon,  4 Nov 2024 12:40:52 +0000
Message-ID: <20241104124237.124109-2-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104124237.124109-1-orange@aiven.io>
References: <20241104124237.124109-1-orange@aiven.io>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The segmentation fault happens because

During modprobe:
1. In igen6_probe(), igen6_pvt will be allocated with kzalloc()
2. In igen6_register_mci(), mci->pvt_info will point to
   &igen6_pvt->imc[mc]

During rmmod:
1. In mci_release() in edac_mc.c, it will kfree(mci->pvt_info)
2. In igen6_remove(), it will kfree(igen6_pvt);

Fix this issue by setting mci->pvt_info to NULL to avoid the double
kfree.

Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219360
Signed-off-by: Orange Kao <orange@aiven.io>
---
 drivers/edac/igen6_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 189a2fc29e74..07dacf8c10be 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1245,6 +1245,7 @@ static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev)
 	imc->mci = mci;
 	return 0;
 fail3:
+	mci->pvt_info = NULL;
 	kfree(mci->ctl_name);
 fail2:
 	edac_mc_free(mci);
@@ -1269,6 +1270,7 @@ static void igen6_unregister_mcis(void)
 
 		edac_mc_del_mc(mci->pdev);
 		kfree(mci->ctl_name);
+		mci->pvt_info = NULL;
 		edac_mc_free(mci);
 		iounmap(imc->window);
 	}
-- 
2.47.0


