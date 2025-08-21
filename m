Return-Path: <linux-edac+bounces-4636-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF40B3030D
	for <lists+linux-edac@lfdr.de>; Thu, 21 Aug 2025 21:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D69B6070B0
	for <lists+linux-edac@lfdr.de>; Thu, 21 Aug 2025 19:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC252EAB62;
	Thu, 21 Aug 2025 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="pN+Cg84+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6D2C21E8;
	Thu, 21 Aug 2025 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805034; cv=none; b=djESNiWaW1UD4kv2rePGC4zTyyFgFiCwBkviVMJQx0q9npqdz9QwId3z77yDh7dCFAoMwKDiiAgYRpKOKBFF5QJ8F0Z7sdJu5OQeSBBRQ3tyBUllF4jkBAm64kLO8/VoQSHx6qQWuxVhCUb8nryPGuiHPn1YbInkSCqzmUMR1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805034; c=relaxed/simple;
	bh=KLLf9VyDfAK4FWoUs75vwIko48STkzdu8JSJfszwCuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+h++wBjTgf54RDGGOmLamW+B1osVpqYq53ZQ9095eqNj9RO/OWsziLZpuhNBVvPf3PzbYrz7Os3slmmfEiWTuzMTN3bXy3U3ua9J36SUdy0huCcpN1TEtTXAkFDpSTxl5VPMN059HJxIkd83VJu3tYqMOEYHq7RGCXp1BkaiQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=pN+Cg84+; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LIGo25019507;
	Thu, 21 Aug 2025 19:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=Wa
	8/iqYdFpX8MJDTCXt3R7g1KRe65oEz4/7rMZKRdyY=; b=pN+Cg84+5+u0N6DOIP
	GwTc5IaeL20gcPm4Ev/zqIkEXIDgWfypgqcHEpGHguLRySZ2ai05WIte7Cm++yqh
	vpIFFvYthn5gDIdOQ5SHR95CpedzAiun25h3cmskmsF6nBwdvZ033979gXTLSzkF
	LLXpCgRTnw7KDD6orr6ThDI+TqyELXCzwYb5dlOkXExlAZnJPdSAZf91U6EBPIz8
	wNuVIGFJr+ccz30mXqMPOvBkabXM+M2cEOhb1UO3ArSNHinbvI0hXBu3KbIdz/Ue
	/3Dwdot56ix6hKYb5qJorfQ7SA318hqNcVm5EIzLpjy3LWZ+WC6RaHUCr6tD+8Mw
	6ZDA==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48p10evsb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 19:36:17 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 3B86B805E18;
	Thu, 21 Aug 2025 19:36:16 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 67945805E5B;
	Thu, 21 Aug 2025 19:36:13 +0000 (UTC)
Date: Thu, 21 Aug 2025 14:36:11 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, tony.luck@intel.com,
        bp@alien8.de, linmiaohe@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        nao.horiguchi@gmail.com, jane.chu@oracle.com, osalvador@suse.de
Subject: Re: [PATCH] mm/memory-failure: Do not call action_result() on
 already poisoned pages
Message-ID: <aKd1K3ueTacGTf1W@hpe.com>
References: <20250821164445.14467-1-kyle.meyer@hpe.com>
 <CACw3F53KmKRJyH+ajicyDUgGbPZT=U3VE4n+Jt3E62BxEiiCGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F53KmKRJyH+ajicyDUgGbPZT=U3VE4n+Jt3E62BxEiiCGA@mail.gmail.com>
X-Proofpoint-GUID: ZsbMeJ8F2AyD1J_S0CWBl-FkjT0scDay
X-Proofpoint-ORIG-GUID: ZsbMeJ8F2AyD1J_S0CWBl-FkjT0scDay
X-Authority-Analysis: v=2.4 cv=X9oL6GTe c=1 sm=1 tr=0 ts=68a77531 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=yW6kyvSLy8IxsXRRQqMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDE2NSBTYWx0ZWRfXweS0z0IijUjv
 TR5xEPl57yRTGITviQj7VxIoB/dhthyPhn3Caj5YbwX+GC6OYnvX99pN+Moi+jnFIzqflNUfAx1
 nVVN0mYFsxaB7/FmjOe9Hyr9suVi+Yj7m+ihVNQtmcQKRBzuV3OnqTQrvxRAXD4nuJQqvJhat2S
 Dt6Wwq87akgo5EK9miGGi7t9ISMpoNqKz30QF14/qO7CHBIckrso9IVUly3vGzZVwnie5WFG/1C
 1TrUwSNZVHF1Ep7Hox1jV/J4B9pDqIh6cez5UOUKzn1B0Uv0uxFngbIGUzkzCn2DnPHQViY3CGb
 lmKRjiW1lq4gyiSCP6/YbV1cAc/Xoq69zgAifbVWB5pC/13+GLevXr77zpCKqHz8UF56PKl7N/P
 nhFW2WU1zPAaa05SsRivOpoC0k2xRJtnqaU4a4cztznNj/ZXP7k7Fgd0p+hbZfSocDjOo0HI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508210165

On Thu, Aug 21, 2025 at 11:23:48AM -0700, Jiaqi Yan wrote:
> On Thu, Aug 21, 2025 at 9:46 AM Kyle Meyer <kyle.meyer@hpe.com> wrote:
> >
> > Calling action_result() on already poisoned pages causes issues:
> >
> > * The amount of hardware corrupted memory is incorrectly incremented.
> > * NUMA node memory failure statistics are incorrectly updated.
> > * Redundant "already poisoned" messages are printed.
> 
> All agreed.
> 
> >
> > Do not call action_result() on already poisoned pages and drop unused
> > MF_MSG_ALREADY_POISONED.
> 
> Hi Kyle,
> 
> Patch looks great to me, just one thought...
> 
> Alternatively, have you thought about keeping MF_MSG_ALREADY_POISONED
> but changing action_result for MF_MSG_ALREADY_POISONED?
> - don't num_poisoned_pages_inc(pfn)
> - don't update_per_node_mf_stats(pfn, result)
> - still pr_err("%#lx: recovery action for %s: %s\n", ...)
> - meanwhile remove "pr_err("%#lx: already hardware poisoned\n", pfn)"
> in memory_failure and try_memory_failure_hugetlb

I did consider that approach but I was concerned about passing
MF_MSG_ALREADY_POISONED to action_result() with MF_FAILED. The message is a
bit misleading.

How about introducing a new MF action result? Maybe MF_NONE? The message could
look something like:

Memory failure: 0xXXXXXXXX: recovery action for already poisoned page: None

> This way, all the MF recovery result kernel logs out will be sitting
> in one place, action_result, instead of scattering around all over the
> place.

That sounds better to me.
 
> >
> > Fixes: b8b9488d50b7 ("mm/memory-failure: improve memory failure action_result messages")
> > Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> > ---
> >  include/linux/mm.h      | 1 -
> >  include/ras/ras_event.h | 1 -
> >  mm/memory-failure.c     | 3 ---
> >  3 files changed, 5 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 1ae97a0b8ec7..09ce81ef7afc 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4005,7 +4005,6 @@ enum mf_action_page_type {
> >         MF_MSG_BUDDY,
> >         MF_MSG_DAX,
> >         MF_MSG_UNSPLIT_THP,
> > -       MF_MSG_ALREADY_POISONED,
> >         MF_MSG_UNKNOWN,
> >  };
> >
> > diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> > index c8cd0f00c845..f62a52f5bd81 100644
> > --- a/include/ras/ras_event.h
> > +++ b/include/ras/ras_event.h
> > @@ -374,7 +374,6 @@ TRACE_EVENT(aer_event,
> >         EM ( MF_MSG_BUDDY, "free buddy page" )                          \
> >         EM ( MF_MSG_DAX, "dax page" )                                   \
> >         EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )                        \
> > -       EM ( MF_MSG_ALREADY_POISONED, "already poisoned" )              \
> >         EMe ( MF_MSG_UNKNOWN, "unknown page" )
> >
> >  /*
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index e2e685b971bb..7839ec83bc1d 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -948,7 +948,6 @@ static const char * const action_page_types[] = {
> >         [MF_MSG_BUDDY]                  = "free buddy page",
> >         [MF_MSG_DAX]                    = "dax page",
> >         [MF_MSG_UNSPLIT_THP]            = "unsplit thp",
> > -       [MF_MSG_ALREADY_POISONED]       = "already poisoned",
> >         [MF_MSG_UNKNOWN]                = "unknown page",
> >  };
> >
> > @@ -2090,7 +2089,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
> >                 if (flags & MF_ACTION_REQUIRED) {
> >                         folio = page_folio(p);
> >                         res = kill_accessing_process(current, folio_pfn(folio), flags);
> > -                       action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
> >                 }
> >                 return res;
> >         } else if (res == -EBUSY) {
> > @@ -2283,7 +2281,6 @@ int memory_failure(unsigned long pfn, int flags)
> >                         res = kill_accessing_process(current, pfn, flags);
> >                 if (flags & MF_COUNT_INCREASED)
> >                         put_page(p);
> > -               action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
> >                 goto unlock_mutex;
> >         }
> >
> > --
> > 2.50.1
> >
> >

