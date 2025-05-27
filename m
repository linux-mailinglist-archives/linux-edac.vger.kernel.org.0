Return-Path: <linux-edac+bounces-4006-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4AAAC5DB5
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 01:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1570D7B0D43
	for <lists+linux-edac@lfdr.de>; Tue, 27 May 2025 23:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFC521885D;
	Tue, 27 May 2025 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bvWu25p6"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6003188715;
	Tue, 27 May 2025 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748387792; cv=none; b=LoCVWbCGRmv5Ck/ZPmsO9RwnwL/+KSw18RnIpqqspSOeY1aN0vj5QZUCUhCZM1reEPEj5nYMSiPZUygNZLkxKxSJwn1SerhhxYnYDaxxA3ym4+6s5fPDEXUrkyJ370u7wBEiMMvi0YBSykStpEoXzTbRAybY9QmxWz37M6M5u2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748387792; c=relaxed/simple;
	bh=URVDoqoK1Lnss2W+aZ3GLczVpFnztrpNRWvzFXXm7l8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=B/cHPBmWrNnJZPjDpxPVV2DbWSZNhhBvcffLw22fVoEK39SwqW1/URtJJf9oyEJifD67JRMCc6IeOfejx8ITEBlMOc6Wf6dt1rS1GedDprfnPdsQCCcTMTcgQ2qOjgGxycjDKIzALDVNew3WUUOWYZyiNtRQwarMLOdQK2FjfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bvWu25p6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1053)
	id 553572113A56; Tue, 27 May 2025 16:16:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 553572113A56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748387790;
	bh=Uw4aQdSp2oOTVYvmFhX9i9Ez0fzpo4DqVU3RltDQphc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvWu25p694qGOtb5JPRr5Edo8AXLs9w7t7SRwxP5zBSdEXEmwdJlLtzSZ0ROH1ilk
	 f565/ZxA+wt5kjidkiVipYK7daxyAXLdkT4WW80fnPLU5RODLrYTMgjE8j1ZN+SIxC
	 iUIExCO84L7visV2xJx+r+UJLiNT8EiMx3xmT1bM=
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org,
	Vijay Balakrishna <vijayb@linux.microsoft.com>
Subject: [v10 PATCH 2/2] dt-bindings: arm: cpus: Add edac-enabled property
Date: Tue, 27 May 2025 16:16:30 -0700
Message-Id: <1748387790-20838-3-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748387790-20838-1-git-send-email-vijayb@linux.microsoft.com>
References: <1748387790-20838-1-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

From: Sascha Hauer <s.hauer@pengutronix.de>

Some ARM Cortex CPUs including A72 have Error Detection And
Correction (EDAC) support on their L1 and L2 caches. This is implemented
in implementation defined registers, so usage of this functionality is
not safe in virtualized environments or when EL3 already uses these
registers. This patch adds a edac-enabled flag which can be explicitly
set when EDAC can be used.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
[vijayb: Added A72 to the commit message]
Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
---
 .../devicetree/bindings/arm/cpus.yaml         | 51 +++++++++++++------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 2e666b2a4dcd..8f42c4fec59b 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -331,6 +331,13 @@ properties:
       corresponding to the index of an SCMI performance domain provider, must be
       "perf".
 
+  edac-enabled:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      A72 CPUs support Error Detection And Correction (EDAC) on their L1 and
+      L2 caches. This flag marks this function as usable.
+#    type: boolean
+
   qcom,saw:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: |
@@ -378,22 +385,34 @@ properties:
       formed by encoding the target CPU id into the low bits of the
       physical start address it should jump to.
 
-if:
-  # If the enable-method property contains one of those values
-  properties:
-    enable-method:
-      contains:
-        enum:
-          - brcm,bcm11351-cpu-method
-          - brcm,bcm23550
-          - brcm,bcm-nsp-smp
-  # and if enable-method is present
-  required:
-    - enable-method
-
-then:
-  required:
-    - secondary-boot-reg
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: arm,cortex-a72
+    then:
+      # Allow edac-enabled only for Cortex A72
+      properties:
+        edac-enabled: false
+
+  - if:
+      # If the enable-method property contains one of those values
+      properties:
+        enable-method:
+          contains:
+            enum:
+              - brcm,bcm11351-cpu-method
+              - brcm,bcm23550
+              - brcm,bcm-nsp-smp
+      # and if enable-method is present
+      required:
+        - enable-method
+
+    then:
+      required:
+        - secondary-boot-reg
 
 required:
   - device_type
-- 
2.49.0


