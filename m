Return-Path: <linux-edac+bounces-591-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61188561C5
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 12:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C991C21A3F
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 11:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136A312AACF;
	Thu, 15 Feb 2024 11:33:50 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88312C52C;
	Thu, 15 Feb 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996830; cv=none; b=e/pU7F1ddBMVk5yqhja8Bc03OoKNry596ANf7c03dT7ucfWtLC5WuXXuI5ItsP770P/FyBU+VJeitJFVGrKEUPVRm0xJlHwZPps0/uOfflM8jUr8Wgy/Rj+IVvA4rpxfEG70OQmFvyTO0XfM+yXcf1kjeaZ5bm9L6kfIxRHQZJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996830; c=relaxed/simple;
	bh=kUHBSL3V+Ks9rTMfKVNFiRX6ZvV6d8qpMisvQgnbCg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o+7zEJtbPUcfNBC2OdL966dKXXXS9EPv4pEIkMZ3f+P/HAHP3S21YyZUlmT1W1IpB6/pKobZveSnpcnAZgov8Eg72EDNAawfCF/oB08kTcOG/mW2pPcmzaCVzbmaSlxL3/EKvKUoWihfuhCiW1ztU9AXcWcHP5F+sh0qU/8YcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbCXn3QQmz67NMH;
	Thu, 15 Feb 2024 19:30:17 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id F270E1400D4;
	Thu, 15 Feb 2024 19:33:44 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:33:44 +0000
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 0/8] rasdaemon: ras-mc-ctl: Add support for CXL  error events
Date: Thu, 15 Feb 2024 19:32:26 +0800
Message-ID: <20240215113235.1498-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for read and log following CXL error event records
from the SQLite database.
1. CXL AER uncorrectable error events
2. CXL AER correctable error events
3. CXL overflow error events
4. CXL poison trace events
5. CXL generic trace events
6. CXL general media trace events
7. CXL DRAM trace events
8. CXL memory module trace events

Shiju Jose (8):
  rasdaemon: ras-mc-ctl: Add support for CXL AER uncorrectable trace
    events
  rasdaemon: ras-mc-ctl: Add support for CXL AER correctable trace
    events
  rasdaemon: ras-mc-ctl: Add support for CXL overflow trace events
  rasdaemon: ras-mc-ctl: Add support for CXL poison trace events
  rasdaemon: ras-mc-ctl: Add support for CXL generic trace events
  rasdaemon: ras-mc-ctl: Add support for CXL general media trace events
  rasdaemon: ras-mc-ctl: Add support for CXL DRAM trace events
  rasdaemon: ras-mc-ctl: Add support for CXL memory module trace events

 util/ras-mc-ctl.in | 698 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 697 insertions(+), 1 deletion(-)

-- 
2.34.1


