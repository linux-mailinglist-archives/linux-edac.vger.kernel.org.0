Return-Path: <linux-edac+bounces-4558-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA415B227F4
	for <lists+linux-edac@lfdr.de>; Tue, 12 Aug 2025 15:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1DA1BC0D69
	for <lists+linux-edac@lfdr.de>; Tue, 12 Aug 2025 13:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183EA1531E8;
	Tue, 12 Aug 2025 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G96g/vXF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94041178372;
	Tue, 12 Aug 2025 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003726; cv=none; b=GQ98l2q5SU4KWz/cbVvqi42O86OohsgeKxh1XzlUyXXKd7cnZ77OB77zG0hYG6zkS0bLCj48COimtySOrJmqrITojKS5q9M+AFN5+bMk2ixgiQkC0S/6u45Rp7DTcGQvRvI42VkoJ31OtQ254u4T+KmgEr5fXr09EWxXwO9vCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003726; c=relaxed/simple;
	bh=Od72EQBv4JGDTn0Y2Ei/6o5RTBJu3gYZKCJLW7yYpAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eYbToWNBKROkGyh3OhKgY55n5G8lp3R6iOkbDCFU6bX4XYO2VSzZKr/zzBhhq3tqc1bWb/ubdb/41Ne/n6y2cQ1A/ASeVPwNjyn28FytRJSwU4mNcKLXPx0w24jXzU5RaZqdiUepLgGOc67Fg3z7Rhy/CWdgLwPVInbqQzj13Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G96g/vXF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76b8d289f73so5024511b3a.1;
        Tue, 12 Aug 2025 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003724; x=1755608524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hTXlWUWgmGkbw6/R3L/8BNWjTwh9g+hdulCTYEuUKJU=;
        b=G96g/vXFgmqMl5+tzeYquBHSb7xixKnTe36mgsE3BqSMjx5Q4jOrazEaKnw/g69mMe
         GG2gTzZTRIUBwwJ33gyEbrNo3wuEdoqY7jXp2TZVzD2fspS9s0HCtvWlYYqqW7LhvOwx
         LCbuUrUwKoQPMVty0AG2937VC1ye97cM88d59mb5s6arJHYmnWEPoepEvI1QCd8pnutd
         Jcdc2dtGM4x6In28L5dKuZktkgkhI12E9bsNtH7SSc5y8Dm9OUnz+0siWQIteQdBIGvx
         gIuxgK8vc/7xX/799Vu9fl8/e/Z2Bkyk+tbKbKUOj/akh/jeocCDUGyTADjPqi+2atGU
         AzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003724; x=1755608524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTXlWUWgmGkbw6/R3L/8BNWjTwh9g+hdulCTYEuUKJU=;
        b=vILTGiyrShFA7UCudaaf/OKxNwdpsecxtPdNzHhDwZuInWwVDe51jKwOtZFbI4EfLz
         tyBUWQ7TK9Br2DQwntLTIPJreNciH3iKOBJyQ/422jFr0unjix1WdBYsI9ygTIzWzFg8
         csHxcS3OBXM8CrUEJhyRfhTyF6JqQJR5xayYydjWbRDb3KjGQy9ysGm5gnPstN8OQWUL
         WqxNiM7uL4WlFteaFnVl4023h3bZKt1wgorhYA3gT7lTzTW5NsakxZKmH4zFIMz6g548
         qDcMkcpKIt/gGaLnil+cQsHnqScEsQw6c/2cYYsdVGSbdXKVCtn/DEdK9rLCrugIhbon
         TIhg==
X-Forwarded-Encrypted: i=1; AJvYcCULyoW2qje+xsh796R8zkMtorDHrSMMBFtvXh+20oQCDklIouXUOP2o4gF1pzMhEMWHg0YrfS2DrxyK@vger.kernel.org, AJvYcCUzpWsmo8oS3e1dSQgK5jfivNGeBikyh43KBIy5ADTLT1cQo6qj8mOGab/Ei4VdVAeX7TdbEZwqDB40yAm8@vger.kernel.org
X-Gm-Message-State: AOJu0YxwfjIIpyfQIP5W7OkOEgf+FrO/nhaUVWHqLQa4hLN7orBbpnhq
	S6oN/i4fGVoZ2krcvoTeyBWVEqjqITb9gSyi/V4/22WuqkyprYQTVc7T
X-Gm-Gg: ASbGncuGEwTmwEe0EluR0LVMdHi6AuTFOJ6YztaxP4UU0P98vRNb38Yp1W70la+q4Ce
	9RXoPTv2hyNdF4LYy34GhGZSQmORQ7lZxoaZDlcxhahUzHssfKBwrKyfBnDoUnTq/xKgl5r1i7e
	r7n0VL3LqtTy8KFHT6RCRNsiV4r3NrLHfLsYPXo7/B82jQ+KskA/7YXO248zm8AKbOwM5i2Ondk
	8bUEY5m+nsa/qfDA7Pi1yon/MhWwZ7hA8QsicWl1os9BY9h0UFfKabs7UpYMReOwWM5lvHQQly1
	ZAA+gdf796byErI97WTlrVi26/sMMia/vOgjTRcGTYe2tYdQnQUT8RZ3k3oXtDvxfao2nSuR5Sj
	+99m8Ig6TPENFdCqxmQQJ3y7XL3eKb7hnjW0KgsJ2/kR+cp8g
X-Google-Smtp-Source: AGHT+IEfj3f4ctl/apnhfqtH5DFUARmiRo+9eePYi9dZvWb7zWEVyJBVpYHA+kDolCUljLpGVlr4pg==
X-Received: by 2002:a17:902:ec82:b0:23d:fa9a:80ac with SMTP id d9443c01a7336-242fc2c9e78mr45597505ad.16.1755003723081;
        Tue, 12 Aug 2025 06:02:03 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:8898:77ef:d42e:3af1:d5eb:7170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b5f2sm299105125ad.125.2025.08.12.06.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:02:02 -0700 (PDT)
From: darshanrathod475@gmail.com
To: bp@alien8.de,
	tony.luck@intel.com
Cc: james.morse@arm.com,
	mchehab@kernel.org,
	rric@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] edac/amd76x: Remove assignment from if condition in amd76x_remove_one()
Date: Tue, 12 Aug 2025 18:31:54 +0530
Message-Id: <20250812130154.2220684-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Darshan Rathod <darshanrathod475@gmail.com>

The code was performing an assignment inside the if condition:

    if ((mci = edac_mc_del_mc(&pdev->dev)) == NULL)

This triggers a checkpatch.pl warning. Split the assignment and the
check into separate statements to improve readability and comply with
kernel coding style.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 drivers/edac/amd76x_edac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd76x_edac.c b/drivers/edac/amd76x_edac.c
index 2a49f68a7cf9..4937d8728cf0 100644
--- a/drivers/edac/amd76x_edac.c
+++ b/drivers/edac/amd76x_edac.c
@@ -324,7 +324,8 @@ static void amd76x_remove_one(struct pci_dev *pdev)
 	if (amd76x_pci)
 		edac_pci_release_generic_ctl(amd76x_pci);
 
-	if ((mci = edac_mc_del_mc(&pdev->dev)) == NULL)
+	mci = edac_mc_del_mc(&pdev->dev);
+	if (mci == NULL)
 		return;
 
 	edac_mc_free(mci);
-- 
2.25.1


