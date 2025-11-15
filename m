Return-Path: <linux-edac+bounces-5443-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93F6C60A95
	for <lists+linux-edac@lfdr.de>; Sat, 15 Nov 2025 20:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7A03A99F5
	for <lists+linux-edac@lfdr.de>; Sat, 15 Nov 2025 19:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204C33093D3;
	Sat, 15 Nov 2025 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD5il9IA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83812D8773
	for <linux-edac@vger.kernel.org>; Sat, 15 Nov 2025 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763236629; cv=none; b=sY+EYKB9i6b/rN0gPVgjxG7cKz4eNHe5bS/5cNwjKjC7Vz9/3lsUggyRwanh4frKp/MROIV9G0YIM1bWi25daxORB9vJggATV1TIZ7wxoPjcxPKd9P4WwtnNT4vYZ8VLy2lYCBoNUJLsl7t+Q9fW17LG/t98n1X4TmbVzxXksDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763236629; c=relaxed/simple;
	bh=h14x8zC5QxurMHftKt1XJQbjGnJABw9gT6KDQNqtnkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saHaRmZUM4Nryst7WthWMf6I3n98Oz2ivs8sHb14QaJSk1NQmXZV/4WpvC91M3C18EKK+RzJ2Ft0NRHP2s5vZwGH5uiZE/Xs6WO1it9Z5/dYdEUgA+KqeWsLB+HGm+W088hIatWv4nXO/QxESwowf4sQR8n8MOgk1GhZa0OWER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD5il9IA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso1010744b3a.0
        for <linux-edac@vger.kernel.org>; Sat, 15 Nov 2025 11:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763236625; x=1763841425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mksjM3tsxyuqSCUmkymuZl2Ln50fdKfMYoQydoGLc1k=;
        b=iD5il9IAS1v6G0j2cRRassdxGed1S6CheCbC0JaCCnCnj0nCnuaFD6id57vmxfyatI
         rWleAtUMWeor3Yp04lRSgo4mufNurAOX2Ir277GtPKlWdNZ8DTryZjSYdDTxLfi9es7A
         JU69cvtpcevm4k0hiMrkUBlrjTA6NA9lcmOcZnJAyQcX7OgSeCj9vIfNVfhvOnM0evQ9
         FwIr6+c21oHw31m4fbx1hNEnCC/Zwjl876pLmpAvMtTlMLZbTqqMzAlikuiqSj56Yt6k
         Uooawstz7rZCw24bythN/8QToXUmtrOiwTkPu1NKJQeHmpGCN7TSSyHZ7fqnJexCJgyZ
         8b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763236625; x=1763841425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mksjM3tsxyuqSCUmkymuZl2Ln50fdKfMYoQydoGLc1k=;
        b=GyzVmh/DZ0uy7RszjQWFsoMGYshL89HQMwWJLKkBhegPfpIu5Um6YozVebi8rlYtN9
         gz6JY42BIxWwmnTc+Tp4JH08Ox+XhH3TQh1O5dC7kFdlihj+0araNIGjN148VYpcPl0L
         I/RDpx5hRP5nesUnSNEdWsRUVrsFW5pVcquIw+oFM5OOvIwBEk10AU9enxSvh+KzVAnP
         B/hqBc31qL9tAnVgHNAlD1Tq+vIl56iMX3uAz6Tgaay0ctyd8ww1EJ1WVFKCKB/8iXBW
         ejvbU3siG9AlX16PT5xOWHqzjLgIcPZnyHMDA9ApURjo9yVOmS4dsLKfmIwn0+tP7qWM
         Vt2Q==
X-Gm-Message-State: AOJu0YyZYJyXTv5CWsRsX1Dzvn9Vmw3wKOTylwTdDNAl1rO8VWQNBhFq
	PVdqpN7MsFesnuc63AHN8lkJHAhHCjqBM4L9rceZy5cVsfwRtTvte2S+Uvk/FQ==
X-Gm-Gg: ASbGncu2s4bWdXf9tmkes9V5/DEsPm6EeosNT2ye1SVZhnrl028pjqvPXnaOzVVtLWK
	mf2wNR0JfLOjHFELAuHqYK5Ke9bLgMgUrZ+Gz1lK3rBk1lLHAuHW04Q6XBrKppIqCgNEnXRBHzR
	v0yefKJ7+Ux/pC4x6Nm/SK+M8rZ6vgLgG9/UMwughM4zYHT77RGqA/Qa4WNrq/wEqAis13kiW4H
	BF62urJdgsfqEv0d6MXGPTZkLb9N8wi4/iTFmaYn1mKIEnivcSSZQwk8njQtXSK/PTTT6F5sgaf
	J+65/gdlXNK9uyY/mzfEKf04MKZPuFhManWvheg8nOPekH5Z5Fo/3QWgZuB2u3bwgnaNB4Ku98n
	7mNg8FRjmoIf6p0QQ/alL1OL0n0Nf+GZQ7vH32gIhITcHkpMLUgtlQmss2pyPQnhFd16S7mIrkU
	CMaJZm4Gpzyyjm1WEl4wDCoedeCw==
X-Google-Smtp-Source: AGHT+IGyeirk1tooo5/rrpc+2Lo9cQ7eNKD65nC/o6Af3kKWUPVhZ/+zbaA1MJYGvC5xyi+uQ8iTKw==
X-Received: by 2002:a05:6a00:2e1a:b0:781:2740:11b2 with SMTP id d2e1a72fcca58-7ba3c085559mr9406575b3a.25.1763236624583;
        Sat, 15 Nov 2025 11:57:04 -0800 (PST)
Received: from ideapad.tail50fddd.ts.net ([139.5.199.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927151d38sm8690624b3a.40.2025.11.15.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 11:57:03 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: linux-edac@vger.kernel.org
Cc: shubhrajyoti.datta@amd.com,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Subject: [PATCH] edac: versalnet: Use kasprintf() to simplify string allocation.
Date: Sun, 16 Nov 2025 01:26:53 +0530
Message-ID: <20251115195653.48249-1-ayaanmirzabaig85@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the kmalloc() + sprintf() pattern with a single call
to kasprintf(). This is cleaner, simpler, and avoids potential
buffer overflows from the fixed-size 32-byte allocation.

Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
 drivers/edac/versalnet_edac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 1ded4c3f0213..c79509b0a464 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -812,8 +812,7 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 
 		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 		dev->release = versal_edac_release;
-		name = kmalloc(32, GFP_KERNEL);
-		sprintf(name, "versal-net-ddrmc5-edac-%d", i);
+		name = kasprintf(GFP_KERNEL, "versal-net-ddrmc5-edac-%d", i);
 		dev->init_name = name;
 		rc = device_register(dev);
 		if (rc)
-- 
2.51.0


