Return-Path: <linux-edac+bounces-3924-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBEBAB92FE
	for <lists+linux-edac@lfdr.de>; Fri, 16 May 2025 02:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702233B62C2
	for <lists+linux-edac@lfdr.de>; Fri, 16 May 2025 00:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2354A32;
	Fri, 16 May 2025 00:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P8KIdPx+"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C7C635;
	Fri, 16 May 2025 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747353980; cv=none; b=SL/Xac6AxrNz+LxSXWyy9ZA07TjIJ8tq59yamZHoG/87u9oOBn9xH/zX+SWMMtmqkdcJRVg2aWaeH5mnu74XPgaFdQBip7DHRFgwKlky8yX2hAaGR8eqE6phC7lmfEuBHEf0AGb/hOf4LCYyz4qFHY4DBdOxpLwj3XrWpjBHnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747353980; c=relaxed/simple;
	bh=PXd6ZKf1wKxdAxE/hamYLFxW+kzwB06LPtm3dawlgpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EVaXz5XUZ6FBpBvtu5jYI3of0FRxHgY3DqnE1EA1f4/PZym/ceqfql9YgPSZ1LySK86yWhUxCZv2RU5cW/sTcj8SnpRA3JkL1ougCnJm1CqMYSJGkGWe+Yx/ZMdkdsrsvtz7u0tazTfJrQfcseyYNGUwufVhnI41W++aMZxATi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=P8KIdPx+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1053)
	id 6376C2118E4E; Thu, 15 May 2025 17:06:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6376C2118E4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747353973;
	bh=UiIxusU4/FRQ34gn/l0ohVCyAmep6rrYVr8lFiSWouY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8KIdPx+af9l0mR8ZtfpQP2AwvOi818hk0Z/VrvZ1iV1bzS7acehUDZnxKfdZudaG
	 24Kbjmcna/r92OwCERGP3+MvLLePLu7om0/cep6Aae4NeMK/UPPJVqqjb+t9ieAFvy
	 GnSG4XEhWAoS3lsGkc/aZF4Y1WJ9fEE6836Hhpzo=
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
Subject: [PATCH 3/3] EDAC: Add EDAC driver for Cortex A72
Date: Thu, 15 May 2025 17:06:13 -0700
Message-Id: <1747353973-4749-4-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
References: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The driver is designed to support error detection and reporting for Cortex A72
cores, specifically within their L1 and L2 cache systems.

Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3563492e4eba..1fa51e39e266 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8430,6 +8430,13 @@ F:	Documentation/driver-api/edac.rst
 F:	drivers/edac/
 F:	include/linux/edac.h
 
+EDAC-A72
+M:	Vijay Balakrishna <vijayb@linux.microsoft.com>
+M:	Tyler Hicks <code@tyhicks.com>
+L:	linux-edac@vger.kernel.org
+S:	Supported
+F:	drivers/edac/edac_a72.c
+
 EDAC-DMC520
 M:	Lei Wang <lewan@microsoft.com>
 L:	linux-edac@vger.kernel.org
-- 
2.49.0


