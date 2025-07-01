Return-Path: <linux-edac+bounces-4296-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C811BAEEDF8
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jul 2025 07:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF631440C09
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jul 2025 05:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AF5101EE;
	Tue,  1 Jul 2025 05:50:55 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F051AA7BF
	for <linux-edac@vger.kernel.org>; Tue,  1 Jul 2025 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751349055; cv=none; b=mmKF+vQebQSk9JhmNlnaDB9xWX8M0C0rfYQLj3+pxWjEBaLkfNC4b7ufWfBUEGyIlw15/OCq7u+lW0eziesa72P4fGP06rdYvWit9P2fBWllAXUr88yBlG4BKynG8GMNr3yp98JfwXe3GWiEW2gu4RyuYARjPrroDArxMGj/Eac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751349055; c=relaxed/simple;
	bh=IQdTC6EadVoQfTaq+EmZSfe9I4F1fPg46CmSCuYHHCk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qMMVgk3fVIEu0sx7NB+knLrzpodxHU0w9qyYaoZaDwxxvHkvz/FJDg+O3j0JJlOPsZFEIW5ooYsk8xYGFUOyo5nSPIaXNlGHQs8zsW2AohzpgvR/22IqyfPjorQjXt651W4cC3MMjnguYdU5wlFOcKaJYhiQa2NZS7Smfj2UHcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWXDN4Z5xz6M4gX;
	Tue,  1 Jul 2025 13:49:56 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F8A3140427;
	Tue,  1 Jul 2025 13:50:50 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.33.96) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Jul 2025 07:50:49 +0200
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<arnd@kernel.org>, <mchehab@kernel.org>, <rric@kernel.org>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>
CC: <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 0/2] EDAC/features: Reduce stack usage
Date: Tue, 1 Jul 2025 06:50:33 +0100
Message-ID: <20250701055036.1802-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Constructing an array on the stack can exceed the warning limit for 
per-function stack usage. Reduce per-function stack usage by changing
to an actual attribute array allocated statically.

Changes
=======
v1 -> v2:
1. Fix for the error reported by the kernel test robot.
  https://patchwork.kernel.org/project/linux-edac/patch/20250630162034.1788-3-shiju.jose@huawei.com/#26450738.

Shiju Jose (2):
  EDAC/scrub: Reduce stack usage in scrub_create_desc()
  EDAC/ecs: Reduce stack usage in ecs_create_desc()

 drivers/edac/ecs.c   | 31 ++++++++++++-------------------
 drivers/edac/scrub.c | 31 +++++++++++--------------------
 2 files changed, 23 insertions(+), 39 deletions(-)

-- 
2.43.0


