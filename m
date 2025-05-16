Return-Path: <linux-edac+bounces-3925-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2066AB9300
	for <lists+linux-edac@lfdr.de>; Fri, 16 May 2025 02:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997351BC6726
	for <lists+linux-edac@lfdr.de>; Fri, 16 May 2025 00:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3246139E;
	Fri, 16 May 2025 00:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cTzrfcT4"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C52376;
	Fri, 16 May 2025 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747353980; cv=none; b=QVd0xD+IoL3qx16mnOO5PD3kLIRTUP26/RYc0R5u/FFYKwAAbqN4l31leWwvgtwzvg8OrpjFkNMGWxp5Orga0/20u7owrNC2eIi4xQR/xRDghF+oJPlJIePYLn6AkZac9x0zlBkru0uKwJU7+ATevk8E95/s+TXU+EevfUh5ybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747353980; c=relaxed/simple;
	bh=0qC4P0mpUAUyDkR3k+jD+v4l2RIXbNISr3Haiblh2GE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JjPk0GkaUTxRywImztosKEO5NYD58L5FR7MmdR4b/+DabEHSybl9WgGpfEa4eTOIqVErjyAiY0jEZPmdX8DLYQsHtDPdZJBEBU1HVYEZztKkiFLVMqEqvlXNfn0TQYy4qlpq2KcIiZtvTZz8QnoVuwN8mtUVc+JtMq9DYNEEt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cTzrfcT4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1053)
	id 564C22118E4D; Thu, 15 May 2025 17:06:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 564C22118E4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747353973;
	bh=Nv4pu20mYKwQ3E1Bbm0P9X1/Hkihrhb6gPKvxdAFz8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTzrfcT4Vr72b7GVZxS8mty6atG3E8zn7UYigBIPX0q3EjUqJzAmB5QqxYLvlP81G
	 WqJ5CgjYZK7Rs7m3KCnXsZWtB7FknlFTprVXhZgehXMo3mT9UZXACv5+vllHwx/4/p
	 x0RFS7FHmXMr7dq4yvvh3g/9H9+2drUOymwbqFcs=
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
Subject: [PATCH 2/3] dt-bindings: arm: cpus: Add edac-enabled property
Date: Thu, 15 May 2025 17:06:12 -0700
Message-Id: <1747353973-4749-3-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
References: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
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
[vijayb: Limit A72 in the commit message]
Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 2e666b2a4dcd..d1dc0a843d07 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -331,6 +331,12 @@ properties:
       corresponding to the index of an SCMI performance domain provider, must be
       "perf".
 
+  edac-enabled:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Some CPUs support Error Detection And Correction (EDAC) on their L1 and
+      L2 caches. This flag marks this function as usable.
+
   qcom,saw:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: |
-- 
2.49.0


