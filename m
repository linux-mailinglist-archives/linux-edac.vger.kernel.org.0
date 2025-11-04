Return-Path: <linux-edac+bounces-5312-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442F5C2F986
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 08:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C0420DA0
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 07:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A23306B08;
	Tue,  4 Nov 2025 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="C1JJhkDH"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03FD3064B8;
	Tue,  4 Nov 2025 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241003; cv=none; b=WMijss2GkFzpAD1rBtyk2qHH308gasQUJr9o05NTPOsp5NjO+s+O/N0/AhKscGSJmDA8mClrNLH3KxVoa/VuCWOjCCY/3tZrKjv5BNmGUnKtX3Tucw5Y2tb3obB7t7QhFTznRM0zHML/+qG2WlnhpQa/oUowFPyy5uWG+Z/KWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241003; c=relaxed/simple;
	bh=+SdD0iehUIlYEMbNDPCIAoEnjYUkbt2uHrJBthLvzQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f4MUQrmQRg/bTYM1mLBu9iwfKQypK4Dlm/Dg/b7pA7uvUrvG9oAKTtdhjx6VPcM4wHaGnNpAHxcjxK9Ul10E+rRQtNV4noB7MS64bTEK6jldMzu1jy6+yRiAvmGBwy74dt1bTVCKUyilxx9efjvHBQDs+k/24Ts6p3CYx1YqCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=C1JJhkDH; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cK/LrK5YkVfoW/vU29GcruuOm2WOfLzKveAet3dsFMs=;
	b=C1JJhkDH67RgJ+bVCE/mUq7QZf87TaTJNsNCfveQ6ZwV7f/jLJnmpxPbgf8pbZIMSkY5mo1sr
	Wgy0XtVzsh0asBbc+pbhfPZ3E7Qe5+7D6M9j0KPOojSxVmhvc6U2Ji2FehhlE1eRDyg7JVWDmtn
	3MXov9ffgryyk8CK15cFvIA=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d10J246sMzLlT5;
	Tue,  4 Nov 2025 15:21:38 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id BEA0718001B;
	Tue,  4 Nov 2025 15:23:12 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 15:23:11 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <david@redhat.com>, <dave.hansen@intel.com>, <bp@alien8.de>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <linmiaohe@huawei.com>,
	<nao.horiguchi@gmail.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tony.luck@intel.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-edac@vger.kernel.org>, <will@kernel.org>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, Xie Yuanbin <xieyuanbin1@huawei.com>
Subject: [PATCH v2 0/2] x86/mm: support memory-failure on 32-bits with SPARSEMEM
Date: Tue, 4 Nov 2025 15:23:04 +0800
Message-ID: <20251104072306.100738-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj100009.china.huawei.com (7.202.194.3)

Memory bit flips are among the most common hardware errors in the server
and embedded fields, many hardware components have memory verification
mechanisms, for example ECC. When an error is detected, some hardware or
architectures report the information to software (OS/BIOS), for example,
the MCE (Machine Check Exception) on x86.

Common errors include CE (Correctable Errors) and UE (Uncorrectable
Errors). When the kernel receives memory error information, if it has the
memory-failure feature, it can better handle memory errors without reboot.
For example, kernel can attempt to offline the affected memory by
migrating it or killing the process. Therefore, this feature is widely
used in servers and embedded fields.

For historical versions, memory-failure cannot be enabled with x86_32 &&
SPARSEMEM because the number of page-flags are insufficient. However, this
issue has been resolved in the current version, and this patch will allow
SPARSEMEM and memory-failure to be enabled together on x86_32.

By the way, due to increased demand, DRAM prices have recently
skyrocketed, making memory-failure potentially even more valuable in the
coming years.

v1-v2: https://lore.kernel.org/20251103033536.52234-1-xieyuanbin1@huawei.com
  - Describe the purpose of these patches in the cover letter.

  - Correct the description of historical changes to page flags.

  - Move the memory-failure traceing code from ras_event.h to
    memory-failure.h

Xie Yuanbin (2):
  x86/mm: support memory-failure on 32-bits with SPARSEMEM
  mm/memory-failure: remove the selection of RAS

 arch/x86/Kconfig                      |  3 -
 include/ras/ras_event.h               | 86 ------------------------
 include/trace/events/memory-failure.h | 97 +++++++++++++++++++++++++++
 mm/Kconfig                            |  1 -
 mm/memory-failure.c                   |  5 +-
 5 files changed, 101 insertions(+), 91 deletions(-)
 create mode 100644 include/trace/events/memory-failure.h

-- 
2.51.0


