Return-Path: <linux-edac+bounces-4828-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456DEB833AC
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 08:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCCF4A0EEB
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 06:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180F62DECA3;
	Thu, 18 Sep 2025 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMBaM5eC"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DF208A7
	for <linux-edac@vger.kernel.org>; Thu, 18 Sep 2025 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178674; cv=none; b=u8gw1luvGRl/W1CzZGxr85Ux6SLTgl9OIeMXPLDDo2NzublfvJgxmtJ/Yrpq/9IDGNdSB2d9Al/Ald/yLAg3yyiAwbXcHLDpQwdSfMupXAROFKZyFnFuqWeN27WeV5KJb6Fb2TN8getZUMYnor+oztdjftgIvI3FgNkv5L2Kfis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178674; c=relaxed/simple;
	bh=Pj7C6lSwNgTZXom9kMKSotto7rqPi805M8krrGWhdZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SIu/2kGN912F8uzwjvTERVZKzrtmSpGx9ohjP+xPzSQa+Q06ZFqbZBI2elh2ZkpYZQPg51ghSn+NY4uR+s7LX/ucWNHc60SIl6dZgTC+gkucNj2raJykQMSHXzsafbYm37YXk8USBZnIW1vBO0x9qhfecFxMuUgz+VZspvsOYfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IMBaM5eC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso3231005e9.2
        for <linux-edac@vger.kernel.org>; Wed, 17 Sep 2025 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758178671; x=1758783471; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9/nMa0PtV43rgQWcYDMB+PP5kWaFcHHQhI+qUmHdeuI=;
        b=IMBaM5eCXXkkaM5X/iTM2RP4xSLJSNls5MHlyrEHIEBlRPTxmT1XNvFy5W4Fb1ZeSO
         n9LLFzZb5EJ3uZSxQReC1uf/hf59lpY49SWHfr1dYy7HPP/0FEgvL0BF1tfg7YxHiyHD
         encfkTYbZlU/EMfUcVqI/4fRheExYqHp4HTQmTrTiB+432BWCSc7AC+Kmn5nsQKYv+uL
         DHS7iEMr20ik25cyaw1qZhMxBQRKMtUwYgW33uQOR+VvJi+wM6c6Vo8yo0v+IVEjcmTQ
         13ofajq84GUhImII2ZgrMGaEGz9Y61JsLeIxulXE6xnvP8Jrrb6QzZ3CNHzJD+rLiFL8
         ayzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178671; x=1758783471;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/nMa0PtV43rgQWcYDMB+PP5kWaFcHHQhI+qUmHdeuI=;
        b=UHUkpsnmB4NQ43TuvetIXso9OW4ssZwAkJ0scSaIO+zrx12tbAo3tAqPLZlBW/SKSh
         pcwFZCc2N6mNXWFGO+RbovnDROiVl4fagphxLGM8Zd8xnvX7BSQsj7DA+pYcxQXjLhnl
         Jq0Ez2CKy0VHW8ibP+DlJJYZHg6mqIfXUOiuxFbM4+FOolUB/H5q2NhBUlZcIi9mo6kq
         p/kj7fwHGjBiy0yOhAq371+WRLqXvVnvE7SMSIt1vYzeSF46VBW+HvZCiVqjL4V3r1ZV
         sqiCVTl879f4ari3waVczsmmInpufFkAqn4OpOspNCR1Cpt+e/NNF2PWpsf69E8bg0mI
         qhDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcYc+39gWHU1PvjSGCfeteBc2ZDOCjO0Y7u4uA6ddLmlLxKnbPjGe7Zn9OllgkaVABy55qN8de7qQt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZLyWLS4bm59OkSc8yfS3k/zr2kwHLj3f3FegKFrgyOcqbAcC
	c8Y8Exi8RY73GCntUIX/aH9yIPgVGmeZ/q0951ydHGeCBGGB/a2oEvQEAX2UjImcJXw=
X-Gm-Gg: ASbGncv70XWwJ1ZOhHItTCLMg6BT92XPbRDvfKJDgJYLNJyP0uwl+92nMFhonQKcW4m
	9EJTBNu1OuifNX/LQQyML1/N/u6SfIeM1ilNuvRJAURkmLOInOnsRYWvvPN3whRbaBPtEp0noPR
	9GznxiQ+0Rx8hI15Y6CyDyMb9yly917FVf4OywxY48ZLXeiouP4M88E5pq6hOgOlZR55GsisO58
	YNKdHNSRccI+ViAnDlN84mPJKvH3CDi4dv1Ythc78b4p8owC/27rTEgxEekB3A5hMrJ5jPxx61U
	/Gb3QSU8UgtxFMR7v41BAnDwe7RAtJPSnvYd1+CsaJdHsPhtZjItV7qvqjFftVekFFJCllnb51Q
	gQ1fDDqQM0DxWU1o8cCjq80acwwbiChzeAmtn4HpYK++Oqg==
X-Google-Smtp-Source: AGHT+IGwR8k7r0TQYAu3JvMmJhIKVXCkY8cUsMc5qCPfSU/SkaC0D9hFbJ3u/9HM/gyc79LjqswdEw==
X-Received: by 2002:a05:600c:190e:b0:45b:47e1:ef68 with SMTP id 5b1f17b1804b1-462076af168mr36954925e9.35.1758178670715;
        Wed, 17 Sep 2025 23:57:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45f325c3c29sm56657115e9.3.2025.09.17.23.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 23:57:50 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:57:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] EDAC/versalnet: Fix error code in probe()
Message-ID: <aMuta8vbLUaP_C-R@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code returns success if devm_kzalloc() fails.  Return -ENOMEM
instead.

Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/edac/versalnet_edac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 66714fffa591..7c5db8bf0595 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -888,8 +888,10 @@ static int mc_probe(struct platform_device *pdev)
 	}
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	if (!priv) {
+		rc = -ENOMEM;
 		goto err_alloc;
+	}
 
 	amd_rpmsg_id_table[0].driver_data = (kernel_ulong_t)priv;
 
-- 
2.51.0


