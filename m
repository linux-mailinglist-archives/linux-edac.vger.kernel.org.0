Return-Path: <linux-edac+bounces-4280-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22FAECF87
	for <lists+linux-edac@lfdr.de>; Sun, 29 Jun 2025 20:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F347A949A
	for <lists+linux-edac@lfdr.de>; Sun, 29 Jun 2025 18:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA7F21D59B;
	Sun, 29 Jun 2025 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0c/WHGZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F99943151;
	Sun, 29 Jun 2025 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751221501; cv=none; b=cq4jljGOwoPW+Q7N+rcFcZuxSZJ6w39LoNiX55CDG6Q0y9fulwhlYh6Nwxar7spcpd8GRMopHuWrBtdo/i0dfRjCeGPVrUVAhl9eQCA0Ltdxd7pzYCrxFztqi0rn4JR45p4hEulf2n9aiO3Q5clhI740woeM/28R8bOXcr7vy18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751221501; c=relaxed/simple;
	bh=DhBKlmjLOiyFfEEsVCIlTdKsD++1KdN8yi/Q0MbSXQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKDFkQYrLrRqOFTFzXEC57cnRedW3ibkBCdVZP0dY4xc57X3g+yPwsuEYI1mLszAAfqygSuN9hrTmdvGf1D+tBSYOhL35Y7SbB1kj52GzddEqZq+wKr6FP2WDEcHCe/30BgTxijn9hVU3JjSN+ZH6J+rB5w20Q0JDVBmIrL4EJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0c/WHGZ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad79433bbso13591026d6.0;
        Sun, 29 Jun 2025 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751221499; x=1751826299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PCn0+ucEkRvS1MPOQbl5PoaWNKu1L1cu8L9SbyabJaI=;
        b=g0c/WHGZj+5vR7QB21/5L03uWdjiZXwZyPMplorffBBn4Uyi9JvUkQCQI2LVctsMVA
         w3lJUXlxv3bWxFG6W9SvOSGgLuDgCt/29KiH6ZltB79GRP6/XjwNROZL3WZc3+dH7pDX
         UC1hdHVGImnyxD4F0aIYAjhub2+E/914K9Oxm3dx/T6EW6fcPkMKGVTPEroXkwYqBlP4
         R9+hSvcWIGDcCwyicDQHOKTMbgFR18ivVNyxY1pE5dwJPHnRQ/gbpAO2R2gZndcDFkC1
         1egqlVBl90dTeh/SG65c77H1vy6eVcfrVbbDEkw+x3BjR/H3QHgvlTgFCKX29BJGQAqr
         RJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751221499; x=1751826299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCn0+ucEkRvS1MPOQbl5PoaWNKu1L1cu8L9SbyabJaI=;
        b=j4z9V1Gbkd6qve7EZDx+2vITGicYWzbayWAPxc+ciorfmIC3hBahBulULSJBQYfEOg
         QGgWvlsrgNwIe5N2RagcpetHWgBS9jt8zXkHhZdt7x6zI/ddB+dpz2ACFDn+VzOzoucq
         frB0bLNGI89kqOFjBZgswNpmh0mmJ+SJCtPPONIHMZ2r/1l0uBLC/fMmwXarkl/kAIdY
         eV9uCpepiWmi3aUaEDQKPkkmcwaS/SbyxweCqCS81EpL6hzwKI0ubzliwBnYZWZH9jjG
         moym9swG4N4TzEw4SqAg583pOI7NEh2K8hAnVRXovTBwSCuF6NhGqL1d2Wqek3cG8N3U
         u1bg==
X-Forwarded-Encrypted: i=1; AJvYcCV/X3Z6D4Q49bexs9DmGJqDaxsEmGX+WYhCDw7Lcl3QAXl61Ii/DjpmDi1VHACqeNFqPFOv1nGzuI1t@vger.kernel.org, AJvYcCX6P9IfuAvIfpocZJPuDgB37P/BIqp92w3kK+QXzkki6ntdXkjlCfrk4DWOSJtZ5IOm4Pr/VPJ5gFjyPh2l@vger.kernel.org
X-Gm-Message-State: AOJu0YyIGOCHBH3FhqzALKEcSrI8H2vKXNX5jQy0WMPP1kegLfl4RBZf
	+kyCBPu7rDmkaGA1zgYr0M9R8aAKQ9nLzYCfadjHffJEGh6KvM2w4IJ6
X-Gm-Gg: ASbGncvSB4807UPaKxSonCkfsOHw+4Gq5Zv8Zwj+SQje4VyicerihGukkaPgZA/yjfN
	4vMgjQpuOwDeGJGhDzCQhJu7g8ayY+ZJWEErpkXXwXW80ynGCZxemcpC9ZER3hR+IAAjC3NLHtj
	mZprLBocZZGJDXTx15cN7QOfuzjthqbnZOF16UjRn5RAadpN/KS8qmCa34/+/OEk8c+Re6VHY3K
	rtJYL2+XsLFgkND42K0sS9ABgUf7Yy/I4YS00eu5oS//nn2YDITG/W0hpChdmcl0NuHDgjg9t6c
	GjFjqHkU3+O0vzvoEThkNT2mSyP6sj9vy2uzbyPAA7c0CC+/
X-Google-Smtp-Source: AGHT+IE8ZFa0LSuu03SsIfsP4BI06sEZwP6Jddmvw7w8JwUeW05PDyCVNTa79hGOPUDZS+0Hpq8xJQ==
X-Received: by 2002:a05:6214:2466:b0:6f8:8fdf:f460 with SMTP id 6a1803df08f44-6fffdcfc04bmr176240576d6.9.1751221499271;
        Sun, 29 Jun 2025 11:24:59 -0700 (PDT)
Received: from fedora ([2804:14c:64:af90::1001])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771ab9d6sm55220746d6.28.2025.06.29.11.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 11:24:58 -0700 (PDT)
From: Marcelo Moreira <marcelomoreira1905@gmail.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	~lkcamp/patches@lists.sr.ht
Cc: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/amd64: replace sprintf with sysfs_emit in show functions
Date: Sun, 29 Jun 2025 15:24:48 -0300
Message-ID: <20250629182448.265407-1-marcelomoreira1905@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update all device attribute 'show' callbacks in the EDAC AMD64 driver to
utilize sysfs_emit(). This change adheres to the recommendation outlined
in Documentation/filesystems/sysfs.rst.

This modification aligns with current sysfs subsystem guidelines.

Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
---
 drivers/edac/amd64_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b681c0663203..b6d211255ef0 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -552,7 +552,7 @@ static ssize_t reg##_show(struct device *dev,				\
 	struct mem_ctl_info *mci = to_mci(dev);				\
 	struct amd64_pvt *pvt = mci->pvt_info;				\
 									\
-	return sprintf(data, "0x%016llx\n", (u64)pvt->reg);		\
+	return  sysfs_emit(data, "0x%016llx\n", (u64)pvt->reg);		\
 }
 
 EDAC_DCT_ATTR_SHOW(dhar);
@@ -571,7 +571,7 @@ static ssize_t dram_hole_show(struct device *dev, struct device_attribute *mattr
 
 	get_dram_hole_info(mci, &hole_base, &hole_offset, &hole_size);
 
-	return sprintf(data, "%llx %llx %llx\n", hole_base, hole_offset,
+	return sysfs_emit(data, "%llx %llx %llx\n", hole_base, hole_offset,
 						 hole_size);
 }
 
@@ -602,7 +602,7 @@ static ssize_t inject_section_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct amd64_pvt *pvt = mci->pvt_info;
-	return sprintf(buf, "0x%x\n", pvt->injection.section);
+	return sysfs_emit(buf, "0x%x\n", pvt->injection.section);
 }
 
 /*
@@ -638,7 +638,7 @@ static ssize_t inject_word_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct amd64_pvt *pvt = mci->pvt_info;
-	return sprintf(buf, "0x%x\n", pvt->injection.word);
+	return sysfs_emit(buf, "0x%x\n", pvt->injection.word);
 }
 
 /*
@@ -675,7 +675,7 @@ static ssize_t inject_ecc_vector_show(struct device *dev,
 {
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct amd64_pvt *pvt = mci->pvt_info;
-	return sprintf(buf, "0x%x\n", pvt->injection.bit_map);
+	return sysfs_emit(buf, "0x%x\n", pvt->injection.bit_map);
 }
 
 /*
-- 
2.50.0


