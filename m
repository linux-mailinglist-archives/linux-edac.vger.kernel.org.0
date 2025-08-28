Return-Path: <linux-edac+bounces-4701-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558A1B3AAC1
	for <lists+linux-edac@lfdr.de>; Thu, 28 Aug 2025 21:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3D97AF9FA
	for <lists+linux-edac@lfdr.de>; Thu, 28 Aug 2025 19:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C443D1D6188;
	Thu, 28 Aug 2025 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbC/Jkf1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581552566;
	Thu, 28 Aug 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408802; cv=none; b=TLbnFrbvPdQEgq43rUKAoqzluGxtULZtIJDuuC7D1VbHbTIEXcIQ5CqVGJTdsjUhltDqhvtdFHfDUq80lliV6BArUAZHa2xFs4hQ7gpaTnbrN/eCfOgmJB6UErLarS9tPfCP/wJx22FB6EvGK/d13pX5zAAl28TZHHTT+5N6Gfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408802; c=relaxed/simple;
	bh=+Gb1pM2FWWlHFqIquLSo5LGWbYvDJRPv78VZs4wpMkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=STb+cQXCv9WH8mCzt4dl5iqFii5MGR+vqcZLNUoeaeDl36UL31HbCkRMGhjlOotKTeIqxK67MNLPc+MShV76+6nI+V8eWHswEhWL2pxYMepuSR7cgcHf/cs7eXvx/Lk0HRcyzTNy534sRvyeT1Bd/WoESS3UWkO9g33vwGFJheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbC/Jkf1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-770d7dafacdso1471289b3a.0;
        Thu, 28 Aug 2025 12:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756408800; x=1757013600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZbjfWviaulURxlkGSeLlj9jt8Nutzfq8t7eym7kFBU=;
        b=nbC/Jkf1fzBB2C2/4nyzCMtX2L6+YqsMLAc9tDtkWtw4b+cGGaNPQMIVVK6dMe9zxM
         4Lbmt6ufBgQcDJBn4tATbRXJgPqiCSa/NOwwFl/juDd+Jmn6wxpyZgVZlRi3fvzSdfH7
         M2DSH7+lenrHKYTQWSFvJLluWcVabnVimRw3srHKgsI0J//BiXuOohlQv0v3tRDyBzYo
         OulzfctkcKJA0zk+jht9LRf+Hpv/3f2bKW4DK8uz7dM2uVCdRaLlIWdV5x2T655AXBcv
         sxB3Wqjd3IAJLg2OpAty4kkA09RMpywgtcWFF/UKINShxu6IuD3FJT4gvj7rVtkgggts
         viNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756408800; x=1757013600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZbjfWviaulURxlkGSeLlj9jt8Nutzfq8t7eym7kFBU=;
        b=TgJNJx2K3WtZ9M8TVdeDdRofsiVqgMjw7uKnIVQPNRvHohvtM4kV+cL/z5cz2+MSKn
         LsJJvK56WymatXF0VH16qiP/47KQa2Yc5Q8dlHHzCX95lIwYkmDzeFJrJJuZfK8v5/iH
         afIIUzEov0+4LWaUjH9LA5M5AzJt6JIVkUzFJrlGiDLj9pbEfzVzCcffwOwc7xOrtOYK
         +wkHif9VqlIiTBiioSHOVyI8bcs1EtRiRUpSzlpepferSi1SYwhvgqwqS15nrCzmNR7a
         WXbfx7K4tYQ+u5BCXc/3+naHGSDbDJg+Q/1ItvGzzyyzxfbvD6XGyhYvqnjlt2lMew0L
         Qg0g==
X-Forwarded-Encrypted: i=1; AJvYcCU1+n5kNyCFZTj85SNij08sXRiUD4nDVvqD7fY0WprjaVDuA7+A2jvGWTuuLHHaOlBsr4YKgY1+3EHz@vger.kernel.org, AJvYcCXs1yr3GzQuWj8AAL5xx6qF5z+XZQ9pI8QNg9wsm+q7HQIIi8QQTJytMhymNX7iRhMM6SzEAi/Bs2q0jAuc@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx6WngYKz6itiu/y1U1/SoePnPdOMpl8MdjAhl5jUAVdhEx6Xx
	lviAiRatV0uZP+V2cGLcJBt897rdbNiIzWA857PZ7tsa6N543xfjREzt
X-Gm-Gg: ASbGncu6b9IDjFv1AvrOMA++stAId1L10d79bK+46giPGPcuIXIqPf5ydSYX61uoPTY
	UWJAE1vsc2KDeLDc6p5+rl4U59aAW/1BatSuEdApQSHws0mPRieZZx7cwMFlluNam7V6FaZsbc1
	na/oSqfprXj1vyMh287i5RM9Vr9ZHGS79tfmvyZZ2jvhEmbjigMbVNXjz9pOQki0sMoG8pfqbWy
	+6FWKGQv+Kmn8RltQg4prFK4RUenFHcCSGr0vts2d9KRvN1FHS8YEQjXoVo673ocSdCMaiYeNp8
	AFqncsPmgj9vCy0xvG8bcqG16ckrTovmGlVjxH2fEnW2ODo/5iprMR/gX+KWlTzrnsRkL9ndWJd
	KiCZ6pQzguIjVVVNGefQ8MpkGxPNCn1rNFzwi5LtGhTBs+/RzECHvxtYECsy5KmN/a3c4Ko2+ow
	==
X-Google-Smtp-Source: AGHT+IFl0Y7QVNFLHZ4+59lfeBIT6/YxI9xoelqYIcxzWB8l82ikCQufFR5vCyV+4qWGUnp07K1Vxw==
X-Received: by 2002:a05:6a00:a07:b0:76e:2eff:7ae9 with SMTP id d2e1a72fcca58-7702fa086d4mr31412743b3a.12.1756408800483;
        Thu, 28 Aug 2025 12:20:00 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1ca7sm194268b3a.71.2025.08.28.12.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 12:20:00 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	shiju.jose@huawei.com,
	jonathan.cameron@huawei.com,
	jserv@ccns.ncku.edu.tw,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] EDAC: Fix wrong executable file modes for C source files
Date: Fri, 29 Aug 2025 03:19:54 +0800
Message-Id: <20250828191954.903125-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three EDAC source files were mistakenly marked as executable in
commit 1e14ea901dc8 ("EDAC: Initialize EDAC features sysfs attributes").

These are plain C source files and should not carry the executable bit.
Correcting their modes follows the principle of least privilege and
avoids unnecessary execute permissions in the repository.

Fixes: 1e14ea901dc8 ("EDAC: Initialize EDAC features sysfs attributes")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/edac/ecs.c        | 0
 drivers/edac/mem_repair.c | 0
 drivers/edac/scrub.c      | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 drivers/edac/ecs.c
 mode change 100755 => 100644 drivers/edac/mem_repair.c
 mode change 100755 => 100644 drivers/edac/scrub.c

diff --git a/drivers/edac/ecs.c b/drivers/edac/ecs.c
old mode 100755
new mode 100644
diff --git a/drivers/edac/mem_repair.c b/drivers/edac/mem_repair.c
old mode 100755
new mode 100644
diff --git a/drivers/edac/scrub.c b/drivers/edac/scrub.c
old mode 100755
new mode 100644
-- 
2.34.1


