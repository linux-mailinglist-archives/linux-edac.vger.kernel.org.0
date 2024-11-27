Return-Path: <linux-edac+bounces-2636-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCBE9DACFB
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2024 19:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0EA16541A
	for <lists+linux-edac@lfdr.de>; Wed, 27 Nov 2024 18:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0A143C69;
	Wed, 27 Nov 2024 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtNXuNL0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726701411C8;
	Wed, 27 Nov 2024 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732731835; cv=none; b=d3Kn3tlX1KE6aWqJAbsm//l2EfpZ9PNk4e4VkxbqERxAOQ7+ygIithEi+VSkrCGDFV7P9crzmO/iADXMimAPDnINxjj36QERW6YmfSSYbMzF0q6qw/DmNQL43VEcJfMMscBCn9TGMt45p9ltZmVK0SODnR++w58C9m7W+oInyOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732731835; c=relaxed/simple;
	bh=nqY3XKqq82zCVRmRiX1vvi91gdgVOWxrcHDjUg95vlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GaI5vxisrprm2wHZAYKCPGRj5gI1CimOubwik5BDPEd0a6l7L2BQfZhdJPlfWgjBdZ7N71ufDpvvfR7VIU75Gf8qtiVWqiw9d391aqv9hSI89baDzWSwzC2mwoAVfvHJbcX5q9yDAJhWebjH1HiQUkxpX13s8vUpPf0zOXPWZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtNXuNL0; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fc41dab8e3so1906797a12.3;
        Wed, 27 Nov 2024 10:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732731834; x=1733336634; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MhbjOhSw9bmSU0IrT8HRJZKc0AbESPma/xN/rGk5Dls=;
        b=GtNXuNL0mC4XGiPpH7STs4CBGGMsL4sk2jcnZozLRCoO+HFjfJGi08ONQiKKIcvOa5
         YVnkiMEIPJfMF1DtmQ2HIG8rnvnClwJaGroZT8cfK9K3MCvGkvhT4aISTTLMl8CC256+
         AAN46m/LUqvBiCUPffHP5mtsKOBWZ20FVhWEmGQ+lItP6eNAwIsZfLSsBRihlJJ5tZSY
         jYxnTUpnvjAtjYCncNNGlsr9VKonVzhEnbizLdEE6KDm5402sqevMSGThLfNQ3LNls0k
         Ii73PFqCZFHLJoYavu41xhAYb6XxYFrklqLwP9ZpRK+/oyNwT6o8cjMrZmLs4lTdWuEN
         xnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732731834; x=1733336634;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhbjOhSw9bmSU0IrT8HRJZKc0AbESPma/xN/rGk5Dls=;
        b=H9W9CY8VySmeDkhHsr8hzZqfVjQAlzpOJFq7m44cgK+AnURuECZI/iriXnkQwBrQ0F
         fVpiqHFPKRse5jzWfSrKe3EPMH6G/MhS9Egqp15gpRn+MKuMCXqxy2IeuG1pjDcxx9H9
         Fad9/QL6k6lqga+oJkjhpbZhlYjFw3ACQwbxNEyQPR940TLRYynzBR1ClfOce7m1eIZX
         4+uUKhS5iBO4gbu4UT7Ov7W+XBBfXGojvVPE4/H4H6kynveTRkPUzE4htsg8fsErpDPC
         FZb3HtWv3MbiIEQEcxlut6WeELcyvpHRWI78D/76Y9vv5Wu2+MDcdrqR2zmZacRrut3+
         qtXA==
X-Forwarded-Encrypted: i=1; AJvYcCX2zWKGK2O3r/mIGSPe44u2R3Zx6q+CXubXVoOGcTEa6FA8yNgTBaBneHe968OxMlI2kMjdFHKUs6PPvZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhuI9hez9f5X9Ge2uuCWbhve/rcPMg9jZhuZ88mUzBR07ZbRbd
	NkNDG8qewspC+Dag2BAbwSbR3X17dKJ7/F5ArBLdoWVEIo8g8JJ8
X-Gm-Gg: ASbGncu0ce5f8otc696PK8wpiFq07y/n+Hqx1Zc4zUUNftS3eh1lEJGVW3FSN3HNGM8
	Awv6/Qt4ggkbiBlqOW2NCz6SQUmYYPZjqACJMfT+u/0WHZRQ/H7nERHfqdzPRk/5FhTr9VpGkSp
	5y7YXNHaXkM0+Bmwu9GAaZGZOwa7DAs157O7J4xSmkqsa/6CcW7fuvtjXwSln3bNj1prI+fnDFs
	NbzgzLaLi+222Sc7V5qjQnsMGeljvKoAVbg1rMnmmc/JDnh
X-Google-Smtp-Source: AGHT+IH0r0ggi1GfWVYXvHZfo+fIpsOo7NxOnPEkkuiPnrGr6DK8YkEgSvvMeOdzD18nW5c/WjjMkQ==
X-Received: by 2002:a05:6a21:789b:b0:1db:f68a:d943 with SMTP id adf61e73a8af0-1e0e0ac3600mr5379931637.17.1732731833671;
        Wed, 27 Nov 2024 10:23:53 -0800 (PST)
Received: from Emma ([2401:4900:1c94:da7e:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724dea69e96sm10522011b3a.73.2024.11.27.10.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 10:23:53 -0800 (PST)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Wed, 27 Nov 2024 18:23:48 +0000
Subject: [PATCH v3] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-coverity1593397signextension-v3-1-60dd0c4287ff@gmail.com>
X-B4-Tracking: v=1; b=H4sIALNjR2cC/43NTQ6DIBCG4asY1qVxBvyhq96j6YICKkmVBgzRG
 O9ecOWuXb6TfM9sJBhvTSC3YiPeRBusm1KwS0HUIKfeUKtTEyyRA5ScKhfTYl6hEoyJJth+Mst
 spjykTavECxWCroAk4uNNZ5eDfzxTDzbMzq/Htwj5+iccgQLlqpOmrhgCL+/9KO37qtxIMhzxj
 LU/MMyYVLpjom416jO27/sX9GMeqxUBAAA=
To: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Yazen Ghannam <yazen.ghannam@amd.com>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732731829; l=2033;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=nqY3XKqq82zCVRmRiX1vvi91gdgVOWxrcHDjUg95vlQ=;
 b=7i0NIeqxKrUDd4FL+0K1zSoJrOmAKvRWIqEZBRwN7FHm2nyeL8lSWK+w9FGdStPSmTmRIQdfG
 O7QwLyXGrHtBBAeIgp6Ru/u5ykJx9GVhxHKeYnAxp/icH45Tw2UpfdE
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

Use u32 for bitwise operations to prevent unintentional
sign extension by assigning the u16 value to a u32
variable before performing the bitwise operation to
avoid unintended sign extension and maintain
consistency with the existing code style.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
Coverity  Link: 
https://scan7.scan.coverity.com/#/project-view/51975/11354?selectedIssue=1593397
---
Changes in v3:
- Updated commit summary log
- Link to v2: https://lore.kernel.org/r/20241108-coverity1593397signextension-v2-1-4acdf3968d2d@gmail.com

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


