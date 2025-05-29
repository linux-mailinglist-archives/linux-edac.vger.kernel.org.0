Return-Path: <linux-edac+bounces-4028-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B79F4AC75FE
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 05:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB84A4015D
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 03:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31911DEFE8;
	Thu, 29 May 2025 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hg8A0ODh"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1332F2629C;
	Thu, 29 May 2025 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748487630; cv=none; b=pHBaqp9OP9bqPbOdix/gmHNddiitwvXexiuCA6arkAwkHGecz7lFcmzyrjppsadhZIO4L4e+vFxGOkXQcOC6MPGlakcu/p/gIv6s1TYGS2OVAHVI17hhi419kZoub062WTYTZJuiP/zRoWNqx8HfisKg2xq9HYF2OcJ4cUiRm5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748487630; c=relaxed/simple;
	bh=5/PIRpFt+YrjS9KFotq9SMGHXTN611svNE76InG69h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=q9jbCo6HyvT18KUJgFH45rkKN2Zh3q0DPCVPC2nEWTWWle3YdxGcFSBCd35PBfOr55h5rD+rh5bbLLcnZk1oIq0aw/yK4nXJ73cIDdEDiNrBu/ogSAtIb39dRxy/40nUCMh717mhOJ8dAfQxDaBDsIxHz7H94av4ZziISUpTObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hg8A0ODh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1053)
	id AD3EF210C335; Wed, 28 May 2025 20:00:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD3EF210C335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748487628;
	bh=fLBdU9btGRF299ua5retncJ9AqSOE2dlAJemQ2IUuF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hg8A0ODhSEaP5YHb1/DbzYnLq591+k+h8D4i8R9oXd1Rp/Kz3VdZI6Zespvst5rjR
	 DqTVEUDFpDG8LLBU6m2JYS8pgRWXSlKQuck8xffXdY2imyb3gUTow7WRJcfZY4qgcB
	 yl7YTfXQKHh4m3EQNGBNYbCWxma2dKe9tLyBmlaU=
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
Subject: [v11 PATCH 2/2] dt-bindings: arm: cpus: Add edac-enabled property
Date: Wed, 28 May 2025 20:00:28 -0700
Message-Id: <1748487628-30123-3-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748487628-30123-1-git-send-email-vijayb@linux.microsoft.com>
References: <1748487628-30123-1-git-send-email-vijayb@linux.microsoft.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/arm/cpus.yaml         | 50 +++++++++++++------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 2e666b2a4dcd..af884d51362d 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -331,6 +331,12 @@ properties:
       corresponding to the index of an SCMI performance domain provider, must be
       "perf".
 
+  edac-enabled:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      A72 CPUs support Error Detection And Correction (EDAC) on their L1 and
+      L2 caches. This flag marks this function as usable.
+
   qcom,saw:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: |
@@ -378,22 +384,34 @@ properties:
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


