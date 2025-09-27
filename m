Return-Path: <linux-edac+bounces-4940-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F33BA5F08
	for <lists+linux-edac@lfdr.de>; Sat, 27 Sep 2025 14:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E90E1673E1
	for <lists+linux-edac@lfdr.de>; Sat, 27 Sep 2025 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E592E0410;
	Sat, 27 Sep 2025 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mGu+TwSL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8B927703E
	for <linux-edac@vger.kernel.org>; Sat, 27 Sep 2025 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976001; cv=none; b=A97jbTAU6MM9g1GUwAzawWkA1ehOGXNbzTaqVo1bxI8wqIBB3COpzRYmrdRk9G4Bamm5DzK3KZIXfY1SOp4RQ8CtobqyYtmbAG51IykccAe1D/lkdWIezBIKPIJVAOlVI7ryNlym7ml0h/UftMzf9ZQ5qHp5e5ugkdmBqXiHuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976001; c=relaxed/simple;
	bh=rEfNw/hjnn2toGEkd2B+EFMnUNcZZBiV2AONtSPpb+4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q74XzC/5NK565C0A4NsWr1FrXF/XEP4rsfVydgz1QJohH0m0tmy8s0LBJIsyslRIUVVSDQhow0MrrAhs6iG1MuUFz548wrO2GmvCBXjv5RMvFLU8P0QkI5+HDkF4YEV55NDHj+0rfyFDqRh0S7Nq2+SEhM2b4izbLzXD3ATOu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mGu+TwSL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso19403355e9.0
        for <linux-edac@vger.kernel.org>; Sat, 27 Sep 2025 05:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758975998; x=1759580798; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBLrdqiq83IjriqT+j/rod7j6tvQbgPiriXKTGAmd18=;
        b=mGu+TwSLQzam783tObyDcH2rLIFuVGYxNVre9MwoFMsGm0AhR2pZsgD95vGQM2KNwu
         dApDvVTuvreP1qHmXeHzNJTCapqbjEStu9D5k4cBt73HU1+c8COExHZ8dbYVwMpdTEEO
         1K+ZUqFXi9XFq5pBpdkRNPqKpZSvw17B66Qn41yT9M99sUpxsb+GeTiHyE/GQ3F78TmN
         k69Hxq6JsVnpYJHfKkH7NOJaS8KWBUIQJUBfOYQG/2jA5uEQUknDUFtkN7f+t8etLAUD
         YRTm3Mc4F5nph/YwuA0bTRYs7O7tXbUV8b0kk3FuJd4x1XaEjp3Q+k/5XIrzJxfu0qoW
         smSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758975998; x=1759580798;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBLrdqiq83IjriqT+j/rod7j6tvQbgPiriXKTGAmd18=;
        b=ODoqOuNDyAYbpFPJdYj9ghm067qz7fi+ZmQxI867ZxomIFj00dMaUvqbrjrSd4HhTE
         JWqgF8z/IhFvff3iC5dAOlxZVk7YDfKqPVpofuu/fd+v0IJOb1dwsKyOIJ6G/sThdsTL
         jMu0wuLX/69xUAIU2He3xXq+Vh6cxc57bsNpoUTW5U9bqHP+jzyhR3XYcHx4GHbJ0fKJ
         MOdK5OUXYB8flzx28kpJz0AV4KVfNC5P2EQjS00XNMZ3V50b7uANXWMPdHv1lz1ZcXhE
         2bcXumavxcwDZPxC8EXgowbV6WZ8YsX+0wkejx3+LE0ng3HvNsUGf8uf5zPw6MD3VpIe
         48qA==
X-Forwarded-Encrypted: i=1; AJvYcCUEL6igRVrLCvHe4zmKGEzrPGsS20BaGaoGE31qYJeCfMQ5HpIwIpM7NwKKGBhhkipwP86EjLbAqJsi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CswoMK2o9BFccScrmy9dA+a/XJaKEFXKI8MS1TGv90U42TRf
	97j3DVX14xca5kIdtyPr2IPblznMZDIyuAuV+8hNDjpotSNKaMosxk8lOBSEf+QDdvk=
X-Gm-Gg: ASbGncuxeofbEVhTrayxq2Km1/2ItTIGMzdEr6dJxwdEzUmaqW9iaIVUaVLt0zXN/J2
	dqrjs0sDQ2kY6feTFuV1QxtlZHNATFlNOFCnFrCEALq74bHl5TI87KMyjDQHGN/VtYgnP9LoLFd
	fku3aLSBqfm0hTevv2VDVkNpuw3cEklVO5Z9xWAwyWa/AldCln8NvCT2m+Vt4HApxFCDY3hSbJU
	EXJDVoj1tqDCiMhFr/ofvKkteV670rvu5UMPPoGV5zkHtD3G2vZsYU4imH4qyegUzPaNIH/ldML
	gNmCTs7TcK48P38oeUPtDzitDgRQIhv+/DeCbaOJ1zNEW5b3XGrxmKj7QAesIPo4iPpE742P39C
	pz1RBeVbb3Ufqtq7D26U/hgZ1Kc+x
X-Google-Smtp-Source: AGHT+IHAvRpOQmkSxSm6b3328/ZthZojPK7yroebvNA9zjeMtFoBw69S2yXMKcVzb6TG7S93dUplFw==
X-Received: by 2002:a05:600c:c172:b0:46e:37af:f90e with SMTP id 5b1f17b1804b1-46e37affcc8mr86360625e9.6.1758975997952;
        Sat, 27 Sep 2025 05:26:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e33b9e8aesm109617595e9.4.2025.09.27.05.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 05:26:37 -0700 (PDT)
Date: Sat, 27 Sep 2025 15:26:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] EDAC/versalnet: Fix off by one in handle_error()
Message-ID: <aNfX-qj_KpCrnCUy@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The priv->mci[] array has NUM_CONTROLLERS so this > comparison needs to
be >= to prevent an out of bounds access.

Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/edac/versalnet_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 7c5db8bf0595..1ded4c3f0213 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -433,7 +433,7 @@ static void handle_error(struct mc_priv  *priv, struct ecc_status *stat,
 	phys_addr_t pfn;
 	int err;
 
-	if (WARN_ON_ONCE(ctl_num > NUM_CONTROLLERS))
+	if (WARN_ON_ONCE(ctl_num >= NUM_CONTROLLERS))
 		return;
 
 	mci = priv->mci[ctl_num];
-- 
2.51.0


