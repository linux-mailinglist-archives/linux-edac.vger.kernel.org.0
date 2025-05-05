Return-Path: <linux-edac+bounces-3824-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BE7AA8A5A
	for <lists+linux-edac@lfdr.de>; Mon,  5 May 2025 02:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6C83B3944
	for <lists+linux-edac@lfdr.de>; Mon,  5 May 2025 00:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BAE249F9;
	Mon,  5 May 2025 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RDF3xvAE"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B4723BE;
	Mon,  5 May 2025 00:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746404868; cv=none; b=ViKfnlLXHkua15qEJu+LG4PGwNbkpMRUe3I3uQa3lpIAO2Qoa9wflMjOMjGn2t4DQBC1zsm4TPmXFkzHVXB890tnNGyj8lYkE/vi2yKPaKucuKgVL0q99loArnbe9UeusdB37Pp95UY1u6gmhLAaG1VYyTxAcM9R2GaItDXBVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746404868; c=relaxed/simple;
	bh=WZrpMsoJEf8McqfhVmNx1nWCMR+cyym2/nGipLZ6fy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rIu6o1vPgfIyAWI41QxXLM/9cDgqvywdrAhFcTkPyI3i94LoHBGdwV8iX2I7hZdD/qrYNWb1FeTwcmBhmtTHbfkQQFfQKdafcOOpB+sserpRgGr1ooQYFulggR56U9s6gQsUPpIdCY3fxvljBu262M7gjm5pvh9V04deKU9YpCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RDF3xvAE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1053)
	id 941FA2115DB2; Sun,  4 May 2025 17:27:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 941FA2115DB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746404860;
	bh=Pes897Jv0hoGSjWuzaZIkP/52WpUpaObjwqPMl/Gn1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RDF3xvAE/FM1IHzvt5Q0YgI0NQ1QMh2RC57cakiiauxkeMAdWf63LD+7Zbbrn0gEd
	 WcgMT4+xRAkfUmZKBDENbf6lfpVBvHJSC/1XPBxowFtwxMQDwLhMDCbAW1Yaq577A8
	 mzN1WtqEV9OLq40T2vrsTOr3Lgbir7IIcT3S+sDI=
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
Date: Sun,  4 May 2025 17:27:40 -0700
Message-Id: <1746404860-27069-3-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746404860-27069-1-git-send-email-vijayb@linux.microsoft.com>
References: <1746404860-27069-1-git-send-email-vijayb@linux.microsoft.com>
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


