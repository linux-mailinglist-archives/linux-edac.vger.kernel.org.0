Return-Path: <linux-edac+bounces-4681-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 347B5B3514A
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 03:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2424C1A876B1
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 01:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B11D1FDE19;
	Tue, 26 Aug 2025 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="OdestZrw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C720F25F98A;
	Tue, 26 Aug 2025 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756173490; cv=none; b=Aw1TO6diZfpLoC6/I1Km0u8DKcKo8sYZwjD34AtQBhP0DOyKPRhXUrr0qdIwQMP2Z4iXrCfcS0485kwKfW+C4Vyvfx2zET0hmxdfwW6s0IOHO3l/TlQTxdj4OHEnC1z/scn3hRdmQnyZs++glaD0huGkZMxJFXYPOyuqmHq57Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756173490; c=relaxed/simple;
	bh=911as14KgJsJVgpdmIaiOaAoGydhgdF03A1AMBWMslo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qd7SQLBvUNFcQhYptXtYD6DCbCdQmZ4crTWkSnI/298Lv0ye1K1hRGTCJKY7wj7gybK3GPcbv4fX5+rldj/IfPu2rQXEr6vX79nWwGSGShrSd/bMsmXAROS2LTPiCqWxC1F6MJC/Cn42ERwF3V4dR3tX0iVd5gUFktSJ/fdqag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=unknown smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=OdestZrw; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PIhYOX010998;
	Tue, 26 Aug 2025 01:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=q3
	e2ypT3Kx6Yk73bwvacvSvu/yuGOsKJ/34CpZyahLM=; b=OdestZrwhcBNQMcaOB
	NuxwGYIa/nrXisiL9KNmm877OTiNmM1AKTmg/0rCGWxm9WQGMdWKoXNObrxbu30O
	GN+kSa2pLDgTdczlN+3FXkpmfJ1mdZNodesZ4wRyr8/xAl4DTMitRxZF+sMjoqK2
	0tGa2sP+0yytiriXLLO2Gp0rTUUhwbkABQPth2IEYwhIzfevqEBIXWL0qOAijBI+
	vJTXM08nhOkCF8t+ZEIHEdhKvX9rkXw7MCokl7Tx5F1f7C5yDURteWoaJLHu5lvU
	wNh6i7DSgFKR7l2jAxvvM1xtEHe5ZjSDWGkzX5iiEqYyIDFl1dDBgIWLQ18MpQ0E
	2qIQ==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48rwc12t1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 01:56:56 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id E061C130EC;
	Tue, 26 Aug 2025 01:56:35 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id D1FEF8014CE;
	Tue, 26 Aug 2025 01:56:32 +0000 (UTC)
Date: Mon, 25 Aug 2025 20:56:30 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: jane.chu@oracle.com
Cc: Miaohe Lin <linmiaohe@huawei.com>, Jiaqi Yan <jiaqiyan@google.com>,
        akpm@linux-foundation.org, david@redhat.com, tony.luck@intel.com,
        bp@alien8.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        osalvador@suse.de
Subject: Re: [PATCH] mm/memory-failure: Do not call action_result() on
 already poisoned pages
Message-ID: <aK0UTovxnKfjPwXs@hpe.com>
References: <20250821164445.14467-1-kyle.meyer@hpe.com>
 <CACw3F53KmKRJyH+ajicyDUgGbPZT=U3VE4n+Jt3E62BxEiiCGA@mail.gmail.com>
 <aKd1K3ueTacGTf1W@hpe.com>
 <CACw3F527M-x=UeB0tN_sjCgp_YP_8yLkVRCLP2dLO2bzXrqWsA@mail.gmail.com>
 <14a0dd45-388d-7a32-5ee5-44e60277271a@huawei.com>
 <aKyKort2opfQYqgA@hpe.com>
 <2bd5c32b-dfc4-4345-8cc8-bbda5acdc596@oracle.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bd5c32b-dfc4-4345-8cc8-bbda5acdc596@oracle.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDAxNCBTYWx0ZWRfX77CJDoR4U+bo
 adA0Byap4kY4QNffTn/8w4l6Y0Di6CfcyCKXwdkK/7sIZTalDyO7Dw8qfIb06flAOD/C+dbK4Ck
 4KVI/94bV+VSbzwhWpZFvrAR9DUBi4ji1MoCYrvZwL+t9huiE0bzbQY54MH739HWD/T2oRiNnYY
 5eRrgWIU+JnxELLMgWyDNSm9l+NhFWtVbv+xHOVM8TOeocNGJf29+1S/LKNSW8+6V8tTHwASige
 Kj/xsvL/wtZOhiZ2Gsfmv/vM8rJ95FQgDoNCcmsoHMqe0VueEmMc1ouQMg2bqZxUjxflBnicEM1
 emquCn8wvGd+X3wdDi3h7utZk+5i/kSqfiazPzit/6sjnOYWeZZ6WjkyHxq34ny3H/byvoy9kOG
 5JFbqAP8RKyGnOlcROihqSby3nWxHPBkfEDFAEvVB6NpmRecJ+4G+Th2/RDuZQ3OiJ7bW/I6
X-Authority-Analysis: v=2.4 cv=EMYG00ZC c=1 sm=1 tr=0 ts=68ad1468 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=MvuuwTCpAAAA:8
 a=1XWaLZrsAAAA:8 a=VzHv1wIHhfcjo_lpb9wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sIWRHfsPa6103QyDutpgkX3sUVCctQYx
X-Proofpoint-GUID: sIWRHfsPa6103QyDutpgkX3sUVCctQYx
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260014

On Mon, Aug 25, 2025 at 03:36:54PM -0700, jane.chu@oracle.com wrote:
> On 8/25/2025 9:09 AM, Kyle Meyer wrote:
> > On Mon, Aug 25, 2025 at 11:04:43AM +0800, Miaohe Lin wrote:
> > > On 2025/8/22 8:24, Jiaqi Yan wrote:
> > > > On Thu, Aug 21, 2025 at 12:36 PM Kyle Meyer <kyle.meyer@hpe.com> wrote:
> > > > > 
> > > > > On Thu, Aug 21, 2025 at 11:23:48AM -0700, Jiaqi Yan wrote:
> > > > > > On Thu, Aug 21, 2025 at 9:46 AM Kyle Meyer <kyle.meyer@hpe.com> wrote:
> > > > > > > 
> > > > > > > Calling action_result() on already poisoned pages causes issues:
> > > > > > > 
> > > > > > > * The amount of hardware corrupted memory is incorrectly incremented.
> > > > > > > * NUMA node memory failure statistics are incorrectly updated.
> > > > > > > * Redundant "already poisoned" messages are printed.
> 
> Assuming this means that the numbers reported from
>   /sys/devices/system/node/node*/memory_failure/*
> do not match certain expectation, right?
> 
> If so, could you clarify what is the expectation?

Sure, and please let me know if I'm mistaken.

Here's the description of total:

What:		/sys/devices/system/node/nodeX/memory_failure/total
Date:		January 2023
Contact:	Jiaqi Yan <jiaqiyan@google.com>
Description:
		The total number of raw poisoned pages (pages containing
		corrupted data due to memory errors) on a NUMA node.

That should emit the number of poisoned pages on NUMA node X. That's
incremented each time update_per_node_mf_stats() is called.

Here's the description of failed:

What:		/sys/devices/system/node/nodeX/memory_failure/failed
Date:		January 2023
Contact:	Jiaqi Yan <jiaqiyan@google.com>
Description:
		Of the raw poisoned pages on a NUMA node, how many pages are
		failed by memory error recovery attempt. This usually means
		a key recovery operation failed.

That should emit the number of poisoned pages on NUMA node X that could
not be recovered because the attempt failed. That's incremented each time
update_per_node_mf_stats() is called with MF_FAILED.

We're currently calling action_result() with MF_FAILED each time we encounter
a poisoned page (note: the huge page path is a bit different, we only call
action_result() with MF_FAILED when MF_ACTION_REQUIRED is set). That, IMO,
breaks the descriptions. We already incremented the per NUMA node MF statistics
to account for that poisoned page.

> > > > > > 
> > > > > > All agreed.
> > > > > > 
> > > > > > > 
> > > > > > > Do not call action_result() on already poisoned pages and drop unused
> > > > > > > MF_MSG_ALREADY_POISONED.
> > > > > > 
> > > > > > Hi Kyle,
> > > > > > 
> > > > > > Patch looks great to me, just one thought...
> > > 
> > > Thanks both.
> > > 
> > > > > > 
> > > > > > Alternatively, have you thought about keeping MF_MSG_ALREADY_POISONED
> > > > > > but changing action_result for MF_MSG_ALREADY_POISONED?
> > > > > > - don't num_poisoned_pages_inc(pfn)
> > > > > > - don't update_per_node_mf_stats(pfn, result)
> > > > > > - still pr_err("%#lx: recovery action for %s: %s\n", ...)
> > > > > > - meanwhile remove "pr_err("%#lx: already hardware poisoned\n", pfn)"
> > > > > > in memory_failure and try_memory_failure_hugetlb
> > > > > 
> > > > > I did consider that approach but I was concerned about passing
> > > > > MF_MSG_ALREADY_POISONED to action_result() with MF_FAILED. The message is a
> > > > > bit misleading.
> > > > 
> > > > Based on my reading the documentation for MF_* in static const char
> > > > *action_name[]...
> > > > 
> > > > Yeah, for file mapped pages, kernel may not have hole-punched or
> > > > truncated it from the file mapping (shmem and hugetlbfs for example)
> > > > but that still considered as MF_RECOVERED, so touching a page with
> > > > HWPoison flag doesn't mean that page was failed to be recovered
> > > > previously.
> > > > 
> > > > For pages intended to be taken out of the buddy system, touching a
> > > > page with HWPoison flag does imply it isn't isolated and hence
> > > > MF_FAILED.
> > > 
> > > There should be other cases that memory_failure failed to isolate the
> > > hwpoisoned pages at first time due to various reasons.
> > > 
> > > > 
> > > > In summary, seeing the HWPoison flag again doesn't necessarily
> > > > indicate what the recovery result was previously; it only indicate
> > > > kernel won't re-attempt to recover?
> > > 
> > > Yes, kernel won't re-attempt to or just cannot recover.
> > > 
> > > > 
> > > > > 
> > > > > How about introducing a new MF action result? Maybe MF_NONE? The message could
> > > > > look something like:
> > > > 
> > > > Adding MF_NONE sounds fine to me, as long as we correctly document its
> > > > meaning, which can be subtle.
> > > 
> > > Adding a new MF action result sounds good to me. But IMHO MF_NONE might not be that suitable
> > > as kill_accessing_process might be called to kill proc in this case, so it's not "NONE".
> > 
> > OK, would you like a separate MF action result for each case? Maybe
> > MF_ALREADY_POISONED and MF_ALREADY_POISONED_KILLED?
> > 
> > MF_ALREADY_POISONED can be the default and MF_ALREADY_POISONED_KILLED can be
> > used when kill_accessing_process() returns -EHWPOISON.
> > 
> > The log messages could look like...
> > 
> > Memory failure: 0xXXXXXXXX: recovery action for already poisoned page: None
> > 	and
> > Memory failure: 0xXXXXXXXX: recovery action for already poisoned page: Process killed
> 
> Agreed with Miaohe that "None" won't work.

What action is M-F() taking to recover already poisoned pages that don't have
MF_ACTION_REQUIRED set?

> "Process killed" sounds okay for MF_MSG_ALREADY_POISONED, but
> we need to understand why "Failed" doesn't work for your usecase.
> "Failed" means process is killed but page is not successfully isolated which
> applies to MF_MSG_ALREADY_POISONED case as well.

So that accessing process is killed. Why call action_result() with MF_FAILED?
Doesn't that indicate we poisoned another page and the recovery attempt failed?

Thanks,
Kyle Meyer

