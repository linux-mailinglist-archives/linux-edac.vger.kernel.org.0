Return-Path: <linux-edac+bounces-1801-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C78296AD90
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2024 03:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80F21F25B40
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2024 01:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E535443D;
	Wed,  4 Sep 2024 01:03:38 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E39173
	for <linux-edac@vger.kernel.org>; Wed,  4 Sep 2024 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725411818; cv=none; b=AJ9SZLkwwZKa6EeLcC5qQNs30Vy4HVbi6JTaaLKMvsB8LvjFjKHPZp7j+GcuR88J6Bs+C/zSiWyWTMY94QLL9knYqr9V3acCt3ukk1iq1tyHf3RCGIcPH0dTdkuUCREiJ2UcbTVL37lLvB8AjtnjvMyzjbifu/keM3lYR+bGNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725411818; c=relaxed/simple;
	bh=B1obW1dsmjmqbb4GoP1Ur/AggGWfaz9PpwXznt9Vu9Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kYPtqDnCUEnS9kU8GyoEE+2oHsa7l986AbC2VPQbuCK0xasw16MVSThEVwbKA5rECSysabo75L44de/+igX6NrwBnLwkTBGrfgIdrEYp2qfblyBDSSA85jdCL9wfbDpfdw1r/FAyibZLUAXnJIKS5usurTatAJs3yxyr64km7Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wz42D5qLHzpVJK;
	Wed,  4 Sep 2024 09:01:40 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id D65B21400FF;
	Wed,  4 Sep 2024 09:03:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 09:03:32 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <linux-edac@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next 0/2] EDAC: Constify struct kobj_type
Date: Wed, 4 Sep 2024 09:12:00 +0800
Message-ID: <20240904011202.2009727-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

These 'struct kobj_type' are not modified. They are only used in
kobject_init_and_add() which takes a 'const struct kobj_type *ktype'
parameter.

We can constify these struct to move them to text section,
and increase over all security.

Hongbo Li (2):
  EDAC: Constify struct kobj_type for edac_device_sysfs
  EDAC: Constify struct kobj_type for edac_pci_sysfs

 drivers/edac/edac_device_sysfs.c | 6 +++---
 drivers/edac/edac_pci_sysfs.c    | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.34.1


