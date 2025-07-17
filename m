Return-Path: <linux-edac+bounces-4374-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8990DB08208
	for <lists+linux-edac@lfdr.de>; Thu, 17 Jul 2025 03:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12875188809B
	for <lists+linux-edac@lfdr.de>; Thu, 17 Jul 2025 01:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3561A4E70;
	Thu, 17 Jul 2025 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VSDKjqag"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555CB18FC86;
	Thu, 17 Jul 2025 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714392; cv=none; b=fSoLsSAtF4mbMC3XLTlP7Rx4N/WbOADe0dMl44j0dXAMvXzCiVLqBbxs/+hb0phgU8VOl0WCTdy7R3T6L5/S2pWpRfQbH08ZlnvcUqVLqrauv2O9YAXfwwgjixeZpZcZa1J7hq5S74EtQEbixjaZs1Rfo9Vrxo3lCrpxzFeW3Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714392; c=relaxed/simple;
	bh=f2A07NoQdKWfdVPjRGgryolCT+YCWEvtpfIr9I9ui3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uEgdhM/2TOJ6jGyHRpQEHRk3tzyGlodY0nSJVHfM90ALEWPQHp98vsBtLRgvVN+TlTn/kt9W2TxOj1ZoZcmFQnBhZtzTfA4jhQpUqofP2N+9SyEmwYbKJSo0LqmIGRkpn0EYwW4h9D2Uqv+xUSglhYRo66H7/ItWxI2t/lylL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VSDKjqag; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1053)
	id CB3AA2116DAE; Wed, 16 Jul 2025 18:06:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB3AA2116DAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752714390;
	bh=wGfETnKlXujF+Qax1vKbMwZ2C0+B6JAkUjeARXtHDyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSDKjqagawfnx8Q8/3Fe+EW5c/4y+oLCMsXo3kf1AH31MY8ukjF6hsej38MOc6Iw1
	 B6tEV9czgIHtAt2ZTLKS9j18CQkUKCoHzegMWpnqPfls2sqf8OD6tu4TaZrFJoRDdh
	 jL7jp2zRK2cUIoJbuXdZCukjW0ZmhaHtobz71vp4=
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
Subject: [v12 PATCH 2/2] dt-bindings: arm: cpus: Add edac-enabled property
Date: Wed, 16 Jul 2025 18:06:30 -0700
Message-Id: <1752714390-27389-3-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752714390-27389-1-git-send-email-vijayb@linux.microsoft.com>
References: <1752714390-27389-1-git-send-email-vijayb@linux.microsoft.com>
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
 Documentation/devicetree/bindings/arm/cpus.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 2e9ab9583005..67eaa6df5959 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -352,6 +352,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: Link to Mediatek Cache Coherent Interconnect
 
+  edac-enabled:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      A72 CPUs support Error Detection And Correction (EDAC) on their L1 and
+      L2 caches. This flag marks this function as usable.
+
   qcom,saw:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -398,6 +404,17 @@ properties:
 allOf:
   - $ref: /schemas/cpu.yaml#
   - $ref: /schemas/opp/opp-v1.yaml#
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
   - if:
       # If the enable-method property contains one of those values
       properties:
-- 
2.49.0


