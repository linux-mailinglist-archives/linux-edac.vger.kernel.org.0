Return-Path: <linux-edac+bounces-5764-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJL+BmzzpmmgawAAu9opvQ
	(envelope-from <linux-edac+bounces-5764-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Tue, 03 Mar 2026 15:42:52 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A59D1F1B5F
	for <lists+linux-edac@lfdr.de>; Tue, 03 Mar 2026 15:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37037300AD88
	for <lists+linux-edac@lfdr.de>; Tue,  3 Mar 2026 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462FE3B4EA8;
	Tue,  3 Mar 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LWylvmRL"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FD931F995;
	Tue,  3 Mar 2026 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548965; cv=none; b=WM6jQtzfkjMzzvlVcQc8jHx7FUS7FYVjoEn5esbSgZc9x6jKDumnRQ/GyGooe5r9h+/f1xz5VhVMwiE93r1Xif9EhSGW10dgx3Gg9W2bweb031QK5uSPZaHBuvHdblBqjYf+IsOhYkjI0SSAAYKfKrAjeIltXsZ4ypCggu4fOPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548965; c=relaxed/simple;
	bh=ov+dw7mcIuelyPvpsuZGyqGfvPSWSkMQNmDOiCvJPqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/fmu5dPHzKaDtFojEOOuysuoeQSKNODX1Ykpb49iDwG8I/nbIQlC6umapZumyUPGv9zuS2bTsTLEWOwL3wGiEkjNH05qzes2K6PAUFBCipm+sFSYVFJH2NwFFItKzgjXgKcpZLjxeKfL8lMk3e2JVb0fvTZq17NWkUbiTlBq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LWylvmRL; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772548942; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=S3peIpNNgSUKE7SKMA/0+j/nMY7mouBDvRdptsxPFps=;
	b=LWylvmRLI7WdLXI/Go2ryX8Y0gmwsxTVOwB+P+7c4XvKjJyVdhs2p2v5KUpgxQ4bIA0HZW71mFovt3XaPHTSJ/tmhlfSG7T2S0/RgChI+MGWHqhGBWZbJ8Y9f4wv2dH5y9SVEh6ZBSg3SP2GMW7N//ob8LkDdj8/Vxmerr90MDo=
Received: from 30.246.163.43(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X-ABKFx_1772548939 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 22:42:20 +0800
Message-ID: <70b85b7c-5107-4f79-abf7-3cc5b7e1438d@linux.alibaba.com>
Date: Tue, 3 Mar 2026 22:42:27 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: APEI: Handle repeated SEA error interrupts storm
 scenarios
To: hejunhao <hejunhao3@h-partners.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Luck, Tony" <tony.luck@intel.com>
Cc: bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org,
 jarkko@kernel.org, yazen.ghannam@amd.com, jane.chu@oracle.com,
 lenb@kernel.org, Jonathan.Cameron@huawei.com, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, shiju.jose@huawei.com, tanxiaofei@huawei.com
References: <20251030071321.2763224-1-hejunhao3@h-partners.com>
 <CAJZ5v0h=QtcT7zhZEgrTjUk7EAk2OfbGG6BoEEv-3toKODMXQA@mail.gmail.com>
 <bf42a19d-0f5d-48d8-91f5-febb8bfd06d3@linux.alibaba.com>
 <9817f221-5b5f-7c25-ab94-cb04a854553a@h-partners.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <9817f221-5b5f-7c25-ab94-cb04a854553a@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A59D1F1B5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5764-lists,linux-edac=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xueshuai@linux.alibaba.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi, junhao,

On 2/27/26 8:12 PM, hejunhao wrote:
> 
> 
> On 2025/11/4 9:32, Shuai Xue wrote:
>>
>>
>> 在 2025/11/4 00:19, Rafael J. Wysocki 写道:
>>> On Thu, Oct 30, 2025 at 8:13 AM Junhao He <hejunhao3@h-partners.com> wrote:
>>>>
>>>> The do_sea() function defaults to using firmware-first mode, if supported.
>>>> It invoke acpi/apei/ghes ghes_notify_sea() to report and handling the SEA
>>>> error, The GHES uses a buffer to cache the most recent 4 kinds of SEA
>>>> errors. If the same kind SEA error continues to occur, GHES will skip to
>>>> reporting this SEA error and will not add it to the "ghes_estatus_llist"
>>>> list until the cache times out after 10 seconds, at which point the SEA
>>>> error will be reprocessed.
>>>>
>>>> The GHES invoke ghes_proc_in_irq() to handle the SEA error, which
>>>> ultimately executes memory_failure() to process the page with hardware
>>>> memory corruption. If the same SEA error appears multiple times
>>>> consecutively, it indicates that the previous handling was incomplete or
>>>> unable to resolve the fault. In such cases, it is more appropriate to
>>>> return a failure when encountering the same error again, and then proceed
>>>> to arm64_do_kernel_sea for further processing.

There is no such function in the arm64 tree. If apei_claim_sea() returns
an error, the actual fallback path in do_sea() is arm64_notify_die(),
which sends SIGBUS?

>>>>
>>>> When hardware memory corruption occurs, a memory error interrupt is
>>>> triggered. If the kernel accesses this erroneous data, it will trigger
>>>> the SEA error exception handler. All such handlers will call
>>>> memory_failure() to handle the faulty page.
>>>>
>>>> If a memory error interrupt occurs first, followed by an SEA error
>>>> interrupt, the faulty page is first marked as poisoned by the memory error
>>>> interrupt process, and then the SEA error interrupt handling process will
>>>> send a SIGBUS signal to the process accessing the poisoned page.
>>>>
>>>> However, if the SEA interrupt is reported first, the following exceptional
>>>> scenario occurs:
>>>>
>>>> When a user process directly requests and accesses a page with hardware
>>>> memory corruption via mmap (such as with devmem), the page containing this
>>>> address may still be in a free buddy state in the kernel. At this point,
>>>> the page is marked as "poisoned" during the SEA claim memory_failure().
>>>> However, since the process does not request the page through the kernel's
>>>> MMU, the kernel cannot send SIGBUS signal to the processes. And the memory
>>>> error interrupt handling process not support send SIGBUS signal. As a
>>>> result, these processes continues to access the faulty page, causing
>>>> repeated entries into the SEA exception handler. At this time, it lead to
>>>> an SEA error interrupt storm.

In such case, the user process which accessing the poisoned page will be killed
by memory_fauilre?

// memory_failure():

	if (TestSetPageHWPoison(p)) {
		res = -EHWPOISON;
		if (flags & MF_ACTION_REQUIRED)
			res = kill_accessing_process(current, pfn, flags);
		if (flags & MF_COUNT_INCREASED)
			put_page(p);
		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
		goto unlock_mutex;
	}

I think this problem has already been fixed by commit 2e6053fea379 ("mm/memory-failure:
fix infinite UCE for VM_PFNMAP pfn").

The root cause is that walk_page_range() skips VM_PFNMAP vmas by default when
no .test_walk callback is set, so kill_accessing_process() returns 0 for a
devmem-style mapping (remap_pfn_range, VM_PFNMAP), making the caller believe
the UCE was handled properly while the process was never actually killed.

Did you try the lastest kernel version?

>>>>
>>>> Fixes this by returning a failure when encountering the same error again.
>>>>
>>>> The following error logs is explained using the devmem process:
>>>>     NOTICE:  SEA Handle
>>>>     NOTICE:  SpsrEl3 = 0x60001000, ELR_EL3 = 0xffffc6ab42671400
>>>>     NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
>>>>     NOTICE:  EsrEl3 = 0x92000410
>>>>     NOTICE:  PA is valid: 0x1000093c00
>>>>     NOTICE:  Hest Set GenericError Data
>>>>     [ 1419.542401][    C1] {57}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>>>>     [ 1419.551435][    C1] {57}[Hardware Error]: event severity: recoverable
>>>>     [ 1419.557865][    C1] {57}[Hardware Error]:  Error 0, type: recoverable
>>>>     [ 1419.564295][    C1] {57}[Hardware Error]:   section_type: ARM processor error
>>>>     [ 1419.571421][    C1] {57}[Hardware Error]:   MIDR: 0x0000000000000000
>>>>     [ 1419.571434][    C1] {57}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000081000100
>>>>     [ 1419.586813][    C1] {57}[Hardware Error]:   error affinity level: 0
>>>>     [ 1419.586821][    C1] {57}[Hardware Error]:   running state: 0x1
>>>>     [ 1419.602714][    C1] {57}[Hardware Error]:   Power State Coordination Interface state: 0
>>>>     [ 1419.602724][    C1] {57}[Hardware Error]:   Error info structure 0:
>>>>     [ 1419.614797][    C1] {57}[Hardware Error]:   num errors: 1
>>>>     [ 1419.614804][    C1] {57}[Hardware Error]:    error_type: 0, cache error
>>>>     [ 1419.629226][    C1] {57}[Hardware Error]:    error_info: 0x0000000020400014
>>>>     [ 1419.629234][    C1] {57}[Hardware Error]:     cache level: 1
>>>>     [ 1419.642006][    C1] {57}[Hardware Error]:     the error has not been corrected
>>>>     [ 1419.642013][    C1] {57}[Hardware Error]:    physical fault address: 0x0000001000093c00
>>>>     [ 1419.654001][    C1] {57}[Hardware Error]:   Vendor specific error info has 48 bytes:
>>>>     [ 1419.654014][    C1] {57}[Hardware Error]:    00000000: 00000000 00000000 00000000 00000000  ................
>>>>     [ 1419.670685][    C1] {57}[Hardware Error]:    00000010: 00000000 00000000 00000000 00000000  ................
>>>>     [ 1419.670692][    C1] {57}[Hardware Error]:    00000020: 00000000 00000000 00000000 00000000  ................
>>>>     [ 1419.783606][T54990] Memory failure: 0x1000093: recovery action for free buddy page: Recovered
>>>>     [ 1419.919580][ T9955] EDAC MC0: 1 UE Multi-bit ECC on unknown memory (node:0 card:1 module:71 bank:7 row:0 col:0 page:0x1000093 offset:0xc00 grain:1 - APEI location: node:0 card:257 module:71 bank:7 row:0 col:0)
>>>>     NOTICE:  SEA Handle
>>>>     NOTICE:  SpsrEl3 = 0x60001000, ELR_EL3 = 0xffffc6ab42671400
>>>>     NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
>>>>     NOTICE:  EsrEl3 = 0x92000410
>>>>     NOTICE:  PA is valid: 0x1000093c00
>>>>     NOTICE:  Hest Set GenericError Data
>>>>     NOTICE:  SEA Handle
>>>>     NOTICE:  SpsrEl3 = 0x60001000, ELR_EL3 = 0xffffc6ab42671400
>>>>     NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
>>>>     NOTICE:  EsrEl3 = 0x92000410
>>>>     NOTICE:  PA is valid: 0x1000093c00
>>>>     NOTICE:  Hest Set GenericError Data
>>>>     ...
>>>>     ...        ---> Hapend SEA error interrupt storm
>>>>     ...
>>>>     NOTICE:  SEA Handle
>>>>     NOTICE:  SpsrEl3 = 0x60001000, ELR_EL3 = 0xffffc6ab42671400
>>>>     NOTICE:  skt[0x0]die[0x0]cluster[0x0]core[0x1]
>>>>     NOTICE:  EsrEl3 = 0x92000410
>>>>     NOTICE:  PA is valid: 0x1000093c00
>>>>     NOTICE:  Hest Set GenericError Data
>>>>     [ 1429.818080][ T9955] Memory failure: 0x1000093: already hardware poisoned
>>>>     [ 1429.825760][    C1] ghes_print_estatus: 1 callbacks suppressed
>>>>     [ 1429.825763][    C1] {59}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>>>>     [ 1429.843731][    C1] {59}[Hardware Error]: event severity: recoverable
>>>>     [ 1429.861800][    C1] {59}[Hardware Error]:  Error 0, type: recoverable
>>>>     [ 1429.874658][    C1] {59}[Hardware Error]:   section_type: ARM processor error
>>>>     [ 1429.887516][    C1] {59}[Hardware Error]:   MIDR: 0x0000000000000000
>>>>     [ 1429.901159][    C1] {59}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000081000100
>>>>     [ 1429.901166][    C1] {59}[Hardware Error]:   error affinity level: 0
>>>>     [ 1429.914896][    C1] {59}[Hardware Error]:   running state: 0x1
>>>>     [ 1429.914903][    C1] {59}[Hardware Error]:   Power State Coordination Interface state: 0
>>>>     [ 1429.933319][    C1] {59}[Hardware Error]:   Error info structure 0:
>>>>     [ 1429.946261][    C1] {59}[Hardware Error]:   num errors: 1
>>>>     [ 1429.946269][    C1] {59}[Hardware Error]:    error_type: 0, cache error
>>>>     [ 1429.970847][    C1] {59}[Hardware Error]:    error_info: 0x0000000020400014
>>>>     [ 1429.970854][    C1] {59}[Hardware Error]:     cache level: 1
>>>>     [ 1429.988406][    C1] {59}[Hardware Error]:     the error has not been corrected
>>>>     [ 1430.013419][    C1] {59}[Hardware Error]:    physical fault address: 0x0000001000093c00
>>>>     [ 1430.013425][    C1] {59}[Hardware Error]:   Vendor specific error info has 48 bytes:
>>>>     [ 1430.025424][    C1] {59}[Hardware Error]:    00000000: 00000000 00000000 00000000 00000000  ................
>>>>     [ 1430.053736][    C1] {59}[Hardware Error]:    00000010: 00000000 00000000 00000000 00000000  ................
>>>>     [ 1430.066341][    C1] {59}[Hardware Error]:    00000020: 00000000 00000000 00000000 00000000  ................
>>>>     [ 1430.294255][T54990] Memory failure: 0x1000093: already hardware poisoned
>>>>     [ 1430.305518][T54990] 0x1000093: Sending SIGBUS to devmem:54990 due to hardware memory corruption
>>>>
>>>> Signed-off-by: Junhao He <hejunhao3@h-partners.com>
>>>> ---
>>>>    drivers/acpi/apei/ghes.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>>> index 005de10d80c3..eebda39bfc30 100644
>>>> --- a/drivers/acpi/apei/ghes.c
>>>> +++ b/drivers/acpi/apei/ghes.c
>>>> @@ -1343,8 +1343,10 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
>>>>           ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
>>>>
>>>>           /* This error has been reported before, don't process it again. */
>>>> -       if (ghes_estatus_cached(estatus))
>>>> +       if (ghes_estatus_cached(estatus)) {
>>>> +               rc = -ECANCELED;
>>>>                   goto no_work;
>>>> +       }
>>>>
>>>>           llist_add(&estatus_node->llnode, &ghes_estatus_llist);
>>>>
>>>> -- 
>>>
>>> This needs a response from the APEI reviewers as per MAINTAINERS, thanks!
>>
>> Hi, Rafael and Junhao,
>>
>> Sorry for late response, I try to reproduce the issue, it seems that
>> EINJ systems broken in 6.18.0-rc1+.
>>
>> [ 3950.741186] CPU: 36 UID: 0 PID: 74112 Comm: einj_mem_uc Tainted: G            E       6.18.0-rc1+ #227 PREEMPT(none)
>> [ 3950.751749] Tainted: [E]=UNSIGNED_MODULE
>> [ 3950.755655] Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDD, BIOS 1.91 07/29/2022
>> [ 3950.763797] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [ 3950.770729] pc : acpi_os_write_memory+0x108/0x150
>> [ 3950.775419] lr : acpi_os_write_memory+0x28/0x150
>> [ 3950.780017] sp : ffff800093fbba40
>> [ 3950.783319] x29: ffff800093fbba40 x28: 0000000000000000 x27: 0000000000000000
>> [ 3950.790425] x26: 0000000000000002 x25: ffffffffffffffff x24: 000000403f20e400
>> [ 3950.797530] x23: 0000000000000000 x22: 0000000000000008 x21: 000000000000ffff
>> [ 3950.804635] x20: 0000000000000040 x19: 000000002f7d0018 x18: 0000000000000000
>> [ 3950.811741] x17: 0000000000000000 x16: ffffae52d36ae5d0 x15: 000000001ba8e890
>> [ 3950.818847] x14: 0000000000000000 x13: 0000000000000000 x12: 0000005fffffffff
>> [ 3950.825952] x11: 0000000000000001 x10: ffff00400d761b90 x9 : ffffae52d365b198
>> [ 3950.833058] x8 : 0000280000000000 x7 : 000000002f7d0018 x6 : ffffae52d5198548
>> [ 3950.840164] x5 : 000000002f7d1000 x4 : 0000000000000018 x3 : ffff204016735060
>> [ 3950.847269] x2 : 0000000000000040 x1 : 0000000000000000 x0 : ffff8000845bd018
>> [ 3950.854376] Call trace:
>> [ 3950.856814]  acpi_os_write_memory+0x108/0x150 (P)
>> [ 3950.861500]  apei_write+0xb4/0xd0
>> [ 3950.864806]  apei_exec_write_register_value+0x88/0xc0
>> [ 3950.869838]  __apei_exec_run+0xac/0x120
>> [ 3950.873659]  __einj_error_inject+0x88/0x408 [einj]
>> [ 3950.878434]  einj_error_inject+0x168/0x1f0 [einj]
>> [ 3950.883120]  error_inject_set+0x48/0x60 [einj]
>> [ 3950.887548]  simple_attr_write_xsigned.constprop.0.isra.0+0x14c/0x1d0
>> [ 3950.893964]  simple_attr_write+0x1c/0x30
>> [ 3950.897873]  debugfs_attr_write+0x54/0xa0
>> [ 3950.901870]  vfs_write+0xc4/0x240
>> [ 3950.905173]  ksys_write+0x70/0x108
>> [ 3950.908562]  __arm64_sys_write+0x20/0x30
>> [ 3950.912471]  invoke_syscall+0x4c/0x110
>> [ 3950.916207]  el0_svc_common.constprop.0+0x44/0xe8
>> [ 3950.920893]  do_el0_svc+0x20/0x30
>> [ 3950.924194]  el0_svc+0x38/0x160
>> [ 3950.927324]  el0t_64_sync_handler+0x98/0xe0
>> [ 3950.931491]  el0t_64_sync+0x184/0x188
>> [ 3950.935140] Code: 14000006 7101029f 54000221 d50332bf (f9000015)
>> [ 3950.941210] ---[ end trace 0000000000000000 ]---
>> [ 3950.945807] Kernel panic - not syncing: Oops: Fatal exception
>>
>> We need to fix it first.
> 
> Hi shuai xue,
> 
> Sorry for my late reply. Thank you for the review.
> To clarify the issue:
> This problem was introduced in v6.18-rc1 via a suspicious ARM64
> memory mapping change [1]. I can reproduce the crash consistently
> using the v6.18-rc1 kernel with this patch applied.
> 
> Crucially, the crash disappears when the change is reverted — error
> injection completes successfully without any kernel panic or oops.
> This confirms that the ARM64 memory mapping change is the root cause.
> 
> As noted in the original report, the change was reverted in v6.19-rc1, and
> subsequent kernels (including v6.19-rc1 and later) are stable and do not
> exhibit this problem.
> 
> reproduce  logs:
> [  216.347073] Unable to handle kernel write to read-only memory at virtual address ffff800084825018
> ...
> [  216.475949] CPU: 75 UID: 0 PID: 11477 Comm: sh Kdump: loaded Not tainted 6.18.0-rc1+ #60 PREEMPT
> [  216.486561] Hardware name: Huawei TaiShan 2280 V2/BC82AMDD, BIOS 1.91 07/29/2022
> [  216.587297] Call trace:
> [  216.589904]  acpi_os_write_memory+0x188/0x1c8 (P)
> [  216.594763]  apei_write+0xcc/0xe8
> [  216.598238]  apei_exec_write_register_value+0x90/0xd0
> [  216.603437]  __apei_exec_run+0xb0/0x128
> [  216.607420]  __einj_error_inject+0xac/0x450
> [  216.611750]  einj_error_inject+0x19c/0x220
> [  216.615988]  error_inject_set+0x4c/0x68
> [  216.619962]  simple_attr_write_xsigned.constprop.0.isra.0+0xe8/0x1b0
> [  216.626445]  simple_attr_write+0x20/0x38
> [  216.630502]  debugfs_attr_write+0x58/0xa8
> [  216.634643]  vfs_write+0xdc/0x408
> [  216.638088]  ksys_write+0x78/0x118
> [  216.641610]  __arm64_sys_write+0x24/0x38
> [  216.645648]  invoke_syscall+0x50/0x120
> [  216.649510]  el0_svc_common.constprop.0+0xc8/0xf0
> [  216.654318]  do_el0_svc+0x24/0x38
> [  216.657742]  el0_svc+0x38/0x150
> [  216.660996]  el0t_64_sync_handler+0xa0/0xe8
> [  216.665286]  el0t_64_sync+0x1ac/0x1b0
> [  216.669054] Code: d65f03c0 710102ff 540001e1 d50332bf (f9000295)
> [  216.675244] ---[ end trace 0000000000000000 ]---
> 
> [1] https://lore.kernel.org/all/20251121224611.07efa95a@foz.lan/
> 
> Best regards,
> Junhao.

Thanks for clarify the issue.

Thanks.
Shuai


