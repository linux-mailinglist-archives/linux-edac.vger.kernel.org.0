Return-Path: <linux-edac+bounces-5556-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F13C5CB04CB
	for <lists+linux-edac@lfdr.de>; Tue, 09 Dec 2025 15:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F618301A1C0
	for <lists+linux-edac@lfdr.de>; Tue,  9 Dec 2025 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A152FE048;
	Tue,  9 Dec 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWpRFFhr"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC932FD7BE
	for <linux-edac@vger.kernel.org>; Tue,  9 Dec 2025 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765291027; cv=none; b=ChxJsKArE08hWP0kCFoUBl6aF9yeWVY7UJG3fzoZib79xouPCdG14rnyT0iZ9kobeXWpWsyM9zd2xymQR5wD6mi6WOojAVuVN1nnc2jxlL8103tgOXXuTAtTRDSMQ5oiBqAlT59OBJ+I03TZNOfugoQl4xg1dVZfVe81pgm4SHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765291027; c=relaxed/simple;
	bh=78tcxydV4SBExJ6Or7LryivXekE6yAgqLILqLWTE/Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orztubC7nd2i3mgYX2Oduk6w0jECG1lPgVLPym5CgWwC97+jofOGCbqQ4npNwc42ZzCCzDoRaAMD+jpCHkJn4rEpbtDrqmn86HTe9M2PJRTP72MUA5EGuwM5I0hX7n8tCIf3Pxv2Nfq8s8JwN+EE5v+r+r15oH5HxuMaJe78/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TWpRFFhr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso49857245e9.3
        for <linux-edac@vger.kernel.org>; Tue, 09 Dec 2025 06:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765291023; x=1765895823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=boscafpzXl1otazFO1AaYpt0e5EL9yI6zjo8na+r4zU=;
        b=TWpRFFhr96jUhzXX09nZ/jsn769FPa2wn6irMQb/SzwV+IpbzgWxZF9g//4CyZP4/z
         Nk2MEMFNy8HZ/zOHWcHEHIBr4ClEGSejoI4cESzD9gK5HD0I6oyBa288H7dl8Kegifxh
         ffGPhahkbsyi1M64XCPXC7h6tJTDcreMPm6OIz49H84UumoRROyWYLazxFQBmAEeNyEJ
         xJopmMY81QkcVrGfMouk4777BgUpk+6t/yATvq0GS4Toiwy5n+hKtDU2dAe8b/FQg63S
         8FosQSq3kH9TPf/OGFxHPS2bcbYkQWGT5L1xy1cTPb2styyofNrQUHquuGKDperlr9Jv
         7sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765291023; x=1765895823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boscafpzXl1otazFO1AaYpt0e5EL9yI6zjo8na+r4zU=;
        b=auScD16uPx1SqdNAceZuihF7gkIl08wJg6nWoPACNOIIPvP28qB30Fj/u5U37SNJq1
         NXO4TOhbFOargzy/enPayey9iBVQ6ziSzbWYsqT24NTE+uUNPgjR8chthq4xSzMuvp1t
         p8UKfgk6axaiQ5/GU7hc9vAdJfpMY0ovM3qjSqHSt7v/nTBvJFtQukl5h2utirGCcKXx
         1aPfYQiF1OgGpBV0BigNOgLJFPmQa1FAWfC8adcHUBq4mRX3WV74dnEHyWV7EtLFPjJ9
         X4AGmd8IFwMo7ni+Id1GASaiWvYPGNFE1150g48er9G7M1XSbNQltEJ5cqttu82vicOu
         tJNg==
X-Forwarded-Encrypted: i=1; AJvYcCU3I2XWkkptX8gi1r3/jMHdQj+gEkqR077SQ39+PQGtGKAwUN9YXpxq2j28gEj43d672q+R27g8hPh6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5YBgmJEVVuOVkxNx1Ad4CgZostYGv/Pl55f+ZnjvyI6QQHwZb
	MgFJLgA54Sia/0yZ75jbAEomRCbu8FyTCatMz1cfTRxX0VDKZs+B54pSehp9dDltTfY=
X-Gm-Gg: ASbGncubZaxXJZ3MaVN6KsLPoXWKDWccxNulrjRAgtvNT1HCBYG0opKBvDXzTVFF/Tu
	pVg8Ac+D/vs1iGg+LihXc4sCeQFc0DxgmMHLjkZ2lmeKoWvq3yEJKVJtbwWwmdYRVvmoBcbJSUL
	UcLG3dLLbbU00/FHpcCankf33WNnk4LQkQmPcJPRzDLsXoct6x2ZbqmaO13cEaiucpmaY9+SO9/
	0kJbFV+Lqq6HbNUAV/MYx6pqrPlxfQahmylGX9HUnUglqZCNJHk/GNh/biI2sMdNRnWP9q0bRZw
	M3dDt6/WNpz3SJqJpNly/He/Kyxwszo5oEDf567GGbgNBL+wo3d90pbeAMJIM+d6nt/n3fKpncY
	uI4dQKkXoFn5HWZt2iVHk2TQKKNCIXDHkj2RhrZkmjRUt7BrNqa6ZEEDdYpEsmWTTlTq3jh6DHH
	Vqgk6RYcCQEQ0Jg+/7
X-Google-Smtp-Source: AGHT+IFkIlM0pgcGYZe4cwuAz9t38GxlP68bvmxAK/7B33cvhbSOjAmHPVhNBWnpfOQ6F52dDQtWLA==
X-Received: by 2002:a05:600c:820b:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-47939e043d3mr123647015e9.14.1765291022690;
        Tue, 09 Dec 2025 06:37:02 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d682f10sm46389215e9.0.2025.12.09.06.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 06:37:02 -0800 (PST)
Date: Tue, 9 Dec 2025 17:36:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	Aristeu Rozanski <arozansk@redhat.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] EDAC/i5000: Fix snprintf() size calculation in
 calculate_dimm_size()
Message-ID: <07cd652c51e77aad5a8350e1a7cd9407e5bbe373.1765290801.git.dan.carpenter@linaro.org>
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
bytes to a PAGE_SIZE buffer.  But the limit calculation doesn't take
the first 11 bytes that we wrote into consideration so the limit is
not correct.  Just fix it for correctness even though it doesn't
affect runtime.

Fixes: 64e1fdaf55d6 ("i5000_edac: Fix the logic that retrieves memory information")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: new patch

 drivers/edac/i5000_edac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
index 4a1bebc1ff14..471b8540d18b 100644
--- a/drivers/edac/i5000_edac.c
+++ b/drivers/edac/i5000_edac.c
@@ -1111,6 +1111,7 @@ static void calculate_dimm_size(struct i5000_pvt *pvt)
 
 	n = snprintf(p, space, "           ");
 	p += n;
+	space -= n;
 	for (branch = 0; branch < MAX_BRANCHES; branch++) {
 		n = snprintf(p, space, "       branch %d       | ", branch);
 		p += n;
-- 
2.51.0


