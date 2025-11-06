Return-Path: <linux-edac+bounces-5362-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A285EC3A8D1
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 12:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C45B3510CD
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9978030EF66;
	Thu,  6 Nov 2025 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ejgtQVDm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C79030EF7E
	for <linux-edac@vger.kernel.org>; Thu,  6 Nov 2025 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428309; cv=none; b=B/tVr3oOu0ENoijk4MbwAZqqZ2I2Un++s/63IiiTOUCTl/sCHeuzKieRJNzytBJBes0VH0PXOD8UUFZJ9lHP6YfUezCBQXJgdXr6uFz8Ib2MPA6n3Xo+OgrKL/2650yubBX+bUQ7Ohvq3ISlBZtqxKPmDosXd4MMeTN6+Z73aHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428309; c=relaxed/simple;
	bh=53aEGacbdt9mh4MHgrcdnj49wMl+MBanKoOkq+buiLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQIOnZaifNZmdf3cqJ3Z9miADywnC9ayPgqB/fIlG2zPpNOS5I/I6qOMQelmSKeetSi02352p6MXvJ/3ku6Mfv/YrFRYLx8p/QFqdq80cec0T8yaJxLp3RL0aAqgDN9qro94mfyJGdA86oEDquLMotLX3GwMoaFfKQTG9P8jCn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ejgtQVDm; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47109187c32so3773855e9.2
        for <linux-edac@vger.kernel.org>; Thu, 06 Nov 2025 03:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762428306; x=1763033106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iGj/iSzkfuIyvS/QpRi8dDUcKS5Ee/173QO43nXzkMU=;
        b=ejgtQVDmtduDXGYDlI8HYMEIQCpNaFqguu6t4EvtJt/IXWcwdszsAnU1KhJDqEDxIX
         OoTgptsTRWNujLME58H1SjbGDK6+0QoxSJqIsqPm6aYmxP/XyhF0gMa7tIV/nvwauSgU
         zpp2loXhMyos1wk4m1ndc0UiPCYa5wmrnfZ+/Kzq0awuoSnB5mZl6iHvzvQhPFYDZrlL
         PNhJCk8vfxN8djkAOMQ4ep/WgjeV1zk/4O61X0FrbRgSd4OMlFXZV62As8cWAbWQRtfC
         SrgvWjXLeHA/YA5MYFZ/cR4NaNCSRqlIfPgx50OYctXw9YAaTeiAX9MKrsD6SRfdR5EY
         rCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428306; x=1763033106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGj/iSzkfuIyvS/QpRi8dDUcKS5Ee/173QO43nXzkMU=;
        b=Zuur06m2l4pyWc3qLHToYaabytaF9SCQdPHggLvXmjHQO5DKGUSAqHT9y63K87UIEJ
         ri+1NEfIuzgGX90+aZpJ6YmXbeJ7ctc90f1OZzlVUyPSI3eWy2Aj6S2AofDHSr/6dItU
         TUxqRMrRcgisqkmOrRkOHMnZOYCtcK0l5kk9tpzwfEPSgtGjdmR5eo0ye/XI1gRLTIwW
         8+t54HwCAokOGa5LNlaMlBZWkx18R5+wW4P6yvOce3QMVmHpctVqyl9PunlyfNKJ7pSl
         7hBPch5PdwWw3DadvYzjBZCHHINcvldDOVxXiUPWcHMKFkyOeBcPZnG1Doyj9F7GR4yU
         1V/A==
X-Forwarded-Encrypted: i=1; AJvYcCUJpeEEKokhyLpj3yCDg994v83lu2Me5ERvO8l4dHHyL9P/uSgsOlw3Wf5tvEaMG28S6mGxb3fBEkkB@vger.kernel.org
X-Gm-Message-State: AOJu0YwkVpfYbw0T74FxB4rduaByKbFJIK3Lw4ZLC5by2ye/4EMcOH7S
	EJ6O8A+1yuq8dWbiISZyIKfaotYm3r8s7VqAobT+ungjJoLRdR+E3Q0IuJKAgsO+cVk=
X-Gm-Gg: ASbGncsnomRMBl5xEvytzijYxbATG8XLNnrr9hQLYuUgOtx4bxLyo1YWxN7A/C8gaxs
	zRQW6zvFyQch+OYpBbbEi33tuHlqVfF+3D0yGh3dJh34gDaWoMdZiv5nLxYiQmQJSvQGZM3tY5F
	AyzO0GDy75diqPp9iNBL5/NNCMT2PxZnCsVlwYLDVEEQxFr+qc1r7C3du5f0NFny0ImQQsGdy/S
	+P5ThSGo635w1dtvDHwI5Rt/NyCjaljpmM89JefGz90hydpvQZfKthmdaF0Pzo4nf//04KYRnTL
	koWlNWR0MbTSdUx/YnUliZC6VmRvwabXQmYVXZRErGjO1eDuV4yE8eqLlzESxcNO0mEKCsqKtra
	7cTYGZq/66Pqwauz0+yKV+rzWS7x9pGEPktefP2PN4pJ2KajJxNmAqJW9W64vNFsGqrW9el2LPU
	bg/bDQyT+/4++lRbc3FMmL40D/
X-Google-Smtp-Source: AGHT+IGA3eaiIFQ+2ZbiTA2MOgo0wwCquzKHa49AC8U6KCcMIh1ZnlWSFALO8lJzdAqqAE7UjkdKpg==
X-Received: by 2002:a05:600c:841a:b0:471:a73:a9d2 with SMTP id 5b1f17b1804b1-4775cdc53d5mr54886855e9.11.1762428305744;
        Thu, 06 Nov 2025 03:25:05 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc528sm102956575e9.7.2025.11.06.03.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:25:05 -0800 (PST)
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
Subject: [PATCH v2] RAS/CEC: replace use of system_wq with system_percpu_wq
Date: Thu,  6 Nov 2025 12:24:54 +0100
Message-ID: <20251106112454.124568-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used workqueue is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a CPU is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.
For more details see the Link tag below.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Switch to using system_percpu_wq because system_wq is going away as part of
a workqueue restructuring.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de
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


