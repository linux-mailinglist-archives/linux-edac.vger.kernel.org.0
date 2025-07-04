Return-Path: <linux-edac+bounces-4319-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF83BAF90F4
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 12:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC5564B47
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 10:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D272EF9B9;
	Fri,  4 Jul 2025 10:55:45 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5933C17;
	Fri,  4 Jul 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751626545; cv=none; b=T5TWj68HTb8oGwTOXgGjDENNthTvbWk9oka87oyoh0oLgGku81b3BBho+3or5tiHVN/GOsMHbUtep520aYfEEi7LA8obW2PjzaJmMpVnCxvVmTERqlxmpLOUr7OIzhtp7aDdLG/ckbgg3Ia/wjZXbMVe8iVR+4BiNrMRsRJwQTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751626545; c=relaxed/simple;
	bh=VHJxjtIueVu95g9CTT4FP5TOJfwkG07w26O/OKDvsts=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dj0jnWa3E7vQsHCiMi87VAM975itI6k8WOraMW5N02/dHA3ZvrsOxxgqeQTRUvhJoEXpE+EwsKTeGRnDLCDMwb3zvtFUdxiKoL35SEiBorhfC6on2OVLwTxgM6M1C8DNp1FCBSsW6fuqBVrorbCHL3o/o/+aXVAygeoyEN917Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60dffae17f3so1350886a12.1;
        Fri, 04 Jul 2025 03:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751626542; x=1752231342;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yv58hde0UO9uLPlUaDiluXjUg7qKqQefSz6dT5yVAoo=;
        b=b/8ZBJAu4R5d48qxxpk1UMuadjGXOdjaaBtgOjoScdLrCxM/vPp/8IVh55Xw71h5bI
         bx0tcnChJTtPlDW7P9YyUj/r4a+kB39sfwSgeGPWZs4cA9qcwCXPE78I7A1BRkWwGutJ
         gPoQGo197akcFRgZDlFL2WodaXcyz0GQ7GKNQfwOVX0M0wIQhdEbBwP+/2KpE+Y/R5q8
         2U51ikzpGKx/nr6Xsi9KVgqxEAe4i4LDusoG0AKZiO546rQaWETH6eADINbQhAZeeVB2
         zUuqR5axSoOJbRnyl1v0Hn8Gs7Iriph38iL/bpPuZLWrHnaxK6s1q1Q39NSWtFPFkr61
         OukA==
X-Forwarded-Encrypted: i=1; AJvYcCV524Gp+A8JXMljo8qqSn/2ll4+5go8U77mQN0kvvF3ZSK3+62SZlpOJXV856WYQK3MlK2d4md9U9fW@vger.kernel.org, AJvYcCVQBWlB4n5RMAG+DLy2npoHbvOjMVryyMRkd298fLGpu+TLUNWG2L04KbUfPTwHs3NGrfNg6z9p62wt@vger.kernel.org, AJvYcCVbPlpBw3SC+C/c7s3G7fOraoZEBc8LChf9AHZ1e8mbYMMn3+W3SrUwyklhyS59e5k5ikC3CqucBqH+xSB5@vger.kernel.org, AJvYcCWlZRpBJLkK7f7Byb5RYG26pTSBy9alhDIkPH6Lq7Nq7xgE3BhtTFiGwta1mtFYSwq5ABMToXl2+Vn3SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Ij+FW+Goy+mk73PDfHyZRxlRcUF8a3YN5rQRpeZd4MwwmfMT
	rvnXkm0ANiSsGr6yaNQYwNnbNhHNsyOwFx2x9RyRLPheItASbqZXmL+A
X-Gm-Gg: ASbGnctvgfJjXuEn+P9sBg94LcsHkU4VcgvsfoFUcLUjMUFCkodSBG8i4SWkntP1o1M
	1AJkrXrV2ATvRyQBXvxdxBEx882qYBbrlKbLLtNJEgPjw/2qyGtDFBiu3lFcVfrJXeWB4PhMSxF
	h3OG37nhfGULH9eCh+1toIcjuoLRyVwyQUrTXHh4CMnCnNIQt+b2XsXGLN8cP9x0g8e6CgJHwPd
	b7Xe3DbpBVcXUREUG5STHoGLgyG7nwCNsQrCL9P9BXaakXtSvEikq7AIk9ZSMXEV4/A3oebZCfE
	9uLrH/oIfTpi+u+zsHjzLSjGmwWv9YTu7nX0HpsAVKmOgJxgHP5MfTdSFeTb8DjJ
X-Google-Smtp-Source: AGHT+IFDLwmmlf2pCDoT/UbXqN8FDaMYsjxO3JDjk+MnIFacPE/J/E3g5iO+lHClwh8fuZSOwgGPiQ==
X-Received: by 2002:a17:907:c25:b0:ae3:64e2:c1e with SMTP id a640c23a62f3a-ae3fe457a97mr167133666b.10.1751626541398;
        Fri, 04 Jul 2025 03:55:41 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d1c37sm153036766b.35.2025.07.04.03.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 03:55:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/2] panic: taint flag for recoverable hardware errors
Date: Fri, 04 Jul 2025 03:55:18 -0700
Message-Id: <20250704-taint_recovered-v1-0-7a817f2d228e@debian.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABazZ2gC/x3MWwqDMBAF0K0M99tAjH3YbEWkpOZq5yeWiUhB3
 HuhZwHnQKUpK6IcMO5adS2I0jaC6Z3KQqcZURB8uPq779yWtGxP47TuNGbX5sD+4dOtv7zQCD7
 GWb//cRjP8weEUURXYQAAAA==
X-Change-ID: 20250703-taint_recovered-1d2e890a684b
To: Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, tony.luck@intel.com, rafael@kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, kbusch@kernel.org, rmikey@meta.com, 
 kuba@kernel.org, ast@kernel.org, linux-edac@vger.kernel.org, 
 mchehab@kernel.org, bp@alien8.de, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3770; i=leitao@debian.org;
 h=from:subject:message-id; bh=VHJxjtIueVu95g9CTT4FP5TOJfwkG07w26O/OKDvsts=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZ7Mrc7V7nLH19ai/Bq48bcC/oEO5w4zubbmIL
 dMeOvdQ4W2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGezKwAKCRA1o5Of/Hh3
 bZPgD/9agbNbYeIcTyFzFhptaDD9QCpNr3kTZ49I0FZ5h0HdEjfkUZT+p7V4WxdgfEG8mCltXoo
 2axTuviofV9XDDbWX68AnY82yQ2JVAFW51xPVBTdawiXLZhiZCknQ14Zj1FabdQtm+rwlsjBOgd
 6so4xlfC+OXOalokgqlL8v33z9W4VI0s6+aBLoJHZilHbc9+xfrf0DtWopIBXJ4wgDxKfaKoJ0U
 Z7h0Y/ecHQsznBIa2yuQPfaR4dBPEfyfQ+eloKtrWWfnS6+OQKCFWOF6hMnspdglnhiAOPbA7Xi
 orM/sWe6gYAAxHtlivlFElALCznCEpcAiXX6qcz4WUHGC6WvUGkQWtVhbzLShJ1fjagy5ji7Ibs
 JKmOv47wMGfrtPKoUHDpgT3NpLXjBvRqpMdY46G6k5qanSWNZWVvfitXnodz5gL+CU1AzS2E5sw
 cSu8edqPYv/nY7CUoez7HiAsvZlVJlvEIosAPl29lfWwLakOqxxEYjSV+w2VsEe5wNGEdOfj3QB
 4YUeuVeNCcVvXg/EYb/F3eHRifywY0rUlFbL3F1UJ4SsHQ1wwlFF54tVcpN33JPCmExfkmO7jPW
 6POmnN3FPIH6Gqet1C6L+64UN6OPetpS6LgcffsOSZTjsxceke+WxLkYLMzJPLnNjXA2N7LJUBe
 NYzjnwTEjy+86xg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Overview
========

This patchset introduces a new kernel taint flag to track systems that
have experienced recoverable hardware errors during runtime. The
motivation comes from the operational challenges of managing large
server fleets where hardware events are common, and having them tainting
the kernel helps operators to correlate problems more easily.

This complement the new MACHINE_CHECK taint that got added for fatal
errors. [1]

Problem Statement
=================

In large-scale deployments with thousands of servers, hardware errors
are inevitable. While modern systems can recover from many hardware
failures (corrected ECC errors, recoverable CPU errors, etc.), these
events causes the kernel to behave in very different ways, which can
cause  bugs due to the path that is rarely exercised.

I experienced this pain very recently, where several machines were
crashing due to a recoverable PCI offline port. The hardware was
behaving correctly, but, during the recoverable process, the kernel goes
through some code path that is rarely tested.

In my case, the kernel recoverable process caused some issues that were
hard to find the root cause. For instance, recoverable PCI events
cause the device to suddently go offline, and later PCI re-enumeration,
which would reinitalize the driver.

The event above caused some real crashes in production, in very
different ways. From those that I investigated, I found:

	1) If the disk was going away, it was causing a file systems
	   issue that got already fixed in 6.14 and 6.15

	2) If the network was going away, it was causing some iommu
	   issues discussed and fixed in [2].

	3) Possible other issues, that were not easy to correlate, such
	   as stalls, hungup tasks, memory leaks, warnings, etc.

	  a) These are hidden today, and I would like to expose them
	     with this patch.

In summary, when investigating system issues, there's no trivial way to
determine if a machine has previously experienced hardware problems that
might be contributing to current instability, other than going host by
host and scanning kernel logs.

Proposed Solution
=================

Add a new taint flag to the kernel (HW_ERROR_RECOVERED - for the lack of
a better name) that gets set whenever the kernel detects and recovers
from hardware errors.

The taint provides additional context during crash investigation *without*
implying that crashes are necessarily caused by hardware failures
(similar to how PROPRIETARY_MODULE taint works). It is just an extra
information that will provide more context about that machine.

This patchset focuses on ACPI/GHES, which handles most recoverable
hardware errors I have experience with, but can be extended to other
subsystems like EDAC HW_EVENT_ERR_CORRECTED in the future.

--

I would like to *thanks* Tony for the early discussions and
encouragement.

Link: https://lore.kernel.org/all/20250702-add_tain-v1-1-9187b10914b9@debian.org/ [1]
Link: https://lore.kernel.org/all/20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com/ [2]

---
Breno Leitao (2):
      panic: add taint flag for recoverable hardware errors
      acpi/ghes: taint kernel on recovered hardware errors

 Documentation/admin-guide/tainted-kernels.rst | 7 ++++++-
 drivers/acpi/apei/ghes.c                      | 7 +++++--
 include/linux/panic.h                         | 3 ++-
 kernel/panic.c                                | 1 +
 tools/debugging/kernel-chktaint               | 8 ++++++++
 5 files changed, 22 insertions(+), 4 deletions(-)
---
base-commit: dc3cd0dfd91cad0611f0f0eace339a401da5d5ee
change-id: 20250703-taint_recovered-1d2e890a684b

Best regards,
--  
Breno Leitao <leitao@debian.org>


