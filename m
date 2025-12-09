Return-Path: <linux-edac+bounces-5557-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFEECB04D1
	for <lists+linux-edac@lfdr.de>; Tue, 09 Dec 2025 15:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41A6C3048D8C
	for <lists+linux-edac@lfdr.de>; Tue,  9 Dec 2025 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3E72FE04E;
	Tue,  9 Dec 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEjQyzbt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88C2FD7D2
	for <linux-edac@vger.kernel.org>; Tue,  9 Dec 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765291032; cv=none; b=tBv02jQh98lj7TZni4CLDiKPiYsAZOZmmKkHEdJSYXmmWySe87gHlHJCn/NLPEAoCydd3Li9zcFqhBGXzL2mK3PwwbMypsyxjpTFaKCVTKS2RFeYZfO17pEFggRiHI7C4U5k62uruGTI4uax4bqXDVWpZlbN5KyKctQQE4oyTWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765291032; c=relaxed/simple;
	bh=jPCiTfm5BtmAyDqz4dpNFWOwHkPHShS71sU+oP4hgYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRyP5i0BPU1GnHCcT9FE0EYeqLedFArp0s6OJoBP+lSRqe2VmKZC17PXkleRh3OSKCInWbCdHFrWS3/Mli7imvIMGv+8L57TFkscU5qx46NklU2lM3obIMWtjT1KoBFVRdqy2/S1qW5S+1HUbawkN0kUGPN8KrR11WaDVFBpJS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SEjQyzbt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a1c28778so72614975e9.3
        for <linux-edac@vger.kernel.org>; Tue, 09 Dec 2025 06:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765291028; x=1765895828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j7I6ils17hDCA2e6qFPfR6Sw1ycg9esI4gXIyqhs7Ek=;
        b=SEjQyzbtS2MrNiTiB0trVfMb3DQbSQn/HpHh1gqp8UWbooQ2t/EzFf+wAyoz7g2R6p
         hCHtntGBwxM4sZVUgSPwGu39ZCAi3LrlXs2QymLs0a3jPPhqEZPZvNLnLIUUFJAHYHF9
         aOA1i8VUqej05wNRgKRfsey2HQJozzVZI1Ph2OYVNMxEYfd25qeQuBBvbKQBXmWcH3J9
         raFMbeVo1zCh7KmuYJROudZarfPGsO6r5Fgq/oIvdIByqGy4F3VeCR/aAffy2nE1blKc
         jZ5lL/P8IDDL7gudgz8TY6gElXjWnGAdf9DVyfq3M7u5CgQN3wZq4RHgueaC7Birv2y9
         jqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765291028; x=1765895828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7I6ils17hDCA2e6qFPfR6Sw1ycg9esI4gXIyqhs7Ek=;
        b=awSbp6ixBmmVVW0qhg+QMm1RbjKJ1y+Rsw+VJt/8punqYswSaSQ8X5tNlUr09Shkdv
         IeGac9F9dNAoqMcuCz/LkSABSznJ5rTdaCgPlrU9Vm6SBWwaF3taJ8JY36QPp6agdAic
         CKeDrRYAPjWnEOlgLMQ0tcBqxSEsFKm5QiRO8sVfNQw7VtEemlZ/kFLouX9gSkP7ssPF
         v5arK9yGkhE+NXQ0wYQI/OQVFt5AVUKsjRAV53133E8t+QjJGyUmBsBx2zH5QxFviItd
         dS4W9ul9Pwz31bD0LcwO0gUQZvi6ldV/+uKAmSDSEWqJO0vLtP7og9oYe0wtVfUVfI33
         v8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbCXD6Ksip266TTDvrUOuO4HWBPDTi7ODHkX3oWn4qzb6GzuyY7wX8Am0eNl52MhbnvV5bvnYIqIDB@vger.kernel.org
X-Gm-Message-State: AOJu0YwnVMnU40il5DoiKgIRKJLZ7nuCW/DuFMh9Z2AwywQD/PDFcVuL
	Ll+JfAYTP2LuXBwbCz+PRe/lX/zISpiO40444+RsU6zjlaeHsvHsddTtzZUs2hQi+iw=
X-Gm-Gg: ASbGncvksb7hvzaE/UHvtL3W1eCcD30JMRPkseIJirTY4ve7Bfd/HixOvbC319pKT38
	78X91N2Of7v3MTs0HtS8kjkofb7hDCvbOMHF1kdmfmthR7DUjVeSi6W0DeLiZAdokNWXFmzrV4X
	SsFW1bzS4G5evVYuQXYb0HU6RqvnAmZ4DGPK4gXvFVoP8aqgEdKDfQP1TptVJ3dkbuMWxzyMCMU
	EaBCV9/Jx6gshVFMk9yKo7WWXUS/wljns8Eg4di8X38qFwB/tMK1Fp9dKtS3YW+wdGOX5QR+vYT
	aqGSed7pWak8bbX7IYzewfedfAQbz+sSkvYxxdLpLpRrziCm+LvI2qNNMh4JAbfW9xktsJCtpIw
	TLMmyt37rmG6vs/djDKczDtTaAbg/Ln59Kyfwnu2n2mtSmtby/IzYzx/Zf/quSZTM72v2ofsWTM
	UzMYSpb50Z7UQ9PI3Y
X-Google-Smtp-Source: AGHT+IHOCArQRCixwS/QxD+LfLjq2i2YGAKLD9OGv4He4/CXuZ3NOgcnnS08tJHh+fDElmffX96jyw==
X-Received: by 2002:a05:600c:a593:b0:479:3a87:208f with SMTP id 5b1f17b1804b1-4793a8720f6mr73856975e9.36.1765291028436;
        Tue, 09 Dec 2025 06:37:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d6228e8sm41449625e9.5.2025.12.09.06.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 06:37:08 -0800 (PST)
Date: Tue, 9 Dec 2025 17:37:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	Aristeu Rozanski <arozansk@redhat.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] EDAC/i5400: Fix snprintf() limit calculation in
 calculate_dimm_size()
Message-ID: <ccd06b91748e7ed8e33eeb2ff1e7b98700879304.1765290801.git.dan.carpenter@linaro.org>
References: <cover.1765290801.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765290801.git.dan.carpenter@linaro.org>

The snprintf() can't really overflow because we're writing a max of 42
bytes to a PAGE_SIZE buffer.  But my static checker complains because
the limit calculation doesn't take the first 11 space characters that
we wrote into the buffer into consideration.  Fix this for the sake of
correctness even though it doesn't affect runtime.

Also delete an earlier "space -= n;" which was not used.

Fixes: 68d086f89b80 ("i5400_edac: improve debug messages to better represent the filled memory")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
v2: Delete the earlier "space -= n" which is not used.
    Fix the subject

 drivers/edac/i5400_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index b5cf25905b05..fb49a1d1df11 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -1026,13 +1026,13 @@ static void calculate_dimm_size(struct i5400_pvt *pvt)
 		space -= n;
 	}
 
-	space -= n;
 	edac_dbg(2, "%s\n", mem_buffer);
 	p = mem_buffer;
 	space = PAGE_SIZE;
 
 	n = snprintf(p, space, "           ");
 	p += n;
+	space -= n;
 	for (branch = 0; branch < MAX_BRANCHES; branch++) {
 		n = snprintf(p, space, "       branch %d       | ", branch);
 		p += n;
-- 
2.51.0


