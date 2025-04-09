Return-Path: <linux-edac+bounces-3501-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 132F8A834A1
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 01:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07FEA188F0E4
	for <lists+linux-edac@lfdr.de>; Wed,  9 Apr 2025 23:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9D321C9F4;
	Wed,  9 Apr 2025 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qbWXL3kM"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC921C18A;
	Wed,  9 Apr 2025 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241787; cv=none; b=NkcVI9zsqorgCje/8xzGKytvYztngynJmx5UEgCIanNXa6t+oSEijfR17eCW6tv40NoZwnxTfPUjTZI5p2sF2HnFRr8yla068z+QkcxDml+vZvgEigBAGVzdGzhZYtf9E5o4TNg5OBDkZ5hKTOi8uqthv22HJ//0H4ypyQ/ajU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241787; c=relaxed/simple;
	bh=B9M0Kkn8BdoLz8MLU9R4GOCMyNBAs8tSClMg/badPUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ajgAieSiI3z25s1MkVg3w10SwbPjQR3XWuanbp3Ngwtx0d5yx/syajub9Gn9eY0d/22F9wJ7tX/xG7kvBBRTM5kDBC3aiYJO7TsHedkkBr4Mlhmr1Q4enj6LqTfgkNBUh14I8ryzTkplhmvK1RsbAQayasTHt+anb9Bei2IVbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qbWXL3kM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1053)
	id 1D1472052509; Wed,  9 Apr 2025 16:36:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D1472052509
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744241786;
	bh=xwELah0qp569GnM+NBppCLXTQ2siGBhErPh6sbtP7Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbWXL3kMsutIK7bMwt7ACCvgToGXAUzUAE+lAhuDON7uCLISEEEfyR1S3AoSQyNar
	 Ev1OhVAmmeqcnSd4rpFh1H4cFFntsM6J9fH7ZknPIWn/TU253sy6cqfIwFHjXFxeIQ
	 fbqQZ5fQBC8eSfhphzMuBkJrvYIfRCQRohB81cd4=
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/2] dt-bindings: arm: cpus: Add edac-enabled property
Date: Wed,  9 Apr 2025 16:36:25 -0700
Message-Id: <1744241785-20256-3-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744241785-20256-1-git-send-email-vijayb@linux.microsoft.com>
References: <1744241785-20256-1-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

From: Sascha Hauer <s.hauer@pengutronix.de>

Some ARM Cortex CPUs like the A53, A57 and A72 have Error Detection And
Correction (EDAC) support on their L1 and L2 caches. This is implemented
in implementation defined registers, so usage of this functionality is
not safe in virtualized environments or when EL3 already uses these
registers. This patch adds a edac-enabled flag which can be explicitly
set when EDAC can be used.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
[vijayb: Added A72 to the commit message]
Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 2e666b2a4dcd..18d649a18552 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -331,6 +331,12 @@ properties:
       corresponding to the index of an SCMI performance domain provider, must be
       "perf".
 
+  edac-enabled:
+    $ref: '/schemas/types.yaml#/definitions/flag'
+    description:
+      Some CPUs support Error Detection And Correction (EDAC) on their L1 and
+      L2 caches. This flag marks this function as usable.
+
   qcom,saw:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: |
-- 
2.49.0


