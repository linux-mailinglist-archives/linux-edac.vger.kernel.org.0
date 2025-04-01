Return-Path: <linux-edac+bounces-3449-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B4FA77A47
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 14:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DFC3AEB9D
	for <lists+linux-edac@lfdr.de>; Tue,  1 Apr 2025 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36711E5B78;
	Tue,  1 Apr 2025 11:59:01 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D81F0985;
	Tue,  1 Apr 2025 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508741; cv=none; b=Bg3iOIkysA5BHNNN7HA4PTlmhmUNFR7+hSU3VewNPqt2WardVLW7rimAEB6TKsB9mCc7Ef5+QyGGuaerxEXYn6pMsYABMlwpXGHrYjfR+2/aVo300RCnUMhSbquSlRKXGDOog85fc0PpU3dS/+wI3soa8Z5ahfYQLBFSoHqVsMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508741; c=relaxed/simple;
	bh=lYq3l/cDMp4M+zrUA88mCAEfodUAIB9xi+utvzYOls0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ASfEvXuXj2S/PAH2Y0c6HQhuPkCsDrY73FJp+GRkETONWTqtdHKMjJj+DOwZC3HaZ+bdG4FL8IIhDgs7RX0mhUsJQa0EyDJ3E8GwsV+8zTVWqLEmabn4ZZ15Mdt27LK9shNownMXZVAD3EVWLULgaOWiDYMjFPisIdoqV3nZZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZRmds5TJPz6L6tJ;
	Tue,  1 Apr 2025 19:55:13 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 11193140732;
	Tue,  1 Apr 2025 19:58:51 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.146.185) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Apr 2025 13:58:50 +0200
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <mchehab@kernel.org>,
	<sfr@canb.auug.org.au>, <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [PATCH 1/1] EDAC: docs: Fix warning document isn't included in any toctree
Date: Tue, 1 Apr 2025 12:58:23 +0100
Message-ID: <20250401115823.573-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
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

From: Shiju Jose <shiju.jose@huawei.com>

Fix the build (htmldocs) warning: "Documentation/edac/index.rst: WARNING:
document isn't included in any toctree".

Fixes: db99ea5f2c03 ("EDAC: Add support for EDAC device features control")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20250228185102.15842f8b@canb.auug.org.au/
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/subsystem-apis.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index b52ad5b969d4..ff4fe8c936c8 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -71,6 +71,7 @@ Other subsystems
 
    accounting/index
    cpu-freq/index
+   edac/index
    fpga/index
    i2c/index
    iio/index
-- 
2.43.0


