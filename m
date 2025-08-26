Return-Path: <linux-edac+bounces-4693-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89980B37451
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 23:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472793B6B60
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ED92F8BF1;
	Tue, 26 Aug 2025 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipFLOZSO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679062BE644
	for <linux-edac@vger.kernel.org>; Tue, 26 Aug 2025 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243345; cv=none; b=G31fWK+QFaVlcDYZjl2tqib0nWrzE8aF38pTd9pghcqELkgUIyckpFJbpJiFE6IrVd0iAB+WCW6lVkB2ryJFgHuny9PJvb9jk+wZ7FrPtdfzQ5i2BjN5oq5FsZpfLoGKg1NdWtG6oNAqMuot6nWqTcCSNeq8BCFmpvjgxz7IB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243345; c=relaxed/simple;
	bh=8TqIEkCMfHnA4X38BR6JYsdqovDRVxtY3X3F1s0tGK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olQctsDXxBsVk6Eb1q9VU1zl5IW257++HTABD9wp48dGDEWWS80NRbuQXgVOzBKUiGatFxCo1njKBGrwqNJbdnx6qtdfd2Z4mzNkQlR447is61JaJidlpyZCG6xv7UDDyyXGT1i8PSezqVu9oiVOp6UEx8Cd54lgcFRcSjW23WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipFLOZSO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459fc779bc3so7965e9.1
        for <linux-edac@vger.kernel.org>; Tue, 26 Aug 2025 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756243340; x=1756848140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jpPNZ8lISdv+Dhq7ZXaCZZODxLUSaWGXHiRUxlbj5w=;
        b=ipFLOZSOJYkxNnfVJOHV2eowjFJE42mALrm6YCkihUMfi0F3p+u2JlrM9cIZ66V/Rf
         cLI65eEYzrWIS7FAI6RVWPievHzqv4NA9TSkSYC6avzxuw28hw5uCI2j3so1iRx27x4K
         LR0qmXNRaw+HfqQcfkZc2Zknp0la9RCnTVtWaBavaj7zQStMjah5IMLgS8BI6cT7wfN6
         YXkzRPes+K3nxYMkiOyYbeGCPqbv4C1yT24OIBLaKj2FoeMcTzmqSurv1x6/HkITP35+
         tGXjH3pHZb/JPveY7/0vixpOR40z1TH6HggPcVrwDdWpUig88LTeY/y502V0da6q34YR
         CDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756243340; x=1756848140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jpPNZ8lISdv+Dhq7ZXaCZZODxLUSaWGXHiRUxlbj5w=;
        b=k151d4VThJKU4CJXP8uSzhOdGxBFuU8lf3+VpJKb+3p93aQr+fE1vi1daH2pjLFPsf
         Y7RRYtN5qwYeyRq5QxNQZp7MsISXQhEFHoMzhdxIiTjKWrAxNEqlRD58TYdy3JViYTtO
         xTnHzlK1PBfLPmvnfXOQcQpg71k7HFciMTDqQYL6ZM/YW/PkeBXzE0azb81z/iHoFaba
         YASBfeBDQVWDMpo7ugYYlP3bEqiV9RpUmnT+AOJloXnrCKaHxR2xPacKlCqL6YkGopE2
         mPjCN1AELATVglA+D0qg9y9C1RjT+xS3zLE/1fcQCwlofdeH42IybY8LnJSc2BuXDgpv
         z6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTKk7kW8OZVCYzORmAZiLIW3soFfyNRKhpdyoeCfvInwuXCCKrZ6ScpZU9tLtlPnuqCYYtxouxfaEO@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0L1uvcRC+u+P6bIR3rqBREyvjyKf7hG0Tb6qer0kvYnKqB/y
	dW4B//+w7KQjHGliXiF2xs/RkD/nsAUDqSaY6vJXkRdZ9I1guDzJBI2LYJivpA1ATDW2VfDMqg4
	LUKvTRyxNls5xO3B+iB5pJDTvR/ojtTIlKVBulh7U
X-Gm-Gg: ASbGnctgClAsNMVpE0ch+v0lQXAceAnN2pPpaQqZPnmgpa0EUaYFI7D4+OPwQsK1dmJ
	d5Kjv3RF5A6dm/hnRq6SseyLyphpDdunyuemKYbJTKm1d5jc1gl3kyYGuQwh58pBNHDHm1T7cns
	H3x3Z0NqiBURc8cJPsVfbh78l055c25V+W90H4JNbB7GNHpiekMLRfnoxiX//lBCrubpCFj8Iqm
	NNloEpyKuLnLvA8CRRuGAbOzLIpZqyaD47q7nKIfZHVokWtA5LJoC8=
X-Google-Smtp-Source: AGHT+IHWb/iGY2zxWEzy1j1Mu3+I3ku1JITkNvPq6UT+dcJ5yYMgM9SwHqFRIknb827acU4jRh04vE/b7tdVOttHKaM=
X-Received: by 2002:a05:600c:4a28:b0:45b:4acd:836d with SMTP id
 5b1f17b1804b1-45b6697dacdmr1183155e9.5.1756243339304; Tue, 26 Aug 2025
 14:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821164445.14467-1-kyle.meyer@hpe.com> <CACw3F53KmKRJyH+ajicyDUgGbPZT=U3VE4n+Jt3E62BxEiiCGA@mail.gmail.com>
 <aKd1K3ueTacGTf1W@hpe.com> <CACw3F527M-x=UeB0tN_sjCgp_YP_8yLkVRCLP2dLO2bzXrqWsA@mail.gmail.com>
 <14a0dd45-388d-7a32-5ee5-44e60277271a@huawei.com> <aKyKort2opfQYqgA@hpe.com>
 <2bd5c32b-dfc4-4345-8cc8-bbda5acdc596@oracle.com> <aK0UTovxnKfjPwXs@hpe.com>
 <714d066a-a06e-4b49-b66f-68952c6520d9@oracle.com> <aK4Ksy872gR7WuQF@hpe.com>
In-Reply-To: <aK4Ksy872gR7WuQF@hpe.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 26 Aug 2025 14:22:06 -0700
X-Gm-Features: Ac12FXyZq2QuV8uyQ0XiJC-UJJLJHPA1321axAxYENUGY5wCfC3LnKnzP71Qm40
Message-ID: <CACw3F53dULMH2UZLz8SR2GMuGTmjC-u9Mvomzi61oejeLEn3_Q@mail.gmail.com>
Subject: Re: [PATCH] mm/memory-failure: Do not call action_result() on already
 poisoned pages
To: Kyle Meyer <kyle.meyer@hpe.com>, jane.chu@oracle.com, 
	Miaohe Lin <linmiaohe@huawei.com>, russ.anderson@hpe.com
Cc: akpm@linux-foundation.org, david@redhat.com, tony.luck@intel.com, 
	bp@alien8.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, nao.horiguchi@gmail.com, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 12:28=E2=80=AFPM Kyle Meyer <kyle.meyer@hpe.com> wr=
ote:
>
> On Tue, Aug 26, 2025 at 10:24:07AM -0700, jane.chu@oracle.com wrote:
> >
> > On 8/25/2025 6:56 PM, Kyle Meyer wrote:
> > > On Mon, Aug 25, 2025 at 03:36:54PM -0700, jane.chu@oracle.com wrote:
> > > > On 8/25/2025 9:09 AM, Kyle Meyer wrote:
> > > > > On Mon, Aug 25, 2025 at 11:04:43AM +0800, Miaohe Lin wrote:
> > > > > > On 2025/8/22 8:24, Jiaqi Yan wrote:
> > > > > > > On Thu, Aug 21, 2025 at 12:36=E2=80=AFPM Kyle Meyer <kyle.mey=
er@hpe.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Aug 21, 2025 at 11:23:48AM -0700, Jiaqi Yan wrote:
> > > > > > > > > On Thu, Aug 21, 2025 at 9:46=E2=80=AFAM Kyle Meyer <kyle.=
meyer@hpe.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Calling action_result() on already poisoned pages cause=
s issues:
> > > > > > > > > >
> > > > > > > > > > * The amount of hardware corrupted memory is incorrectl=
y incremented.
> > > > > > > > > > * NUMA node memory failure statistics are incorrectly u=
pdated.
> > > > > > > > > > * Redundant "already poisoned" messages are printed.
> > > >
> > > > Assuming this means that the numbers reported from
> > > >    /sys/devices/system/node/node*/memory_failure/*
> > > > do not match certain expectation, right?
> > > >
> > > > If so, could you clarify what is the expectation?
> > >
> > > Sure, and please let me know if I'm mistaken.
> > >
> > > Here's the description of total:
> > >
> > > What:               /sys/devices/system/node/nodeX/memory_failure/tot=
al
> > > Date:               January 2023
> > > Contact:    Jiaqi Yan <jiaqiyan@google.com>
> > > Description:
> > >             The total number of raw poisoned pages (pages containing
> > >             corrupted data due to memory errors) on a NUMA node.
> > >
> > > That should emit the number of poisoned pages on NUMA node X. That's
> > > incremented each time update_per_node_mf_stats() is called.
> > >
> > > Here's the description of failed:
> > >
> > > What:               /sys/devices/system/node/nodeX/memory_failure/fai=
led
> > > Date:               January 2023
> > > Contact:    Jiaqi Yan <jiaqiyan@google.com>
> > > Description:
> > >             Of the raw poisoned pages on a NUMA node, how many pages =
are
> > >             failed by memory error recovery attempt. This usually mea=
ns
> > >             a key recovery operation failed.
> > >
> > > That should emit the number of poisoned pages on NUMA node X that cou=
ld
> > > not be recovered because the attempt failed. That's incremented each =
time
> > > update_per_node_mf_stats() is called with MF_FAILED.
> > >
> > > We're currently calling action_result() with MF_FAILED each time we e=
ncounter
> > > a poisoned page (note: the huge page path is a bit different, we only=
 call
> > > action_result() with MF_FAILED when MF_ACTION_REQUIRED is set). That,=
 IMO,
> > > breaks the descriptions. We already incremented the per NUMA node MF =
statistics
> > > to account for that poisoned page.
> >
> > Thanks!  My reading is that these numbers are best as hints, I won't ta=
ke
> > them literately.  As you alluded below, kill_accessing_process is appli=
ed
> > only if MF_ACTION_REQUIRED is set, though the page is already marked
> > poisoned.  Besides, there can be bug that renders a poisoned page not b=
eing
> > properly isolated nor being properly categorized.  If you're looking fo=
r
> > something precise, is there another way? maybe from firmware?
>
> Firmware records the number of memory errors that have been detected and
> reported, but it doesn't record how Linux responded to those memory error=
s.
>
> Checking the ring buffer, the amount of hardware corrupted memory, and th=
e
> per NUMA node memory failure statistics is a simple way to determine how =
Linux
> responded.
>
> Since commit b8b9488d50b7, that has become unreliable. The same memory er=
ror
> may be reported by multiple sources and now each report increments the am=
ount of

To me this multiple counting is an existing issue, and what Kyle
originally targeted. It seems to me that as long as the
mf_action_page_type is MF_MSG_ALREADY_POISONED (or HWPoison flag is
set), action_result shouldn't invoke statistic related ops, and
mf_results just become irrelevant (wrt
/sys/devices/system/node/nodeX/memory_failure/*), right? IWO, we can
decouple the two issues:
1. how to update statistics correctly?
2. what log msg to show for recovery result, MF_FAILED or something else/ne=
w?

While Kyle fixing issue #1, can we just keep MF_FAILED as is?

> hardware corrupted memory and the per NUMA node memory failure statistics=
. Isn't
> that a regression?
>
> The per NUMA node memory failure statistics might not always be 100% accu=
rate,
> but this issue seems preventable.
>
> > > > > > > > >
> > > > > > > > > All agreed.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Do not call action_result() on already poisoned pages a=
nd drop unused
> > > > > > > > > > MF_MSG_ALREADY_POISONED.
> > > > > > > > >
> > > > > > > > > Hi Kyle,
> > > > > > > > >
> > > > > > > > > Patch looks great to me, just one thought...
> > > > > >
> > > > > > Thanks both.
> > > > > >
> > > > > > > > >
> > > > > > > > > Alternatively, have you thought about keeping MF_MSG_ALRE=
ADY_POISONED
> > > > > > > > > but changing action_result for MF_MSG_ALREADY_POISONED?
> > > > > > > > > - don't num_poisoned_pages_inc(pfn)
> > > > > > > > > - don't update_per_node_mf_stats(pfn, result)
> > > > > > > > > - still pr_err("%#lx: recovery action for %s: %s\n", ...)
> > > > > > > > > - meanwhile remove "pr_err("%#lx: already hardware poison=
ed\n", pfn)"
> > > > > > > > > in memory_failure and try_memory_failure_hugetlb
> > > > > > > >
> > > > > > > > I did consider that approach but I was concerned about pass=
ing
> > > > > > > > MF_MSG_ALREADY_POISONED to action_result() with MF_FAILED. =
The message is a
> > > > > > > > bit misleading.
> > > > > > >
> > > > > > > Based on my reading the documentation for MF_* in static cons=
t char
> > > > > > > *action_name[]...
> > > > > > >
> > > > > > > Yeah, for file mapped pages, kernel may not have hole-punched=
 or
> > > > > > > truncated it from the file mapping (shmem and hugetlbfs for e=
xample)
> > > > > > > but that still considered as MF_RECOVERED, so touching a page=
 with
> > > > > > > HWPoison flag doesn't mean that page was failed to be recover=
ed
> > > > > > > previously.
> > > > > > >
> > > > > > > For pages intended to be taken out of the buddy system, touch=
ing a
> > > > > > > page with HWPoison flag does imply it isn't isolated and henc=
e
> > > > > > > MF_FAILED.
> > > > > >
> > > > > > There should be other cases that memory_failure failed to isola=
te the
> > > > > > hwpoisoned pages at first time due to various reasons.
> > > > > >
> > > > > > >
> > > > > > > In summary, seeing the HWPoison flag again doesn't necessaril=
y
> > > > > > > indicate what the recovery result was previously; it only ind=
icate
> > > > > > > kernel won't re-attempt to recover?
> > > > > >
> > > > > > Yes, kernel won't re-attempt to or just cannot recover.
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > How about introducing a new MF action result? Maybe MF_NONE=
? The message could
> > > > > > > > look something like:
> > > > > > >
> > > > > > > Adding MF_NONE sounds fine to me, as long as we correctly doc=
ument its
> > > > > > > meaning, which can be subtle.
> > > > > >
> > > > > > Adding a new MF action result sounds good to me. But IMHO MF_NO=
NE might not be that suitable
> > > > > > as kill_accessing_process might be called to kill proc in this =
case, so it's not "NONE".
> > > > >
> > > > > OK, would you like a separate MF action result for each case? May=
be
> > > > > MF_ALREADY_POISONED and MF_ALREADY_POISONED_KILLED?
> > > > >
> > > > > MF_ALREADY_POISONED can be the default and MF_ALREADY_POISONED_KI=
LLED can be
> > > > > used when kill_accessing_process() returns -EHWPOISON.
> > > > >
> > > > > The log messages could look like...
> > > > >
> > > > > Memory failure: 0xXXXXXXXX: recovery action for already poisoned =
page: None
> > > > >         and
> > > > > Memory failure: 0xXXXXXXXX: recovery action for already poisoned =
page: Process killed
> > > >
> > > > Agreed with Miaohe that "None" won't work.
> > >
> > > What action is M-F() taking to recover already poisoned pages that do=
n't have
> > > MF_ACTION_REQUIRED set?
> >
> > The action taken toward poisoned page not under MF_ACTION_REQUIRED is
> > typically isolation, that is, remove the pte or mark the pte as poisone=
d
> > special swap entry, so that subsequent page fault is given a chance to
> > deliver a SIGBUS. That said, things might fail during the process, like
> > encountering GUP pinned THP page.>
> > > > "Process killed" sounds okay for MF_MSG_ALREADY_POISONED, but
> > > > we need to understand why "Failed" doesn't work for your usecase.
> > > > "Failed" means process is killed but page is not successfully isola=
ted which
> > > > applies to MF_MSG_ALREADY_POISONED case as well.
> > >
> > > So that accessing process is killed. Why call action_result() with MF=
_FAILED?
> > > Doesn't that indicate we poisoned another page and the recovery attem=
pt failed?
> >
> > What I recall is that, "recovery" is reserved for page that is clean,
> > isolated, and even by chance, unmapped.  "failed" is reserved for page =
that
> > has been(or might not?) removed from the page table, page might be dirt=
y,
> > certainly mapped, etc. A SIGBUS doesn't make recovery an automatic succ=
ess.
> >
> > Others please correct me if I'm mistaken.
>
> Thank you very much for taking the time to explain everything.
>
> Thanks,
> Kyle Meyer

