Return-Path: <linux-edac+bounces-1238-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0538FFA42
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 05:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EA2B21411
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 03:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6B2171A4;
	Fri,  7 Jun 2024 03:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ebrkhen0"
X-Original-To: linux-edac@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F611184;
	Fri,  7 Jun 2024 03:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717732074; cv=none; b=HN/WKCje4+ydYLqlWWoCqfbvp0ZnvGjtCNndV/9UdvR0kMSLhwFaHM4z8c9PxyV45m26XZcvd1OaD3iCnasFl3msUeG2ig44coUG+LXMM6teQEgG6ORb8CYyt5IZZgeTTXFZTPKQQqEqOtEBjp7q/iwIRR0Heou/QMN1Hn+mk6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717732074; c=relaxed/simple;
	bh=pPOz7QOlPRfWTnKRgHB440bhcTmrNjJhcuqoVeaZP+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSXfn2GLKH0Nc+RfYaScuoetnhNEI07r7ziNTsjbCuvK4O4fnndB2v+RlGnlchQ5UCL8q4IIrb0C0QHTrSVkjEGKPXcYo1LvIHZKGzAiHyERsnqd75o0+VNTNll1ge1/6LAHKI8jTOvsyk94ceLWNAmD21NzjSrmUQmMi6KqoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ebrkhen0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k2zmVJyT6QQfw74c0ZmAvYZBQxk8PeGEZhsNEJ+y4EA=; b=Ebrkhen0IK/KZMcd/x837fNBoQ
	2ApAdNbH+867Zun3v6YnswS24eGcp3TnfUeEiCIGaoZL9nVuw6+PlmHqKodgTBIJsKvCKR1r6/kB5
	kfH8pFQVT47YxQkX/IBIZlyTntzuttmTpmM/PhZPQrYyEOYKqcS8C9wDvS0Al0FwT8OTyWEtR3HjU
	Y9DWwi7aM9hrGDfgl+de7wm6tl9bdcDYtp65lQvaJQdfO5fVkO4s5g0lRTZFEez9eCh+H5uft+2vf
	WKPEsXZnXKxyVzXHtoAOfHc9IjOjjN7ZZBmZ19Gji+dqxkCBkDGKGQm6ZQlgxxggb+J4odddWgjp/
	vbtrVo5g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFQZd-00000004SlU-3wWX;
	Fri, 07 Jun 2024 03:47:29 +0000
Date: Fri, 7 Jun 2024 04:47:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, tony.luck@intel.com, bp@alien8.de,
	nao.horiguchi@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 10/13] mm/memory-failure: move some function
 declarations into internal.h
Message-ID: <ZmKC0Z3omr04grkj@casper.infradead.org>
References: <20240606063247.712575-1-linmiaohe@huawei.com>
 <20240606063247.712575-11-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606063247.712575-11-linmiaohe@huawei.com>

On Thu, Jun 06, 2024 at 02:32:44PM +0800, Miaohe Lin wrote:
> +++ b/mm/internal.h
> @@ -1077,6 +1077,16 @@ extern u64 hwpoison_filter_flags_mask;
>  extern u64 hwpoison_filter_flags_value;
>  extern u64 hwpoison_filter_memcg;
>  extern u32 hwpoison_filter_enable;
> +#define MAGIC_HWPOISON	0x48575053U	/* HWPS */
> +extern void SetPageHWPoisonTakenOff(struct page *page);
> +extern void ClearPageHWPoisonTakenOff(struct page *page);
> +extern bool take_page_off_buddy(struct page *page);
> +extern bool put_page_back_buddy(struct page *page);

s/extern// for function declarations.


