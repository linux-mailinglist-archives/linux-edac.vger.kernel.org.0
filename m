Return-Path: <linux-edac+bounces-5550-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB50CA7501
	for <lists+linux-edac@lfdr.de>; Fri, 05 Dec 2025 12:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 520D83021D5C
	for <lists+linux-edac@lfdr.de>; Fri,  5 Dec 2025 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A5432B9BE;
	Fri,  5 Dec 2025 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fq+rOa+Q"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A532BF49
	for <linux-edac@vger.kernel.org>; Fri,  5 Dec 2025 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764933027; cv=none; b=K5QhTsqMSQoDV1Rf9Alqp/NtFVplELMNCATrpY6ilnJluk5rQO9RDOO/lYrNlrtXFiXuCeiZt2cFF5VTc8P5jy+WzD+CQtc3o/jTVmjwFf2epza2crBxuSmSqb20Y2c0i8mE4qhwf63VEJz2Oe3yK9MhMkTCY2f+Rz0V6So/18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764933027; c=relaxed/simple;
	bh=cTaP3uQ/pEL+ga+iy9DqlzB47VJBZvrr8ZoqekBpfaw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DO07gs2M9dGbNcVQZtLsRHt/dQ0UiqWAXkaUIfGzlA8j2IAR73jB1Jm2QjHMngT+kf0o/T0R062nOOv75LM42k0xC5FU6NQg60J79yeVqh+e0KR3QCs/6BzH5Xq2lPwD5sUScrEnW2kbkEYoezru9Qz4KTylaTRGszEPfhRlotk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fq+rOa+Q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so24054035e9.2
        for <linux-edac@vger.kernel.org>; Fri, 05 Dec 2025 03:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764933020; x=1765537820; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMabrmVU5jaPqm7GY62CMhlbea5RlGobfNxDCb6Dgmw=;
        b=Fq+rOa+Qn3s0FwwpiM7keD0xdUi3MoeNXiNRLsbsKgYiyCUg4IgtLH6I7V1j3tlcYC
         zdD3Mox0ICJpJ+fPeajW8KV9ZcSkjEq/CyVEQfmJKG0OhOvsHrAO7sAcbmahmSFWp5jf
         WLQSYhaWJ6D0SIHcZsaDGIOdJ2CZU7rSFfFnroyYOPrcKhtCWU2B5/KA7YeHDQ35g0zg
         /8jOsMaWsVxNU/l6qBhlgZlSlkdQSoxJd9ZJHS5yH6t7oML2LpddXxnytrilAM6kYxKi
         iClyYjQkKZ6515+Ae87dID2g+JsOCPXCz0FoczymlYqsRqL4EIigpF8K3i5HUI4bcB+M
         ngFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764933020; x=1765537820;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMabrmVU5jaPqm7GY62CMhlbea5RlGobfNxDCb6Dgmw=;
        b=mJReizKaeGfdKgya3n2xJZ5L50vCIoKGywifNpkUfXV2U4TDJ6FHHWlTbmVZyRJllm
         AVpLAZG2I6oNmV6H9NhAGo7nZ3MNCI4H5f4zcqkzFd71xDcsd2KVMmrzsw/mdiNCgUwJ
         FBQ/YYVfAXfDnyQIY0jogqYVVcgbQsF+o3HIvZlA+L3X8ZJ2fIaUMNAwvgJL5MPW+H+L
         oo7GFZ06rHyiwqxBeQJsMONMYnU8cueuCg6xvkMh+GjId4z/zhKwN6pnS/Kz97/KYZGh
         C+zQNhuZLESosG4ym16WAR10mKDUP3fuQsGTt3cGWgsMrGH/uEgFsDGawHGXGqjfkdby
         7MVg==
X-Forwarded-Encrypted: i=1; AJvYcCX6VtnXInkAXC3EPQbgdMO4B3veg5GYaTtgbAIOU0dYzYY5KdaxE59P68WgcWPEsnlc2S1D34+32Wq5@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNnxjGbK8CV5tPaMKWW4F8+34MNvF14VIstE2tblSmPFRODFp
	kURmA1kDkCDG+hWPo7uztA/fL3DDsuzDVUuAcQzaei5WNtqcQjVGxVNzbqUaDu1aiqs=
X-Gm-Gg: ASbGncuOEdrbMzJ4cjfS69qrf7Y8nyXNc1EJQH65vBIAz5WJ2Q9WIvLzhoOXErkd4/6
	OErYQVY7SnH2e5s5JWtwydyluEEPTsZ3cZb6lj23R8I6iBXIMN28FbplxAmP+SuzFmA11kgUlw1
	OOsjuShzaplFgHKIpljmqV0wfsgnD3WSBB95rv8Ht37XVeDLolgkPPMAV83OOCQNiOouXpbGGrr
	zxU/eavKzXF0VKyQQ08NNp8Bl28yfOwe9XoZ380wJYoA/iZ5YjG206nLJTIkIdQrkWcarlnp+2H
	oEp2ui84ylNMUVyi3mua9UcvQB7kySkqE6pxhVrws9pYdNR9Fgz6M92u37Bqm6xDqbSeoiLdgnT
	SxYh3Qfr5+sotEpYRFfZzxCLCoyTI9hVOaTXAG8xAqsDgDyEVmViODEtMJBnpq2JLmHw/TiiPgL
	4aHugpzwXckazzkftdbSYmICgC7eg=
X-Google-Smtp-Source: AGHT+IEREuSiwKiK8EKFbQwV5t/3IxHIeztts9FpeYEKYzY9N/1JP404bWiT/KbtFzPB63kwLtqj/Q==
X-Received: by 2002:a05:600c:204c:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-4792f244ce6mr46574015e9.2.1764933019521;
        Fri, 05 Dec 2025 03:10:19 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42f7ca4f219sm7915521f8f.0.2025.12.05.03.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 03:10:18 -0800 (PST)
Date: Fri, 5 Dec 2025 14:10:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	Aristeu Rozanski <arozansk@redhat.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] EDAC: fix a limit calculation in calculate_dimm_size()
Message-ID: <aTK9mKTphPwuR7qb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The snprintf() can't really overflow because we're writing a max of 42
bytes to a PAGE_SIZE buffer.  But my static checker complains because the
limit calculation doesn't take the first 11 bytes into consideration.
Fix this for the sake of correctness even though it doesn't affect
runtime.

Fixes: 68d086f89b80 ("i5400_edac: improve debug messages to better represent the filled memory")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/edac/i5400_edac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index b5cf25905b05..81c93ba957a0 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -1033,6 +1033,7 @@ static void calculate_dimm_size(struct i5400_pvt *pvt)
 
 	n = snprintf(p, space, "           ");
 	p += n;
+	space -= n;
 	for (branch = 0; branch < MAX_BRANCHES; branch++) {
 		n = snprintf(p, space, "       branch %d       | ", branch);
 		p += n;
-- 
2.51.0


