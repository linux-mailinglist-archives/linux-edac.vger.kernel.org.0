Return-Path: <linux-edac+bounces-1980-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BDB996A82
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 14:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF33288E7C
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2024 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3B61A3029;
	Wed,  9 Oct 2024 12:43:37 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A511A264C;
	Wed,  9 Oct 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477817; cv=none; b=iPtuRGybH7vTHxsNDiXXxT6IJ4xuS39mcDG8jNJRxUxpulpFlj5HsZ4Je6CUvL2sljDm4xE6KJzvd/Rwp2QrwWBoJ0uv287qJL/pWbvqjOpGDdSSsdvvL+HTLIXD0lD+TZnf14Vm67plZm+HQDWWqc8sNqswZN0Wm7FMv6+SLi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477817; c=relaxed/simple;
	bh=yJADv5HLP2nZJDFcTIgbib8wNy1Fc6zaeSy4w0kBGkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRGTc9HemvIVwxCmWsofxPOY5y034W8C/qy9i+DIhOlemfWfo0JwS9v51dscJdlE4c8uWwXrvtv7lDh+NW3xpN+bKAEc/bYbWw5yuwSQgRMnPd0+nkHCu7wybxzINe2Zi3UDchtSFngkc+AuDYcXtp5EgUDsF8gwcSNAjZioT18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNsxc1SXnz6GD5T;
	Wed,  9 Oct 2024 20:43:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id EAEAB140CB1;
	Wed,  9 Oct 2024 20:43:33 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.209) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 14:43:32 +0200
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <roberto.sassu@huawei.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v13 12/18] platform: Add __free() based cleanup function for platform_device_put
Date: Wed, 9 Oct 2024 13:41:13 +0100
Message-ID: <20241009124120.1124-13-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241009124120.1124-1-shiju.jose@huawei.com>
References: <20241009124120.1124-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add __free() based cleanup function for platform_device_put().

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 include/linux/platform_device.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index d422db6eec63..606533b88f44 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -232,6 +232,7 @@ extern int platform_device_add_data(struct platform_device *pdev,
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);
+DEFINE_FREE(platform_device_put, struct platform_device *, if (_T) platform_device_put(_T))
 
 struct platform_driver {
 	int (*probe)(struct platform_device *);
-- 
2.34.1


