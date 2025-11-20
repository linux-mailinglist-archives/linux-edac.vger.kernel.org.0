Return-Path: <linux-edac+bounces-5490-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA1DC752A0
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 16:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CADD82B286
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D5233B6EB;
	Thu, 20 Nov 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="j20qsWKK"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC832BF4B;
	Thu, 20 Nov 2025 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654182; cv=none; b=ufkAdiaeYz0jGDjyOjHFKw1RZJpsrCIKMpkPGRt9j7CXKVahD+5JnWzOLfEKvRfJ0Sggw6IwuJmC2+UQblX7qzP98InCYDnB7C5ljufuQF3pFvVhx52uPsTiDH+EMFrgHoMRAPm3Qv946fd7/UeGDvN5e0EipSU5pcmqelzpV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654182; c=relaxed/simple;
	bh=yHAxO/XmBrSDVoEYRjxBwgefm+ZWzlUd1ZfmhZ8KS9s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fj0P9M06F/w/2EHEys9/BZQlAWbY/ALjFP0oLTDC+wUVhFmS1qsUs7ijMxAi0WjhOzJtBOKNw3otbPhDZlIu3aiw3SKPB+ikV88FHJ8eHuxAdMusDG9KD8GPZ5PyNJ150oX/QdfqnQO4ZrdrUVWbPOjsLp/9KTXqik/S2C3jkKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=j20qsWKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AC8C4CEF1;
	Thu, 20 Nov 2025 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763654182;
	bh=yHAxO/XmBrSDVoEYRjxBwgefm+ZWzlUd1ZfmhZ8KS9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j20qsWKKVoWshSWyVABqDXVsx/ZWnoKoVukrgKGCajhXpm8P4/KLPZft+T5SUOWZx
	 af+bUltUMRSF6vb5wVJkOB8UtgA47gBv4XdtTeLeHyn47BqvgwUiL81J8FabTpTgNd
	 QI+geOhbFz7WNe6c40GtLGAfblC6ZZNkhWFgBdNM=
Date: Thu, 20 Nov 2025 07:56:21 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, tony.luck@intel.com, bp@alien8.de,
 linmiaohe@huawei.com, nao.horiguchi@gmail.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, will@kernel.org,
 liaohua4@huawei.com, lilinjie8@huawei.com
Subject: Re: [PATCH v3] mm/memory-failure: remove the selection of RAS
Message-Id: <20251120075621.b193e9ad997a2bfc0e588201@linux-foundation.org>
In-Reply-To: <fc7bae22-0705-475a-be89-8bb3ca12384d@kernel.org>
References: <20251119095943.67125-1-xieyuanbin1@huawei.com>
	<fc7bae22-0705-475a-be89-8bb3ca12384d@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 14:59:54 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:

> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11631,10 +11631,11 @@ R:	Naoya Horiguchi <nao.horiguchi@gmail.com>
> >   L:	linux-mm@kvack.org
> >   S:	Maintained
> >   F:	include/linux/memory-failure.h
> >   F:	mm/hwpoison-inject.c
> >   F:	mm/memory-failure.c
> > +F:	include/trace/events/memory-failure.
> 
> These are ordered alphabetically, so it should be further up next to the 
> other include.

I fixed that up, thanks.

