Return-Path: <linux-edac+bounces-4347-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD82CB02E83
	for <lists+linux-edac@lfdr.de>; Sun, 13 Jul 2025 04:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FC03BF90B
	for <lists+linux-edac@lfdr.de>; Sun, 13 Jul 2025 02:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FFE16D9C2;
	Sun, 13 Jul 2025 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6JI+mo7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC52F6FC3;
	Sun, 13 Jul 2025 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752375490; cv=none; b=n27R+kgqOdu3rkUN+o9qYDyX5UnegtYJdq+jNuIcW9GnMhInJKgy+xhL7WEce6xbA48bu1ywkOlhQp2V1Grne/AgUP6p5McVPAEUEu8KRRsJK9k//6BPPsDMbwrCh4cog4ZhcpjR6B/jJqQU8rH7jB5P2vfrEJvCtHafDd+G54A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752375490; c=relaxed/simple;
	bh=xbtFIXZjxROO7ga1D6M93qTYNlJF9M4PGKx5/Ru7mA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sV3hRDRmNCFiLb4oqgGPzimz4WB2tiuzpW4B5C0Sp3PwtJQ8kpB3GH2wWbNt7BCItjM3w4jHEe69fdLkizu/2nJyEChgYDMNc9hdT5E1XpbTeGhZTjLwrjRVHPn/nrxoqbRb0TKSytqa7evVtd1qeKTcSnwIR/6tI7qSrUMOxp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6JI+mo7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-315b0050bb5so2394769a91.0;
        Sat, 12 Jul 2025 19:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752375488; x=1752980288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tw7jkBNb9IghpNe9B4u2RQu+0Sh6EF+2KOMYqFn1GY0=;
        b=I6JI+mo7CzECh67aMI2DVlP9e3yk2BsWeS/djaXh57RNppGdLXxNAT3qmV+qEh4oGT
         /dbZOAiE5TtYmBv4KFJyV6TYpEecW7rq7nJq/UdO5y9IWqJa57+hvuBC/AhM71gmho8l
         bxBMTcVdlk6sk28rqpA4beq2+BVdtfiyOlh8bc1Q9PXJuaVhTU6jKQRYG7hrN78dR/Ap
         W0qVa+JjszMNAPTnTS0KPb6HQSVRiVXEr1lMF6BIzyf27kKaj9SK+tdD03Fl/IQTOowh
         Re85CM9UPSpn3hx6CvjSK4sBRaigX05gWsuzHmlhj6uL9CegNjhgJgPQ3tXgTSrxyA3s
         llOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752375488; x=1752980288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tw7jkBNb9IghpNe9B4u2RQu+0Sh6EF+2KOMYqFn1GY0=;
        b=HzdsP56dCRcLZYPy1HEhGARTaRzcKL7jdUVW5gC/MGN9rxu2hRpKS/uC/WsiLF/G2y
         sd5/envkfqYyoAr/aD2AgEAy38bdahkfTljVJ3NzajFaYfjr0JpqQZCw4BY+hasZ9FxI
         PSeYSeAD/HJdoWXu/ob50klccAIR4laOYcwVlgN9rl1jBJwtSo6Hkqe7MEV0HBUAynyW
         PCZNci9M/dGbq94xinvRZE08kdfpUdjE97hw2RNXrzHdpcWdgVZ7WliQZOokdo4SLuzf
         1CESRGiDInBZN9sWFrEaW3ZFXa8ZIc2FDx4OCvs/Z6+jDmTt1Ia6zgDE8nqucXRdkZUO
         E83Q==
X-Forwarded-Encrypted: i=1; AJvYcCVL5Fqdyw1ntLUAZV/WuXdd24+zLzZwE4muOZ9tX/j1FvBpAsLtWUxthsWqtJMQcvwxKxAwr3G0PDY90v1s@vger.kernel.org, AJvYcCViWGi4Yvt0TzooA7P6o394jYt2PFwBYb/whAziqXtY4DZ86PGmcjuw7NOz7Ym/fMLCknMpmfHCg7Hy@vger.kernel.org
X-Gm-Message-State: AOJu0YyMU12NerEOij5octW1p7Ei/jvN8yblvxIdUpEgz7RGLTBOX9tG
	A9n+VHXzvkJPXToaVGWi1x0N1OSqDa1OL1y0GAtU7W7eFqQMKICbpf3Q
X-Gm-Gg: ASbGncvb4JRFGFB2AotFRW5f0DFnJXZifOTG3Ojlu7Zu+dIcBGRSUcPihgY1BHLrJoO
	jpq1UOvYUm6ZC6efZHsVpP9o2cOZs03Kt/mBKMH9jVdS+yCbpIxwJKNy6aC9+EMQ3sbjsf3oqh7
	KijZ/ejbUCxT2uccp/VWPY3REds0wOZQ6zHa6/QE6X9HXUuQU/ZvV8nS4FtlHMo3oz2ryw34Wsk
	pr4xcwxXqO6ue/q/2bEEbY9i/WswMlyl4I7sh+ldBxf0/9M+waTt3KOJbHlrHqpIJQUxhUL2hC8
	lnu7QnnMWJZMzhwQXV5D5WEodxbchCWmeF97menh2WWaxZOyJFO02e2jVCIGrZXx+gMqkl1ahZ4
	/0rb9nCoMVXFcuE7PUmoyxec78Bq3WjFa
X-Google-Smtp-Source: AGHT+IF2MOXgvYcAET/hNfoj/wjPK5AHd17K3y1N3/B3S1mQyy+n9KTcP4GWyxfzMqCR1xEFqc/0Ow==
X-Received: by 2002:a17:90b:3a4b:b0:311:b0d3:85d with SMTP id 98e67ed59e1d1-31c4cca46a5mr13236930a91.2.1752375487908;
        Sat, 12 Jul 2025 19:58:07 -0700 (PDT)
Received: from shamiko.dns.podman ([2a09:bac1:31e0:8::245:11c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb45baesm8318142a91.23.2025.07.12.19.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 19:58:07 -0700 (PDT)
From: Wang Haoran <haoranwangsec@gmail.com>
To: tony.luck@intel.com,
	bp@alien8.de
Cc: james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Haoran <haoranwangsec@gmail.com>
Subject: [PATCH] edac: Use scnprintf() for safer buffer handling
Date: Sun, 13 Jul 2025 10:57:44 +0800
Message-ID: <20250713025744.1091545-1-haoranwangsec@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snprintf() is fragile when its return value will be used to append additional data to a buffer. Use scnprintf() instead.

Signed-off-by: Wang Haoran (Vul337) <haoranwangsec@gmail.com>
---
 drivers/edac/skx_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index c9ade45c1a99..39c733dbc5b9 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -670,12 +670,12 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 	}
 
 	if (res->decoded_by_adxl) {
-		len = snprintf(skx_msg, MSG_SIZE, "%s%s err_code:0x%04x:0x%04x %s",
+		len = scnprintf(skx_msg, MSG_SIZE, "%s%s err_code:0x%04x:0x%04x %s",
 			 overflow ? " OVERFLOW" : "",
 			 (uncorrected_error && recoverable) ? " recoverable" : "",
 			 mscod, errcode, adxl_msg);
 	} else {
-		len = snprintf(skx_msg, MSG_SIZE,
+		len = scnprintf(skx_msg, MSG_SIZE,
 			 "%s%s err_code:0x%04x:0x%04x ProcessorSocketId:0x%x MemoryControllerId:0x%x PhysicalRankId:0x%x Row:0x%x Column:0x%x Bank:0x%x BankGroup:0x%x",
 			 overflow ? " OVERFLOW" : "",
 			 (uncorrected_error && recoverable) ? " recoverable" : "",
-- 
2.43.0


