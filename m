Return-Path: <linux-edac+bounces-5261-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336B8C1EB43
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 08:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E1C403F0B
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 07:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D933358A4;
	Thu, 30 Oct 2025 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="p7g4CpNs"
X-Original-To: linux-edac@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF13595D;
	Thu, 30 Oct 2025 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761808416; cv=none; b=M2D27hMqm7GDFVPwNcmeAZe3CxbF8RaHB1HJE6ew3E3tKs0+2U7RHCpUsMqehKYvYtd0LtukHbsQSj7MwCsfnyW73z+LNjX3ALXVREt9ToyHbtckwUcLJ6/9W9SXNxseZIp3qd6lACF/QTZvXEnkitSekaPNAwD4iJ8E4CXTexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761808416; c=relaxed/simple;
	bh=CTUkh/b3PUPbjFi6Mev8pgtZJVqt78u0cx/ZG3awATg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A7+LXagZs3Z/4378TEfmrmDCu3T8+GKLAvZZQdJYxp0u2SmocENVaMVWlWLXBL2t+NBkNfel1JAABxYIiJcbrsySw5HOPGOnjOUT7DYKU6LpGnkkPYmjbd+lo/XjAHHAcbBrDMpX4omjknGmPGBF1DyjtpVfT3AiKhbMcMBj1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=p7g4CpNs; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5b/+/mkouW76nc7fPhFgrG/ENZ8PlhIsp4pHwFuI8oY=;
	b=p7g4CpNsL/rTvnTI1YEgszYjLsvZoeJup8WVTd/W2bLNKLjxNDhSetYvOvtKPdj4nmNoYVNsh
	lr7AZTX96HINjeOqv8OPWDkiVqHxMZhsZijHTRIXd1kWYqEBW5s5UvRVdGSk8YTAXgIce7Mr7bM
	s/sznaJJz6W69XEkUqKj6yg=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cxwKZ05g4z1T4FV;
	Thu, 30 Oct 2025 15:12:18 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 22565180237;
	Thu, 30 Oct 2025 15:13:23 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 15:13:22 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Oct 2025 15:13:22 +0800
From: Junhao He <hejunhao3@h-partners.com>
To: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<jarkko@kernel.org>, <yazen.ghannam@amd.com>, <jane.chu@oracle.com>,
	<lenb@kernel.org>, <Jonathan.Cameron@Huawei.com>
CC: <linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<shiju.jose@huawei.com>, <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
	<hejunhao3@h-partners.com>
Subject: [PATCH] ACPI: APEI: Handle repeated SEA error interrupts storm scenarios
Date: Thu, 30 Oct 2025 15:13:21 +0800
Message-ID: <20251030071321.2763224-1-hejunhao3@h-partners.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn500004.china.huawei.com (7.202.194.145)

The do_sea() function defaults to using firmware-first mode, if supported.
It invoke acpi/apei/ghes ghes_notify_sea() to report and handling the SEA
error, The GHES uses a buffer to cache the most recent 4 kinds of SEA
errors. If the same kind SEA error continues to occur, GHES will skip to
reporting this SEA error and will not add it to the "ghes_estatus_llist"
list until the cache times out after 10 seconds, at which point the SEA
error will be reprocessed.

The GHES invoke ghes_proc_in_irq() to handle the SEA error, which
ultimately executes memory_failure() to process the page with hardware
memory corruption. If the same SEA error appears multiple times
consecutively, it indicates that the previous handling was incomplete or
unable to resolve the fault. In such cases, it is more appropriate to
return a failure when encountering the same error again, and then proceed
to arm64_do_kernel_sea for further processing.

When hardware memory corruption occurs, a memory error interrupt is
triggered. If the kernel accesses this erroneous data, it will trigger
the SEA error exception handler. All such handlers will call
memory_failure() to handle the faulty page.

If a memory error interrupt occurs first, followed by an SEA error
interrupt, the faulty page is first marked as poisoned by the memory error
interrupt process, and then the SEA error interrupt handling process will
send a SIGBUS signal to the process accessing the poisoned page.

However, if the SEA interrupt is reported first, the following exceptional
scenario occurs:

When a user process directly requests and accesses a page with hardware
memory corruption via mmap (such as with devmem), the page containing this
address may still be in a free buddy state in the kernel. At this point,
the page is marked as "poisoned" during the SEA claim memory_failure().
However, since the process does not request the page through the kernel's
MMU, the kernel cannot send SIGBUS signal to the processes. And the memory
error interrupt handling process not support send SIGBUS signal. As a
result, these processes continues to access the faulty page, causing
repeated entries into the SEA exception handler. At this time, it lead to
an SEA error interrupt storm.

Fixes this by returning a failure when encountering the same error again.

The following error logs is explained using the devmem process:
  NOTICE:  SEA Handle
  NOTICE:  SpsrEl3 = 0x60001000, ELR_EL3 = 0xffffc6ab42671400
  NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
  NOTICE:  EsrEl3 = 0x92000410
  NOTICE:  PA is valid: 0x1000093c00
  NOTICE:  Hest Set GenericError Data
  [ 1419.542401][    C1] {57}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
  [ 1419.551435][    C1] {57}[Hardware Error]: event severity: recoverable
  [ 1419.557865][    C1] {57}[Hardware Error]:  Error 0, type: recoverable
  [ 1419.564295][    C1] {57}[Hardware Error]:   section_type: ARM processor error
  [ 1419.571421][    C1] {57}[Hardware Error]:   MIDR: 0x0000000000000000
  [ 1419.571434][    C1] {57}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000081000100
  [ 1419.586813][    C1] {57}[Hardware Error]:   error affinity level: 0
  [ 1419.586821][    C1] {57}[Hardware Error]:   running state: 0x1
  [ 1419.602714][    C1] {57}[Hardware Error]:   Power State Coordination Interface state: 0
  [ 1419.602724][    C1] {57}[Hardware Error]:   Error info structure 0:
  [ 1419.614797][    C1] {57}[Hardware Error]:   num errors: 1
  [ 1419.614804][    C1] {57}[Hardware Error]:    error_type: 0, cache error
  [ 1419.629226][    C1] {57}[Hardware Error]:    error_info: 0x0000000020400014
  [ 1419.629234][    C1] {57}[Hardware Error]:     cache level: 1
  [ 1419.642006][    C1] {57}[Hardware Error]:     the error has not been corrected
  [ 1419.642013][    C1] {57}[Hardware Error]:    physical fault address: 0x0000001000093c00
  [ 1419.654001][    C1] {57}[Hardware Error]:   Vendor specific error info has 48 bytes:
  [ 1419.654014][    C1] {57}[Hardware Error]:    00000000: 00000000 00000000 00000000 00000000  ................
  [ 1419.670685][    C1] {57}[Hardware Error]:    00000010: 00000000 00000000 00000000 00000000  ................
  [ 1419.670692][    C1] {57}[Hardware Error]:    00000020: 00000000 00000000 00000000 00000000  ................
  [ 1419.783606][T54990] Memory failure: 0x1000093: recovery action for free buddy page: Recovered
  [ 1419.919580][ T9955] EDAC MC0: 1 UE Multi-bit ECC on unknown memory (node:0 card:1 module:71 bank:7 row:0 col:0 page:0x1000093 offset:0xc00 grain:1 - APEI location: node:0 card:257 module:71 bank:7 row:0 col:0)
  NOTICE:  SEA Handle
  NOTICE:  SpsrEl3 = 0x60001000, ELR_EL3 = 0xffffc6ab42671400
  NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
  NOTICE:  EsrEl3 = 0x92000410
  NOTICE:  PA is valid: 0x1000093c00
  NOTICE:  Hest Set GenericError Data
  NOTICE:  SEA Handle
  NOTICE:  SpsrEl3 = 0x60001000, ELR_EL3 = 0xffffc6ab42671400
  NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
  NOTICE:  EsrEl3 = 0x92000410
  NOTICE:  PA is valid: 0x1000093c00
  NOTICE:  Hest Set GenericError Data
  ...
  ...        ---> Hapend SEA error interrupt storm
  ...
  NOTICE:  SEA Handle
  NOTICE:  SpsrEl3 = 0x60001000, ELR_EL3 = 0xffffc6ab42671400
  NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
  NOTICE:  EsrEl3 = 0x92000410
  NOTICE:  PA is valid: 0x1000093c00
  NOTICE:  Hest Set GenericError Data
  [ 1429.818080][ T9955] Memory failure: 0x1000093: already hardware poisoned
  [ 1429.825760][    C1] ghes_print_estatus: 1 callbacks suppressed
  [ 1429.825763][    C1] {59}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
  [ 1429.843731][    C1] {59}[Hardware Error]: event severity: recoverable
  [ 1429.861800][    C1] {59}[Hardware Error]:  Error 0, type: recoverable
  [ 1429.874658][    C1] {59}[Hardware Error]:   section_type: ARM processor error
  [ 1429.887516][    C1] {59}[Hardware Error]:   MIDR: 0x0000000000000000
  [ 1429.901159][    C1] {59}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000081000100
  [ 1429.901166][    C1] {59}[Hardware Error]:   error affinity level: 0
  [ 1429.914896][    C1] {59}[Hardware Error]:   running state: 0x1
  [ 1429.914903][    C1] {59}[Hardware Error]:   Power State Coordination Interface state: 0
  [ 1429.933319][    C1] {59}[Hardware Error]:   Error info structure 0:
  [ 1429.946261][    C1] {59}[Hardware Error]:   num errors: 1
  [ 1429.946269][    C1] {59}[Hardware Error]:    error_type: 0, cache error
  [ 1429.970847][    C1] {59}[Hardware Error]:    error_info: 0x0000000020400014
  [ 1429.970854][    C1] {59}[Hardware Error]:     cache level: 1
  [ 1429.988406][    C1] {59}[Hardware Error]:     the error has not been corrected
  [ 1430.013419][    C1] {59}[Hardware Error]:    physical fault address: 0x0000001000093c00
  [ 1430.013425][    C1] {59}[Hardware Error]:   Vendor specific error info has 48 bytes:
  [ 1430.025424][    C1] {59}[Hardware Error]:    00000000: 00000000 00000000 00000000 00000000  ................
  [ 1430.053736][    C1] {59}[Hardware Error]:    00000010: 00000000 00000000 00000000 00000000  ................
  [ 1430.066341][    C1] {59}[Hardware Error]:    00000020: 00000000 00000000 00000000 00000000  ................
  [ 1430.294255][T54990] Memory failure: 0x1000093: already hardware poisoned
  [ 1430.305518][T54990] 0x1000093: Sending SIGBUS to devmem:54990 due to hardware memory corruption

Signed-off-by: Junhao He <hejunhao3@h-partners.com>
---
 drivers/acpi/apei/ghes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 005de10d80c3..eebda39bfc30 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1343,8 +1343,10 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
 
 	/* This error has been reported before, don't process it again. */
-	if (ghes_estatus_cached(estatus))
+	if (ghes_estatus_cached(estatus)) {
+		rc = -ECANCELED;
 		goto no_work;
+	}
 
 	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
 
-- 
2.33.0


