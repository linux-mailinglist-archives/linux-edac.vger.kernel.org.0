Return-Path: <linux-edac+bounces-2404-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C1E9B9998
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2024 21:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64BD1C21471
	for <lists+linux-edac@lfdr.de>; Fri,  1 Nov 2024 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DF51DDC10;
	Fri,  1 Nov 2024 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="JUgBzDRf"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5C1D0F77
	for <linux-edac@vger.kernel.org>; Fri,  1 Nov 2024 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493771; cv=none; b=jpjnOJSYXzeqj1pjNjMFUIGeaUYfvYqowgCiQfcrspQXlnGjOfHgU2JUGsa0QSrhrP0mZD5WdcFUlQ2a87ndEWDtpWx0U5LxNWK1umoVHZMJMXM4d3umLyHTFUVdVRVHKz5wr00woNWOWvKP4aOM3L8oPqw4mk9VEiWHKZaej6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493771; c=relaxed/simple;
	bh=3QXy9050gOYncIXE+R2pbTbvmMkR4LrPZbETxEhnc74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuEQw7NE1m2RBBzqws0HlUTeUSd5cUtHp4L3jD9weRecRPj6E1VzItDb+8PBRsBkEkjOjuWmDogR089s6/7SoGQjUCMuOhpap2Fod2b8Iv1UnGMti9L5ryEbKSUoFhr6SYb4eDnm7kTWsWmKZi7Jv2OsfRPWKKkOlCt+VGLIBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=JUgBzDRf; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f72c913aso3949152e87.1
        for <linux-edac@vger.kernel.org>; Fri, 01 Nov 2024 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730493768; x=1731098568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6TrVFfcGXD8kSbw6FXkVrEAKiZNlsByz2hfz9EP2yM=;
        b=JUgBzDRf3VdbAxw602f5AO/cqesxQSXFVjWckNkcsENxb0hC+M0kBU6PS1O56rBgZ4
         s3T48Ytx/pcpKhCMI70dBYAEOvVk6/y1Nn64JOOMRG4Il1athqc9NJhDvAVOa/aXDNqr
         U3sIm15LUMhtsQQF0QGBHN9eiqtHxI3DIivBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730493768; x=1731098568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6TrVFfcGXD8kSbw6FXkVrEAKiZNlsByz2hfz9EP2yM=;
        b=hv5K6zEPb03ZaSNC3eCmGeYWc7u8XQ7inZQTKtvc9xEpBMVpRV2i+sHPQcbEQps61o
         ph6ups7nLBiASbQhKMjb+H3oDHMbjb00Icb/of/djbKDvrlb06uSsPX/3gLEt6Ug4fFs
         U1pDZPvIZ1Ws+qGAMTPu8SZBBCqQwHhtqvKe3H609GhG9fkZJeUgxawsXJI3eSPxqxAg
         u4fXSMwSpgY3KnKP5yHhh4lWAc8ZsL6rPF579pa5nhZxf0gQnBlM5zxXrvCDhsIFioE8
         BEunvuYadfkBmvdjtLMA04VFr9kigx4Uc5AYzkzK0M9PaxBTl0N9oO859nT1LzTWphy3
         9SNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX03rGu+1M1PZvsZoTYsIV2xYOvQYqhZ7TypzqunRvJNla+v2f3Pbh8km2eaclYBF0YYeOGlIIalXK2@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+qaqx/tUHB/uhVrVu6e9O/czJEN+WKQqhc6h2b2Zf8hLfaay
	jFWa9dwfgxBOs83c6omquz0xbRnuFhBMbc2qC2Bv99Z4wHGRR6cq/BQ47g9JUUU=
X-Google-Smtp-Source: AGHT+IE8XHuHUIipKsIjnzsYkrp4r5rPxJ5bBycpbNoE6QMC5hzsweCRTY4meEyGritA1Q0D+47FRQ==
X-Received: by 2002:a05:6512:398d:b0:533:711:35be with SMTP id 2adb3069b0e04-53b348e154fmr12549599e87.26.1730493767880;
        Fri, 01 Nov 2024 13:42:47 -0700 (PDT)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edb4csm25014455ad.58.2024.11.01.13.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:42:47 -0700 (PDT)
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
Subject: [PATCH 1/2] EDAC/igen6: Avoid segmentation fault when rmmod
Date: Fri,  1 Nov 2024 20:41:13 +0000
Message-ID: <20241101204211.414664-2-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101204211.414664-1-orange@aiven.io>
References: <20241101204211.414664-1-orange@aiven.io>
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

And that caused double kfree on the same memory address. My proposal is to set
mci->pvt_info to NULL to avoid double-kfree.
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


