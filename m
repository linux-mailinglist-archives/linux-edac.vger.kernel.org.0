Return-Path: <linux-edac+bounces-1629-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C0794C0B7
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2024 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA191F217DD
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2024 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6C918EFD3;
	Thu,  8 Aug 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="qK7lIiyE"
X-Original-To: linux-edac@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E1E74055;
	Thu,  8 Aug 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130089; cv=none; b=sDO6fg1ra4lL7K3I1wDyy0mD+mUP/s2oWrx38JI1zlREz4GbeXTFtaLC1HcdOSaGSh8Mj7wIBBVgkSckT9CoBzJeC6pirOwvmQDAQ+HUAHIf4+CWkls2Tb224xit8j+1zqbsgmejqiv+sV76b4Q0JN4wkKQ1cOnvbSH6kFPWSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130089; c=relaxed/simple;
	bh=iFNP495OinJb2lktMcGqRGAhtEH6mWIcSw6cu316J9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZiBbtRp2/MMt5l8q1Ron3xfNPNFEtVJt+iD1O39+P4VRZb2cGJIKC+PYfQF/OaNqQzRZBcvWSoOVoY5eOUr8Pl/yKJC5nRvYk68GzXMHadvCiCgg5jNpQPN6BvzQvhp1f9bcJ5k8qNVEq+BGhIffKwk53d89e7qsWqwfh0gq9Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=qK7lIiyE; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1723130086; x=1754666086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iFNP495OinJb2lktMcGqRGAhtEH6mWIcSw6cu316J9c=;
  b=qK7lIiyEOOaOdNHExNyT+Ot5mNb5vZhwzfFDzxU1lyhRXC/i1rD3RAJ0
   +YUMJ0nKzYHL1AP3oEgRkeqDa8aCtBlcwaCstRqAL/E/oFbjh/g1qPJNy
   npjhDp/Xx7Vz/cMXaizF/EPHY40AaNzyk4Z9BPbrTH2mmzic3IdG0Vbg4
   IVA3PvFggkQpJ/pg26Ur9q9UKIhLdEyEhviI4zXuDvyMuhxaRt+f20SRi
   jb0TRzh8NHxxALcu5tb9SFYFw1XMJEg/Hl6jNW5XgmytyK50Swxnj0zGp
   2W2NpJ6PDfmmZO6sxKevTw2FMczcOQYcT5ZDiAA/++dQbTiyTP0HTGH4K
   A==;
X-CSE-ConnectionGUID: dlbGftqSRSyh6Lrh+4LPZg==
X-CSE-MsgGUID: 70xE8BnqSMGH7DBZHSQyUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="158186000"
X-IronPort-AV: E=Sophos;i="6.09,273,1716217200"; 
   d="scan'208";a="158186000"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:13:34 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1EEC7D29E6;
	Fri,  9 Aug 2024 00:13:32 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 52C84D4F57;
	Fri,  9 Aug 2024 00:13:31 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id CF976229368;
	Fri,  9 Aug 2024 00:13:30 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 28E1D1A000A;
	Thu,  8 Aug 2024 23:13:29 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-mm@kvack.org,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	Jonathan.Cameron@huawei.com,
	alison.schofield@intel.com
Cc: bp@alien8.de,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	ira.weiny@intel.com,
	james.morse@arm.com,
	linmiaohe@huawei.com,
	mchehab@kernel.org,
	nao.horiguchi@gmail.com,
	rric@kernel.org,
	tony.luck@intel.com,
	ruansy.fnst@fujitsu.com
Subject: [PATCH v4 0/2] cxl: add device reporting poison handler
Date: Thu,  8 Aug 2024 23:13:26 +0800
Message-Id: <20240808151328.707869-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28584.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28584.000
X-TMASE-Result: 10--25.644800-10.000000
X-TMASE-MatchedRID: lHzeI+asw8M0b21ExFN2+kg5Iem1vm3HTFQnI+epPIbVYWFt1wbX7Eop
	D+RCCRBkvX+3OiqxW1kU/FrOclzESmD8e8nXbfYy0wmR34xRQc8v5vY1YvMqbujMOEZ5AL0SUZS
	Ad8uKlMfx79muHEGAix37L/Rv0wwcXOFTT+immjbfh7vdn2pP64zinsSc+o89H8jJDe3vPQN5GD
	v/ZOF4Nm5/m6vlvI+l/Iblp89iIQD1aPobg60YTKJVTu7sjgg1odQJXaDex6fWeQtrcncLfbIQd
	fMMKrFBCD9IcjSuAiPykYfoCiS47xyfGYp07KWZTbFVCYPBTqZZDdHiTk9OcLfYIuZsOQ0shj53
	gjhYKkQ8I7sVBmNJqozRCiL6QfeVNigjEI6ndRqJJ72DuZB0nDnOm2OHJgpYcdSPHEhb6Fe2NT1
	CGlQHxr/5yx5GCNXjb3JmPdq59vkfE8yM4pjsDwtuKBGekqUpPjKoPgsq7cA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

This patchset includes "cxl/core: introduce poison creation hanlding"
and "cxl: avoid duplicated report from MCE & device", which were posted
separately.  Here are changes since last version of each patch:
 P1: 1. since its async memory_failure(), set the flag to 0
     2. also handle CXL_EVENT_TRANSACTION_SCAN_MEDIA type
 P2: 1. use XArray instead of list_head
     2. add guard() lock for cxl device iteration
 P1&P2: Rebase to v6.11-rc1


As is known to us, CXL spec defines POISON feature to notify its status 
when CXL memory device got a broken page.  Basically, there are two 
major paths for the notification.

1. CPU handling error
   When a process is accessing this broken page, CXL device returns data
   with POISON.  When CPU consumes the POISON, it raises a kind of error
   notification.
   To be precise, "how CPU should behave when it consumes POISON" is
   architecture dependent.  In my understanding, x86-64 raises Machine
   Check Exception(MCE) via interrupt #18 in this case.
2. CXL device reporting error
   When CXL device detects the broken page by itself and sends memory
   error signal to kernel in two optional paths.
   2.a. FW-First
     CXL device sends error via VDM to CXL Host, then CXL Host sends it
     to System Firmware via interrupt, finally kernel handles the error.
   2.b. OS-First
     CXL device directly sends error via MSI/MSI-X to kernel.

Note: Since I'm now focusing on x86_64, basically I'll describe about 
x86-64 only.

The following diagram should describe the 2 major paths and 2 optional 
sub-paths above.
```
1.  MCE (interrupt #18, while CPU consuming POISON)
     -> do_machine_check()
       -> mce_log()
         -> notify chain (x86_mce_decoder_chain)
           -> memory_failure()
2.a FW-First (optional, CXL device proactively find&report)
     -> CXL device -> Firmware
       -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace
2.b OS-First (optional, CXL device proactively find&report)
     -> CXL device -> MSI
       -> OS: CXL driver -> trace
```

For "1. CPU handling error" path, the current code seems to work fine. 
When I used error injection feature on QEMU emulation, the code path is 
executed certainly.  Then, if the CPU certainly raises a MCE when it 
consumes the POISON, this path has no problem.

So, I'm working on making for 2.a and 2.b path, which is CXL device 
reported POISON error could be handled by kernel.  This path has two 
advantages.

- Proactively find&report memory problems

   Even if a process does not read data yet, kernel/drivers can prevent
   the process from using corrupted data proactively.  AFAIK, the current
   kernel only traces POISON error event from FW-First/OS-First path, but
   it doesn't handle them, neither notify processes who are using the
   POISON page like MCE does.  User space tools like rasdaemon reads the
   trace and log it, but as well, it doesn't handle the POISON page.  As
   a result, user has to read the error log from rasdaemon, distinguish
   whether the POISON error is from CXL memory or DDR memory, find out
   which applications are effected.  That is not an easy work and cannot
   be handled in time.  Thus, I'd like to add a feature to make the work
   done automatically and quickly. Once CXL device reports the POISON
   error (via FW-First/OS-First), kernel handles it immediately, similar
   to the flow when a MCE is triggered.  This is my first motivation.

- Architecture independent

   As the mentioned above, "1. CPU handling error" path is architecture
   dependent.  On the other hand, this route can be architecture
   independent code.  If there is a CPU which does not have similar
   feature like MCE of x86-64, my work will be essential.  (To be honest,
   I did not notice this advantage at first as mentioned later, but I
   think this is also important.)


Shiyang Ruan (2):
  cxl/core: introduce device reporting poison hanlding
  cxl: avoid duplicated report from MCE & device

 arch/x86/include/asm/mce.h |   1 +
 drivers/cxl/core/mbox.c    | 190 ++++++++++++++++++++++++++++++++++---
 drivers/cxl/core/memdev.c  |   6 +-
 drivers/cxl/cxlmem.h       |  11 ++-
 drivers/cxl/pci.c          |   4 +-
 include/linux/cxl-event.h  |  16 +++-
 6 files changed, 207 insertions(+), 21 deletions(-)

-- 
2.34.1


