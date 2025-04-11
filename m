Return-Path: <linux-edac+bounces-3521-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F6A868AF
	for <lists+linux-edac@lfdr.de>; Sat, 12 Apr 2025 00:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0837F1B687DE
	for <lists+linux-edac@lfdr.de>; Fri, 11 Apr 2025 22:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB2D29C35A;
	Fri, 11 Apr 2025 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EnIErEt1"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA2C293B55;
	Fri, 11 Apr 2025 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744409321; cv=none; b=fBH3b29yAcwjsOMiYKAPxa7DLCdxriuwN5BW89mHMQXGtXiIUWWN2IQWJZ2KYmcHtzajC132+KVNDSSmOM4CpxuvwIfwCN/zdB2piphPjVFMQHd0+oYs4sbElFkWs9F93W0J3rVeqmhdaghKXk2V4E1Wd0WyAQzwIatq3zYPjMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744409321; c=relaxed/simple;
	bh=WZrpMsoJEf8McqfhVmNx1nWCMR+cyym2/nGipLZ6fy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ugSVdv1v6XcaemEyflJvWMp3+14GqsRKySQyXh51X0zqnGzUtYtTrMO3gu1JAxvdEjVX+ffWR5L+vCvp920hLoaKSzC7cvnFXYzA0pyr5mHGgLFNy4FxdvQLrv2Fj5+8oVmnBE5Umg4geEgbXpgne2nwEVPUKIAQundMiOvZkug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EnIErEt1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1053)
	id A4B4221165AD; Fri, 11 Apr 2025 15:08:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4B4221165AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744409319;
	bh=Pes897Jv0hoGSjWuzaZIkP/52WpUpaObjwqPMl/Gn1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnIErEt1pDfI/+HsXzjVSaE/SIB4/opE5rI0TkdaaH0PrkZyd+IHFLanNP90Lp7Mu
	 pJItHVB/NUGDXpsAZBVps8kq94718ThDZDWsCFu+ei5ZnYHmdJsqZW5J4QgLuKCM7D
	 q78CFGZQEh3Z7YsvCBuMuMPlNSYS4m3lz+buDe28=
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
Subject: [PATCH 2/2] dt-bindings: arm: cpus: Add edac-enabled property
Date: Fri, 11 Apr 2025 15:08:39 -0700
Message-Id: <1744409319-24912-3-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744409319-24912-1-git-send-email-vijayb@linux.microsoft.com>
References: <1744409319-24912-1-git-send-email-vijayb@linux.microsoft.com>
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


