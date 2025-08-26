Return-Path: <linux-edac+bounces-4692-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798DBB3730B
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 21:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7C17C7420
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 19:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E24336CC6B;
	Tue, 26 Aug 2025 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="g/kNUoMX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F423AB95;
	Tue, 26 Aug 2025 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236539; cv=none; b=i1luT7+azG+m0mHzcUNPS+BxbXHzYZ73PyfyEOiOFj8LvImBcEOLkCjaFuywuQGr0hap4Jup52IkRHMFmHJ46gIKdm48dQKKa2YC2TGKv43Ui8ENYFGsDCx5x65pp7cH4f2AG/CazoeVnfvzCUxGvtnQUUxaniLdgkgxCdGPcsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236539; c=relaxed/simple;
	bh=fSRIf4Xe64L2oK0XY0LOylbILODNKG0uLv7LA5A2FeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwZQK+ZqIl2QrzoIA8eKF908jP5bmWzX7Ul3RExsBSo76elmaKLwYgjv6eGRQMvIryOWeOb9s3yJXxluohZHoF28OXJrLfheCXNTJQSl8B4ul6Y5gAOgv/F6IfMMq0coSoMc0pCFww0prf0t/nJ8l9UNSrfpmehYVvh7aAZ2HyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=g/kNUoMX; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QEnWvt005250;
	Tue, 26 Aug 2025 19:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=7J
	UHf7BGcTCGx0OjIaqQaW89aRdyWS24lXplepqdf0Y=; b=g/kNUoMXTvnT5Ku/cb
	9bBfSQn+TMvZQjL6YZWvSskTESSPnBEL9fumxirEoiFEUspBWyuXA1GzJDrj74Xc
	dzRbz2SgJcR+V47fNbUnvpGBedg9FHKzIHN71Mi/tx76JUAe6TBU/0e4F3omzvi2
	hkHQp9xTEmRAGO0QnTF4RRLOQWPzASxGaHvnYp3P82miHcza+OH0BC1D8tij+9mo
	89T1tGrQ6QydTAkrO+f61PCx6U8ZMH0wzBInAaBtW/RUoXnRkDQy57U/T9bqE0h6
	BGhGoLYpd4V300MEUv4KCGlN/6a85iSKdZoqWhEEMJdWfDhR9tpYxNT8gu3ruTIR
	rwPw==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48sf17au8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 19:27:54 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 969BD130D8;
	Tue, 26 Aug 2025 19:27:52 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 6E097809D02;
	Tue, 26 Aug 2025 19:27:49 +0000 (UTC)
Date: Tue, 26 Aug 2025 14:27:47 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: jane.chu@oracle.com
Cc: Miaohe Lin <linmiaohe@huawei.com>, Jiaqi Yan <jiaqiyan@google.com>,
        akpm@linux-foundation.org, david@redhat.com, tony.luck@intel.com,
        bp@alien8.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        osalvador@suse.de, russ.anderson@hpe.com
Subject: Re: [PATCH] mm/memory-failure: Do not call action_result() on
 already poisoned pages
Message-ID: <aK4Ksy872gR7WuQF@hpe.com>
References: <20250821164445.14467-1-kyle.meyer@hpe.com>
 <CACw3F53KmKRJyH+ajicyDUgGbPZT=U3VE4n+Jt3E62BxEiiCGA@mail.gmail.com>
 <aKd1K3ueTacGTf1W@hpe.com>
 <CACw3F527M-x=UeB0tN_sjCgp_YP_8yLkVRCLP2dLO2bzXrqWsA@mail.gmail.com>
 <14a0dd45-388d-7a32-5ee5-44e60277271a@huawei.com>
 <aKyKort2opfQYqgA@hpe.com>
 <2bd5c32b-dfc4-4345-8cc8-bbda5acdc596@oracle.com>
 <aK0UTovxnKfjPwXs@hpe.com>
 <714d066a-a06e-4b49-b66f-68952c6520d9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <714d066a-a06e-4b49-b66f-68952c6520d9@oracle.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE3MSBTYWx0ZWRfX/iay3UD/QIpG
 ZhRWyAqGXSPnmUyBHzU1VEPLrTEjXCkS6onG9h7yiMGttrr6J022MV4K2q8IJNtEkqT7KkWi6bH
 Wn3BackBAowKiWca6Zaf0DtDwcthbjvVsoVAjvMubjVqvVAP7pMmWoF5Y6dj9ZSyB/V7rFOErb3
 T30pVuTetvwN3vvy0mACUxYaAJG+iOmcbizstAB+VwSHmNqhOGipAgCJsE7tjzVgFzo0WonZGGl
 or35urLsDkN6nDxb3N0XPyx8f0M9a/yWa81iXIupaBgDGUPZ3IzCv6r0ja/BegIoM63j6jGci1d
 RbawfiBj8xG+rKRkaA+1/YApm1DaxkNkkJcxxN+Uc/hArcWmWp0tMW1BGSHcHJIZfQzXgrHgBq3
 mBByblNwEcc4uQXp+0QMMiDXkwLaVrXHeeY/NpCmNhfclZFFTQ6DHcnfhObf1ySNoHxT+rwt
X-Proofpoint-GUID: 1fcIsYQLzFsdnz0CmSebmgZueUEdY4x0
X-Proofpoint-ORIG-GUID: 1fcIsYQLzFsdnz0CmSebmgZueUEdY4x0
X-Authority-Analysis: v=2.4 cv=MZNsu4/f c=1 sm=1 tr=0 ts=68ae0aba cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=MvuuwTCpAAAA:8
 a=1XWaLZrsAAAA:8 a=77G3ujYeI9cyGRGMJesA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260171

On Tue, Aug 26, 2025 at 10:24:07AM -0700, jane.chu@oracle.com wrote:
> 
> On 8/25/2025 6:56 PM, Kyle Meyer wrote:
> > On Mon, Aug 25, 2025 at 03:36:54PM -0700, jane.chu@oracle.com wrote:
> > > On 8/25/2025 9:09 AM, Kyle Meyer wrote:
> > > > On Mon, Aug 25, 2025 at 11:04:43AM +0800, Miaohe Lin wrote:
> > > > > On 2025/8/22 8:24, Jiaqi Yan wrote:
> > > > > > On Thu, Aug 21, 2025 at 12:36 PM Kyle Meyer <kyle.meyer@hpe.com> wrote:
> > > > > > > 
> > > > > > > On Thu, Aug 21, 2025 at 11:23:48AM -0700, Jiaqi Yan wrote:
> > > > > > > > On Thu, Aug 21, 2025 at 9:46 AM Kyle Meyer <kyle.meyer@hpe.com> wrote:
> > > > > > > > > 
> > > > > > > > > Calling action_result() on already poisoned pages causes issues:
> > > > > > > > > 
> > > > > > > > > * The amount of hardware corrupted memory is incorrectly incremented.
> > > > > > > > > * NUMA node memory failure statistics are incorrectly updated.
> > > > > > > > > * Redundant "already poisoned" messages are printed.
> > > 
> > > Assuming this means that the numbers reported from
> > >    /sys/devices/system/node/node*/memory_failure/*
> > > do not match certain expectation, right?
> > > 
> > > If so, could you clarify what is the expectation?
> > 
> > Sure, and please let me know if I'm mistaken.
> > 
> > Here's the description of total:
> > 
> > What:		/sys/devices/system/node/nodeX/memory_failure/total
> > Date:		January 2023
> > Contact:	Jiaqi Yan <jiaqiyan@google.com>
> > Description:
> > 		The total number of raw poisoned pages (pages containing
> > 		corrupted data due to memory errors) on a NUMA node.
> > 
> > That should emit the number of poisoned pages on NUMA node X. That's
> > incremented each time update_per_node_mf_stats() is called.
> > 
> > Here's the description of failed:
> > 
> > What:		/sys/devices/system/node/nodeX/memory_failure/failed
> > Date:		January 2023
> > Contact:	Jiaqi Yan <jiaqiyan@google.com>
> > Description:
> > 		Of the raw poisoned pages on a NUMA node, how many pages are
> > 		failed by memory error recovery attempt. This usually means
> > 		a key recovery operation failed.
> > 
> > That should emit the number of poisoned pages on NUMA node X that could
> > not be recovered because the attempt failed. That's incremented each time
> > update_per_node_mf_stats() is called with MF_FAILED.
> > 
> > We're currently calling action_result() with MF_FAILED each time we encounter
> > a poisoned page (note: the huge page path is a bit different, we only call
> > action_result() with MF_FAILED when MF_ACTION_REQUIRED is set). That, IMO,
> > breaks the descriptions. We already incremented the per NUMA node MF statistics
> > to account for that poisoned page.
> 
> Thanks!  My reading is that these numbers are best as hints, I won't take
> them literately.  As you alluded below, kill_accessing_process is applied
> only if MF_ACTION_REQUIRED is set, though the page is already marked
> poisoned.  Besides, there can be bug that renders a poisoned page not being
> properly isolated nor being properly categorized.  If you're looking for
> something precise, is there another way? maybe from firmware?

Firmware records the number of memory errors that have been detected and
reported, but it doesn't record how Linux responded to those memory errors.

Checking the ring buffer, the amount of hardware corrupted memory, and the
per NUMA node memory failure statistics is a simple way to determine how Linux
responded.

Since commit b8b9488d50b7, that has become unreliable. The same memory error
may be reported by multiple sources and now each report increments the amount of
hardware corrupted memory and the per NUMA node memory failure statistics. Isn't
that a regression?

The per NUMA node memory failure statistics might not always be 100% accurate,
but this issue seems preventable.

> > > > > > > > 
> > > > > > > > All agreed.
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Do not call action_result() on already poisoned pages and drop unused
> > > > > > > > > MF_MSG_ALREADY_POISONED.
> > > > > > > > 
> > > > > > > > Hi Kyle,
> > > > > > > > 
> > > > > > > > Patch looks great to me, just one thought...
> > > > > 
> > > > > Thanks both.
> > > > > 
> > > > > > > > 
> > > > > > > > Alternatively, have you thought about keeping MF_MSG_ALREADY_POISONED
> > > > > > > > but changing action_result for MF_MSG_ALREADY_POISONED?
> > > > > > > > - don't num_poisoned_pages_inc(pfn)
> > > > > > > > - don't update_per_node_mf_stats(pfn, result)
> > > > > > > > - still pr_err("%#lx: recovery action for %s: %s\n", ...)
> > > > > > > > - meanwhile remove "pr_err("%#lx: already hardware poisoned\n", pfn)"
> > > > > > > > in memory_failure and try_memory_failure_hugetlb
> > > > > > > 
> > > > > > > I did consider that approach but I was concerned about passing
> > > > > > > MF_MSG_ALREADY_POISONED to action_result() with MF_FAILED. The message is a
> > > > > > > bit misleading.
> > > > > > 
> > > > > > Based on my reading the documentation for MF_* in static const char
> > > > > > *action_name[]...
> > > > > > 
> > > > > > Yeah, for file mapped pages, kernel may not have hole-punched or
> > > > > > truncated it from the file mapping (shmem and hugetlbfs for example)
> > > > > > but that still considered as MF_RECOVERED, so touching a page with
> > > > > > HWPoison flag doesn't mean that page was failed to be recovered
> > > > > > previously.
> > > > > > 
> > > > > > For pages intended to be taken out of the buddy system, touching a
> > > > > > page with HWPoison flag does imply it isn't isolated and hence
> > > > > > MF_FAILED.
> > > > > 
> > > > > There should be other cases that memory_failure failed to isolate the
> > > > > hwpoisoned pages at first time due to various reasons.
> > > > > 
> > > > > > 
> > > > > > In summary, seeing the HWPoison flag again doesn't necessarily
> > > > > > indicate what the recovery result was previously; it only indicate
> > > > > > kernel won't re-attempt to recover?
> > > > > 
> > > > > Yes, kernel won't re-attempt to or just cannot recover.
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > How about introducing a new MF action result? Maybe MF_NONE? The message could
> > > > > > > look something like:
> > > > > > 
> > > > > > Adding MF_NONE sounds fine to me, as long as we correctly document its
> > > > > > meaning, which can be subtle.
> > > > > 
> > > > > Adding a new MF action result sounds good to me. But IMHO MF_NONE might not be that suitable
> > > > > as kill_accessing_process might be called to kill proc in this case, so it's not "NONE".
> > > > 
> > > > OK, would you like a separate MF action result for each case? Maybe
> > > > MF_ALREADY_POISONED and MF_ALREADY_POISONED_KILLED?
> > > > 
> > > > MF_ALREADY_POISONED can be the default and MF_ALREADY_POISONED_KILLED can be
> > > > used when kill_accessing_process() returns -EHWPOISON.
> > > > 
> > > > The log messages could look like...
> > > > 
> > > > Memory failure: 0xXXXXXXXX: recovery action for already poisoned page: None
> > > > 	and
> > > > Memory failure: 0xXXXXXXXX: recovery action for already poisoned page: Process killed
> > > 
> > > Agreed with Miaohe that "None" won't work.
> > 
> > What action is M-F() taking to recover already poisoned pages that don't have
> > MF_ACTION_REQUIRED set?
> 
> The action taken toward poisoned page not under MF_ACTION_REQUIRED is
> typically isolation, that is, remove the pte or mark the pte as poisoned
> special swap entry, so that subsequent page fault is given a chance to
> deliver a SIGBUS. That said, things might fail during the process, like
> encountering GUP pinned THP page.>
> > > "Process killed" sounds okay for MF_MSG_ALREADY_POISONED, but
> > > we need to understand why "Failed" doesn't work for your usecase.
> > > "Failed" means process is killed but page is not successfully isolated which
> > > applies to MF_MSG_ALREADY_POISONED case as well.
> > 
> > So that accessing process is killed. Why call action_result() with MF_FAILED?
> > Doesn't that indicate we poisoned another page and the recovery attempt failed?
> 
> What I recall is that, "recovery" is reserved for page that is clean,
> isolated, and even by chance, unmapped.  "failed" is reserved for page that
> has been(or might not?) removed from the page table, page might be dirty,
> certainly mapped, etc. A SIGBUS doesn't make recovery an automatic success.
> 
> Others please correct me if I'm mistaken.

Thank you very much for taking the time to explain everything.

Thanks,
Kyle Meyer

