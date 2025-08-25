Return-Path: <linux-edac+bounces-4656-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941B5B346F0
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 18:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C882A4A2A
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932BA274B56;
	Mon, 25 Aug 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="BZv7aZNE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9632A301034;
	Mon, 25 Aug 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138235; cv=none; b=Z14KvqstUPSZLOk7satVIQcbK7unx0bT2inz0SnOlrLiMwcNjl+pJSBq4OspyDOeDekFfT6oeniQtCGxuLIdvBwXZ2dgSmmVep1QsP4htwjfMtHONNFXmLkr+ymg5RNBwAR5g3ljYz0EhbA/cSQTaZogdjoA1r8O4OPUilJnkBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138235; c=relaxed/simple;
	bh=P8XGQESn+FTZdmVay8MRlOAG5BK1vdHzeEJ7SdMsQdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryxeo5QVzN6hGlyv+TZBCZ3d8sBtItd7XD1avNZClRVnpjyVPBTWU/MrS0BrQLBGqzpHFc7RHMISZsMl/c1GZR1RncQRBB97YtSL3pUM1BjXAgzAf5JIfgrUNaTHKTJ/AilJ+i74dsMXoZ6vJsb1NuNqbTZP+rQROrJUfLlX+ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=BZv7aZNE; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PCNc4l029977;
	Mon, 25 Aug 2025 16:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=sQ
	H2klu1q9w/NyJjrasqKq1tGmDd3ucFuLZtG1LKn80=; b=BZv7aZNECNBSQkdGA2
	8twBMjCYGOwkxdSEOXhC1z9DwHwoNNt1eQIq97g8jtcPYLT0e4pRleKzYd4qRlNE
	e5sSQTAOlZqZ7TgRYFJnpqbLO63L23IQ4pZxqF96n0kAsPit9+6Q7Iuqb2+mAHBo
	7aSZn0pRR+1KLabMU+vsqPC/DLUH+aClU0hEvSkluWwqm28t0luI99KzkaS5D6RT
	JrJUiJkfR1LTIDbArRsP93f6yRX5CPDFoy1vS7OFFCXyUfkjR6Y5/jClcq+KYayS
	0hObwpsGkO1tBZgOkG4uI+Vb57PNOGz5uezsDgv8x9MC2rTvyEAZUMm+TxO/dr0h
	kJiQ==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48q6xvq0wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 16:09:15 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 07E97130D5;
	Mon, 25 Aug 2025 16:09:13 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 10E16801616;
	Mon, 25 Aug 2025 16:09:10 +0000 (UTC)
Date: Mon, 25 Aug 2025 11:09:06 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>, akpm@linux-foundation.org,
        david@redhat.com, tony.luck@intel.com, bp@alien8.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        jane.chu@oracle.com, osalvador@suse.de
Subject: Re: [PATCH] mm/memory-failure: Do not call action_result() on
 already poisoned pages
Message-ID: <aKyKort2opfQYqgA@hpe.com>
References: <20250821164445.14467-1-kyle.meyer@hpe.com>
 <CACw3F53KmKRJyH+ajicyDUgGbPZT=U3VE4n+Jt3E62BxEiiCGA@mail.gmail.com>
 <aKd1K3ueTacGTf1W@hpe.com>
 <CACw3F527M-x=UeB0tN_sjCgp_YP_8yLkVRCLP2dLO2bzXrqWsA@mail.gmail.com>
 <14a0dd45-388d-7a32-5ee5-44e60277271a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14a0dd45-388d-7a32-5ee5-44e60277271a@huawei.com>
X-Proofpoint-GUID: eAojbwjnBFsxwDzG-eJQqJ_iiTYjmQP3
X-Authority-Analysis: v=2.4 cv=ArTu3P9P c=1 sm=1 tr=0 ts=68ac8aab cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=ERPcR_hKxm5yt4fehIQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0NSBTYWx0ZWRfX3Fhlj65ssQQh
 iBxTfpOt7lv+4AFi8G63U53mKaWeYuCR6wPS6FvOcefIDLVr6N6IWqxUH+wGfyIm1PIUsrBVcZD
 xqIlK2/HnzT/9/+QzwmaZX2UeC+gfWVsThm2oqmBQaxefjXFfKvAR97DhQmATQIAX/vEV2WZiIF
 RqYr7Mb8Bz6xh1Ih/+HSos4C+lb/V3zaCiNOUp4ZVnbV+svX60RFioRGpOHMOXp/v2Rslx0nTiz
 4Wp9M7oU0f0yaGLDMF/d9hcjqWI8vCWFTBQ+J+u9SVw6kDP4Ut2cFD9R4QnRBfnkUBcHyg9Wg7Y
 6s3brve84JhuX92h9sU5l/FES2uNn7KPFCqzzIGHB0qiBKLYxiFTRDPTkc1lR3nVrmGbpQbmdqO
 wQDgsmx0WHl/S4Owq8wLdwT4udB7hZSv28AaEyOA62CgztPuyFyIuPqdvbzV0MS8pA/gjsQo
X-Proofpoint-ORIG-GUID: eAojbwjnBFsxwDzG-eJQqJ_iiTYjmQP3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250145

On Mon, Aug 25, 2025 at 11:04:43AM +0800, Miaohe Lin wrote:
> On 2025/8/22 8:24, Jiaqi Yan wrote:
> > On Thu, Aug 21, 2025 at 12:36 PM Kyle Meyer <kyle.meyer@hpe.com> wrote:
> >>
> >> On Thu, Aug 21, 2025 at 11:23:48AM -0700, Jiaqi Yan wrote:
> >>> On Thu, Aug 21, 2025 at 9:46 AM Kyle Meyer <kyle.meyer@hpe.com> wrote:
> >>>>
> >>>> Calling action_result() on already poisoned pages causes issues:
> >>>>
> >>>> * The amount of hardware corrupted memory is incorrectly incremented.
> >>>> * NUMA node memory failure statistics are incorrectly updated.
> >>>> * Redundant "already poisoned" messages are printed.
> >>>
> >>> All agreed.
> >>>
> >>>>
> >>>> Do not call action_result() on already poisoned pages and drop unused
> >>>> MF_MSG_ALREADY_POISONED.
> >>>
> >>> Hi Kyle,
> >>>
> >>> Patch looks great to me, just one thought...
> 
> Thanks both.
> 
> >>>
> >>> Alternatively, have you thought about keeping MF_MSG_ALREADY_POISONED
> >>> but changing action_result for MF_MSG_ALREADY_POISONED?
> >>> - don't num_poisoned_pages_inc(pfn)
> >>> - don't update_per_node_mf_stats(pfn, result)
> >>> - still pr_err("%#lx: recovery action for %s: %s\n", ...)
> >>> - meanwhile remove "pr_err("%#lx: already hardware poisoned\n", pfn)"
> >>> in memory_failure and try_memory_failure_hugetlb
> >>
> >> I did consider that approach but I was concerned about passing
> >> MF_MSG_ALREADY_POISONED to action_result() with MF_FAILED. The message is a
> >> bit misleading.
> > 
> > Based on my reading the documentation for MF_* in static const char
> > *action_name[]...
> > 
> > Yeah, for file mapped pages, kernel may not have hole-punched or
> > truncated it from the file mapping (shmem and hugetlbfs for example)
> > but that still considered as MF_RECOVERED, so touching a page with
> > HWPoison flag doesn't mean that page was failed to be recovered
> > previously.
> > 
> > For pages intended to be taken out of the buddy system, touching a
> > page with HWPoison flag does imply it isn't isolated and hence
> > MF_FAILED.
> 
> There should be other cases that memory_failure failed to isolate the
> hwpoisoned pages at first time due to various reasons.
> 
> > 
> > In summary, seeing the HWPoison flag again doesn't necessarily
> > indicate what the recovery result was previously; it only indicate
> > kernel won't re-attempt to recover?
> 
> Yes, kernel won't re-attempt to or just cannot recover.
> 
> > 
> >>
> >> How about introducing a new MF action result? Maybe MF_NONE? The message could
> >> look something like:
> > 
> > Adding MF_NONE sounds fine to me, as long as we correctly document its
> > meaning, which can be subtle.
> 
> Adding a new MF action result sounds good to me. But IMHO MF_NONE might not be that suitable
> as kill_accessing_process might be called to kill proc in this case, so it's not "NONE".

OK, would you like a separate MF action result for each case? Maybe
MF_ALREADY_POISONED and MF_ALREADY_POISONED_KILLED?

MF_ALREADY_POISONED can be the default and MF_ALREADY_POISONED_KILLED can be
used when kill_accessing_process() returns -EHWPOISON.

The log messages could look like...

Memory failure: 0xXXXXXXXX: recovery action for already poisoned page: None
	and
Memory failure: 0xXXXXXXXX: recovery action for already poisoned page: Process killed

Thanks,
Kyle Meyer

