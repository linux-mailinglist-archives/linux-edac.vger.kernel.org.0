Return-Path: <linux-edac+bounces-5347-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AAAC36A61
	for <lists+linux-edac@lfdr.de>; Wed, 05 Nov 2025 17:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA84C500BE6
	for <lists+linux-edac@lfdr.de>; Wed,  5 Nov 2025 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9233554E;
	Wed,  5 Nov 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fEwgo+LU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83352335541
	for <linux-edac@vger.kernel.org>; Wed,  5 Nov 2025 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358912; cv=none; b=ts0eaHC0KWAN33VDFx2DBfZdWYgFtsWMu8lcj0Ryd0cOwx9Ep8KpfGpfiqHJcrjex7r2cHb4L94viLBMVQPcZsgrX8FTAIDaDaAX3kUrNjsBPr5FAFwb8uaBR3lzEYAsyIvMgGx/WkLjmt3ZW/2hVYqbIgFYgCqZRnpOqT86j0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358912; c=relaxed/simple;
	bh=qhthCQOxbmIIKyNheM8Rnhvvbyw9VuqTjkGB1Gw9Shs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WvqMsOWMcxJQl9BpdQlQleHY8w8wdikFjczfShSadWzQhBJzpmVUJo1+mfmGW8z/l4CJ75wN2VUtWR0UGsycRhcJKFQuMXloBJNW6CYsfCQ6vSdzlX5DFy9M/3q/SEazvZ2qExEg1Vv8bc+yFgZhYWG9zg0w4o4gPBLfRKQOQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fEwgo+LU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso15422285e9.2
        for <linux-edac@vger.kernel.org>; Wed, 05 Nov 2025 08:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762358909; x=1762963709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1yBP/HblraJDKUqDJbJpnQ6bTQTPKGimKm7/HBY3uI=;
        b=fEwgo+LUn1JIcmd4fOYUTwR/jPimwMGMx0wEX7Hc/CiCGID2bxFmLcRF2vAQ4ixGRD
         v3W1vhr9T+VMgKDSjrCOBPRBdMs6oEnvAu2TCnPt2wHuReJC6P2H5f4kQ1cCQFTFmuxR
         55Ri/CMrj548FjVwNuP7XLbojQoAVmpE8o4j8++vWLBbPz6yMpvQHX0pYQTYL4c+7n5H
         3c4HFURCYdWYEvexECi5lh4/xTFl0ZWasKshkkVFH0PjKBQ8MWwTBqJvMZzFcQe56fJw
         m2y4P9oKPtz4n+dT2IsktVgBKz6X/9zn/cq+edt0c7U8+0o68UmmgHaRJ04J4tewnpwp
         NHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358909; x=1762963709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1yBP/HblraJDKUqDJbJpnQ6bTQTPKGimKm7/HBY3uI=;
        b=gNCiLmBPB3XB0Q4Ek/PJ2Dg1T0xBCdNzCFywccQFQ70lofkXm39+fBKTurg01KOeGt
         tfnDkO1JkFa7MyV3PhhsOKhZ8fsa73fKnv9mTykdMA2Y0fgzzg5vBBWREfLkr9qvX33z
         6aIe81UvZMNqVc/Tu6cET7Sq6G3DQID74C++3cMWhZR1PirHV7e/8YPH78YvZ++1/9bf
         714YC2k8BJSSsKLIkVh2ncXEigWBYyF6AjBV7yhjp2WrPqEsryyMEvEoSoMyAPAhwmLT
         93FZjpCB8H5BvsfoVueihHblBcuFaKY3gND+pd4HpSTrNPNI9hgpaC4OeeoLmsOUqLZs
         sD+w==
X-Forwarded-Encrypted: i=1; AJvYcCXdhDdEkZ1+2WfVaiOB2TRsexhj/dp0CS0kObn9avQV/xRHXb0y6TjtgB0b5ZP8gVAXDN/88oYU07T5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+RLA8E48yEvKKK5m3lnH4FwMPK/orA8ZT/mkA9VKft3Knfeo
	y+9alb/ag3HERfNib/17n4wWDGovgLrw8BAS6HEBJrr+k2TSzjF6TvZ2xSzxNwxwPsI=
X-Gm-Gg: ASbGncv6BIlO4fXIk4A2I96dxrsgAxUZx1W+XGIrKDbns+i6FAjGEniQtpPztSO+FVO
	2hLsb1AnBQR3PttYhoZ+455RnHzko6umVeJ/Fhl0SfItIzC4079GAn+SFFfuK2DV8KMTA6r/eWS
	tUIqfkrzWVE4rZAl5AHAOVuRLujQFSgk5sh0FFsLZe98ZpzDVxugPT1+9jMe7w/5FhdH7I33pyW
	jul0HGeZoZa2vTw//qg89WxUM3o7oHROKjLVf4qtZiDOotrFgHxQZe4V80JIDiNy2HNMJB0Kxp7
	ID0EIuGjLBc/nz6lEubMpanoob7D7KkQu0VwuwQWtW1B8tHJ3mZ+GSBb+81/BoSxuRvkIF3ai/6
	ID/2Yx20dATlzJ/e2Zw+6l/9wjucaKxqlYNSUWAfM7p73qrvO5Gur7Zag6p5VZEVEE7X5bkH/Nj
	RWotrEjEJoqTVRziMsCDoOG5c=
X-Google-Smtp-Source: AGHT+IEXc55RGqBKbQMEgoEC9e3feBi0MKsyQiqEKNba7Kuda4jmUF2LBb9/lCW7e1CfbTQzDss9Iw==
X-Received: by 2002:a05:600c:621b:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-4775ce7dfcfmr49120665e9.34.1762358908612;
        Wed, 05 Nov 2025 08:08:28 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc552sm58255715e9.6.2025.11.05.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:08:28 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 17:08:19 +0100
Message-ID: <20251105160819.302988-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Replace system_wq with system_percpu_wq, keeping the old behavior.
The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/ras/cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fbabc..15f7f043c8ef 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -166,7 +166,7 @@ static void cec_mod_work(unsigned long interval)
 	unsigned long iv;
 
 	iv = interval * HZ;
-	mod_delayed_work(system_wq, &cec_work, round_jiffies(iv));
+	mod_delayed_work(system_percpu_wq, &cec_work, round_jiffies(iv));
 }
 
 static void cec_work_fn(struct work_struct *work)
-- 
2.51.1


