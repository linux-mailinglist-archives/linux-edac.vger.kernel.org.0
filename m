Return-Path: <linux-edac+bounces-4288-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3575AEE44D
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 18:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604B7166508
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93F1290BCC;
	Mon, 30 Jun 2025 16:20:52 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F622BD000
	for <linux-edac@vger.kernel.org>; Mon, 30 Jun 2025 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300452; cv=none; b=CV9INU1l9SxKwfPTbzyRyIy8by20sgpkfbhHqbcL/UQJk8bUyCP7QPUyOmG1QU5GLKgUFMKudeShBrQQjCaUqvyfvf6ynj1/57yIZX93qd28sPjNEFnRRNi4q3KRgXBV7Lq8z0W8SsrYSXrhr32nnlt9uRgOhdg5pMSFOHMMIJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300452; c=relaxed/simple;
	bh=eAAiaaeHIEQGEOAfO5j+jt9s3j3ZwXWpuHb4jKjffV0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O6XfJE/svym/0ysxGWhr+DrCJUxjU6sygamDRjkmnA0KN7kYPG8iLBD+2CridJXCWYXH+/iwoxILjM6KdeV8HI3Is8WBbUYLzx116deLTtgb4e0pnuHbFarrDNdWZRTev9/UfE7GNaL9knYyLWl1j4qs3qhM7LAc5NK7aaNhDNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWBCX3Tzqz6L5R5;
	Tue,  1 Jul 2025 00:18:00 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 6088F1400CA;
	Tue,  1 Jul 2025 00:20:48 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.174) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 18:20:47 +0200
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<arnd@kernel.org>, <mchehab@kernel.org>, <rric@kernel.org>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>
CC: <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 0/2] EDAC/features: Reduce stack usage in create_desc functions
Date: Mon, 30 Jun 2025 17:20:32 +0100
Message-ID: <20250630162034.1788-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Constructing an array on the stack can exceed the warning limit for 
per-function stack usage. Reduce per-function stack usage by changing
to an actual attribute array allocated statically.

Shiju Jose (2):
  EDAC/scrub: Reduce stack usage in scrub_create_desc()
  EDAC/ecs: Reduce stack usage in ecs_create_desc()

 drivers/edac/ecs.c   | 29 +++++++++++------------------
 drivers/edac/scrub.c | 31 +++++++++++--------------------
 2 files changed, 22 insertions(+), 38 deletions(-)

-- 
2.43.0


