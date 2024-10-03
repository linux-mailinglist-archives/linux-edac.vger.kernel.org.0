Return-Path: <linux-edac+bounces-1961-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBBA98F70D
	for <lists+linux-edac@lfdr.de>; Thu,  3 Oct 2024 21:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF255B219E0
	for <lists+linux-edac@lfdr.de>; Thu,  3 Oct 2024 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1F01AAE0C;
	Thu,  3 Oct 2024 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lO9Qx4ph"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966241A4F11
	for <linux-edac@vger.kernel.org>; Thu,  3 Oct 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984040; cv=none; b=qt+5jXPN11/uZLUxXjBmTr/L30e7kuPk1YxSHMLMCh9ZX9Y+YpvmQ5JU5tfUuOnYnGBmhTZncA3kYhZeeltqxA8/Knkvw2pGrR2iWjzI8NrNrV0DR1D8As7mcv1juU94qIBAWQqi5m3JXn6sNdAdDHf6WH1icF4PeF0YqDpGWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984040; c=relaxed/simple;
	bh=kIbV8w9VACrw56EiOJHnI17zKPAzzsTMVzsAhN5J9BI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLHe1MwA7vnmG8LwOWieDSK4s5SdSCbO/iEGNXnIR24qJiN+RncNIC2SWwFUfKbsCdbH0LbQICanK7eBp5P2i08BQu7oFnbjKYHdgvcFEe7rnx2VfPjPkjb7EBJECQbKwGd/j111F3XZ4TUSKILvkSxGLES91tFtjV8qLbUa4eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lO9Qx4ph; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cae563348so2125285e9.0
        for <linux-edac@vger.kernel.org>; Thu, 03 Oct 2024 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727984036; x=1728588836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=03Fv72OC4PmcFCeI8nt8n17s1/uuSrep9ca3zTiEkFs=;
        b=lO9Qx4phjYRxxvLHSCyriMnMwDV06TBJCLyqssuzuqYsD8NSldIADmouQeBtjAseyG
         FmhxSKgj//kmEFS83N/r+LDKRqjlsTjGTRTPkRKEtozX02RJ02yYG5K5XutT8cCsoZ57
         y3u4EkUO+TzHsnaOJ75KtrLlmp2rW6QrW6tIZgv9rqm4rhXlc9wzk+8hLP0a0jISTeA4
         z7PsMoMwxmH3GNojkRXEtqxdFKy+VLeLnUnjQ6E5ulzJ9xaXFZjgcgmd85r9snC2Vkuj
         s2cmZl945NulfbT/G3d6L8RAIcupJ4KNpAPKMNsxJMaxVT/7g9zNjEv63/7DYvWYYWj1
         HrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727984036; x=1728588836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03Fv72OC4PmcFCeI8nt8n17s1/uuSrep9ca3zTiEkFs=;
        b=pKm++dJIcMMFf2S5KzmhufmQvsi9IcWuPRf90zDNRl13y5Vw/1+kPcacaXfIfPXfzR
         MO6iSWK3KoNASDer7Fww4olFzcXYQT+NIShNXJfOmqHtrOyU56SgVmmnKnsAyxoHRmTG
         LSKhqKrXTaFErgND6kcHhN7FpUgA9PXE/EPZXYltByanO1o+IDX1tedodRhYNBefpg8B
         wS7IgjBxp8twV61bHxB8+O4mA0AOovoDD/WK1gvg9cBk4eWbkOesjm8HMI8Yv74/sOd9
         cIFfq9WqTLZG/P6OxFkSxd4s6BIR4Y8BdIFEFpkp/QTr2T37pU7cVpZ5rmt54LtvcGo/
         qsbg==
X-Forwarded-Encrypted: i=1; AJvYcCUW6WXTeyuURK19zzvRoChxcpJ/DSHJMaA3F2a5pprkCtNlJzVOAhETeLPN7hPe+K6jBJfrLZaFv4nj@vger.kernel.org
X-Gm-Message-State: AOJu0YwgdtyqXO4e/5tgUdFUo4Ee2MvNKXqB9zPO19a0WGLpEPG0VRgD
	l79kfpyhIkf8EqANn5ZGnVjPqjeB9qlIWbnlFXaANTCMKCMA/EwjmOrU7+xBh90=
X-Google-Smtp-Source: AGHT+IHjRWUaU8ltzBjbkFXmEkgDCxZchAnWE0VBPx5pWs6E7ZjLo/UP7jBOqliwGkw4W1bGRndjRw==
X-Received: by 2002:a05:600c:5106:b0:42c:aeee:da87 with SMTP id 5b1f17b1804b1-42f85af8cf9mr414215e9.9.1727984035866;
        Thu, 03 Oct 2024 12:33:55 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ed3e3fsm51453405e9.23.2024.10.03.12.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 12:33:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Frank Li <Frank.li@nxp.com>,
	York Sun <york.sun@nxp.com>
Subject: [PATCH v2] EDAC: MAINTAINERS: change FSL DDR EDAC maintainer to Frank Li
Date: Thu,  3 Oct 2024 21:33:48 +0200
Message-ID: <20241003193348.102234-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Last email from York Sun is from 2019, so move him to Credits.  Frank Li
volounteered to keep maintaining the driver.

Suggested-by: Borislav Petkov <bp@alien8.de>
Cc: Frank Li <Frank.li@nxp.com>
Cc: York Sun <york.sun@nxp.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changesi in v2:
1. Switch to Frank Li, do not orphan the driver.
---
 CREDITS     | 4 ++++
 MAINTAINERS | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 63f53feefa0a..1c0ed4b16226 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3791,6 +3791,10 @@ S: Department of Zoology, University of Washington
 S: Seattle, WA  98195-1800
 S: USA
 
+N: York Sun
+E: york.sun@nxp.com
+D: Freescale DDR EDAC
+
 N: Eugene Surovegin
 E: ebs@ebshome.net
 W: https://kernel.ebshome.net/
diff --git a/MAINTAINERS b/MAINTAINERS
index 636a84ccb5f6..03474c934930 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8120,7 +8120,8 @@ S:	Maintained
 F:	drivers/edac/e7xxx_edac.c
 
 EDAC-FSL_DDR
-M:	York Sun <york.sun@nxp.com>
+M:	Frank Li <Frank.Li@nxp.com>
+L:	imx@lists.linux.dev
 L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/fsl_ddr_edac.*
-- 
2.43.0


