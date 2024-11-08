Return-Path: <linux-edac+bounces-2475-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5BA9C2243
	for <lists+linux-edac@lfdr.de>; Fri,  8 Nov 2024 17:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2321F2613B
	for <lists+linux-edac@lfdr.de>; Fri,  8 Nov 2024 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40330194082;
	Fri,  8 Nov 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leOpUCHa"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93B519259B;
	Fri,  8 Nov 2024 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084050; cv=none; b=X3rN45oHc0E/LFiaKHxGsgrC1Bctjix8opUeQLARiWY5RiMV+TPxZ0H4Cf7K3W0U+BKzC+vYVCGQ5DJLNu8HY8ljCn8NxxtPUKtbvGOJLlx4devIa9/w5AFG0B2fwyVH6IGdWSuDCCLmr23nNO81DO9v9Hx/2v8H4ZoBAp07mvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084050; c=relaxed/simple;
	bh=XstB/DxOJh0mY+nZ9Wa3sD7MLYUdmMNRWMK97jb7eO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OduSeOMi0P4rz2DjRzXCeySr6JJlkWaHu6RSbQ0+9Z0WTCyIJIMQjStFbRK2tS18cUQWkDNrSwXeaeryjHhurD+zCCPVe+/x6DccQFzADuGyy3NjbvLXjjPF2oBrcoSlFLa+jlqXTkMxwja+9K5UpTZ96Gy71MmQP7+uhPpVUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leOpUCHa; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72041ff06a0so1981622b3a.2;
        Fri, 08 Nov 2024 08:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731084048; x=1731688848; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=foAKHueKakmGx21Z8mUk39ZoAzKz8ZJ2u7GMFSwYgME=;
        b=leOpUCHa1ug1FW8esF09tDLn18aDP3dnK5D+brUWbyghKdUzPxjmOrr+187fOlOaF5
         qQ9BhnLfqPNBnMtysZ/Xr7NnMv1V7wcBzvLabGpRrhAOXlcEWhkZw/LCHIA6+uRPSUxi
         tx5iKyuGPNMaFGSji75b5IKzuMGVxkxaFQl0vksjv/0rAbtQfUXM+tFRYQSkeVsJFUcj
         zb68djatl13hKYooCSbMnMqLThynCPzkjGGcezseRug59bMOq06UP4NGaHYN5hW3FRus
         SThFGN/iq9uGTyL4fP1j5tDRxUXeb93okp+7AgKd1LJOqDaAccTpsRIZh1KHyIRN+MBo
         oQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731084048; x=1731688848;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foAKHueKakmGx21Z8mUk39ZoAzKz8ZJ2u7GMFSwYgME=;
        b=Mzc8vT9L7BRv8bSuUgv78CbNxeeUR29sqvUHuslA+O1st0uLISvXOsAbiYhZTmzdaW
         Y2Ca8OOLl/Mu23vZrMTzCBQPBomaCf8r7J5hO05kK99Q6yUpgDkujkgssl+L+coo2v7D
         yqMYy2QhZcg3lDZKHuzZpaSQdPPjcP1+TVEE6l+yJy32FajxT6UrZlE73yYRlItmWKWb
         3ABNckEnUgUBPiSVf+X5QiAbbN/l7Mxj/kYYJSFjkhfI3skGyAgD48kO8+sMQICzwwRt
         l2R8Uidgjp4UPWfABSzU4CoBrJ6foDtCKMfGeVyRQJQ5oXPsycz5lfa1JAqQdH2pUzmY
         RPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Eh+P3kD/xliO+tPmUjV2yCVZ4OnmAyY9dJiJwD+qQ6Lhm7xtsKic/9MCzreyDq8+9fU8bWMVBgtwOxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvhiy/MXIIk6B79aQw1p3EkfGIMnx5sGQBCb+GX547209wmW9y
	qQXVacWr1ayyusAC0LeQk0OvI1qQDmGvg2JmrJ09Pl5v7W9k2Aa6nO/62WyhoR0=
X-Google-Smtp-Source: AGHT+IEh62gVm7iFC2/UDZAZxKq9iUTcruyCuPBxJv+wrsmBDEw6n/LzZ3yawfyfe3/DBDampZ1Rrw==
X-Received: by 2002:aa7:888c:0:b0:71e:cf8:d6f1 with SMTP id d2e1a72fcca58-724132c4d71mr4810778b3a.14.1731084047630;
        Fri, 08 Nov 2024 08:40:47 -0800 (PST)
Received: from Emma ([2401:4900:1c94:8072:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a56a4asm3993154b3a.187.2024.11.08.08.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 08:40:46 -0800 (PST)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Fri, 08 Nov 2024 16:40:41 +0000
Subject: [PATCH v2] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-coverity1593397signextension-v2-1-4acdf3968d2d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAg/LmcC/42NQQ6CMBBFr0JmbQ1TWhFX3sOwwDLAJNKaljQQ0
 rtbOIHL95P3/g6BPFOAR7GDp8iBnc0gLwWYqbMjCe4zgyylQiyVMC5mY9lQN1XV1IFHS+tC9hB
 FfTfNWxqJvUbIia+ngdcz/2ozTxwW57fzLeKx/hmOKFAoM3R005VEVT7HuePP1bgZ2pTSDzn70
 erIAAAA
To: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731084043; l=1751;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=XstB/DxOJh0mY+nZ9Wa3sD7MLYUdmMNRWMK97jb7eO8=;
 b=24Sz8zuhuUFhBvLvAlwgL9dnrayB/T8hZgUa1UnfNG7UcAMVUpfEbGETBAo3NuUDW7UAAiVhC
 mWUrI9qbW/pBYWqfFJz9mnh24LJxJ8gDAHmLO7EIhm80xQMoDFK8E/F
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

This error is reported by coverity scan stating as

CID 1593397: (#1 of 1): Unintended sign extension (SIGN_EXTENSION)
sign_extension: Suspicious implicit sign extension: pc
with type u16 (16 bits, unsigned) is promoted in
pc << bit_shifts.pc to type int (32 bits, signed),
then sign-extended to type unsigned long (64 bits, unsigned).
If pc << bit_shifts.pc is greater than 0x7FFFFFFF,
the upper bits of the result will all be 1.

Following the code styleof the file, assigning the u16
value to u32 variable and using it for the bit wise
operation, thus ensuring no unintentional sign
extension occurs.

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
Coverity  Link: 
https://scan7.scan.coverity.com/#/project-view/51975/11354?selectedIssue=1593397
---
Changes in v2:
- Assigning pc value to temp variable before left shifting as mentioned
  in feedback rather then typecasting pc to u32. 
- Link to v1: https://lore.kernel.org/r/20241104-coverity1593397signextension-v1-1-4cfae6532140@gmail.com
---
 drivers/ras/amd/atl/umc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index dc8aa12f63c8..3f4b1f31e14f 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -293,7 +293,8 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
 	}
 
 	/* PC bit */
-	addr |= pc << bit_shifts.pc;
+	temp = pc;
+	addr |= temp << bit_shifts.pc;
 
 	/* SID bits */
 	for (i = 0; i < NUM_SID_BITS; i++) {

---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241104-coverity1593397signextension-78c9b2c21d51

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


