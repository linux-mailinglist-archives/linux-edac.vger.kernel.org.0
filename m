Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2E21C5C68
	for <lists+linux-edac@lfdr.de>; Tue,  5 May 2020 17:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgEEPsX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 May 2020 11:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbgEEPsX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 May 2020 11:48:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F1EC061A0F;
        Tue,  5 May 2020 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OusNCOqemtoO4geSkrjF3iyDZazZu9c7fA42HGUJsLA=; b=pexb9f2UBa1sTSKB+3uC1VGFed
        ccq0bPqD/XU4okEaJLLyeYAXzZf1T4lyxVGzb8NBxRvfKga8SVd1emR4PGIh2xelx+5K1leFfqvCg
        WyZAIUxkeJrdI5PbCOU0qpviOJsx7v8IHFP57w2gk78YAPtBeoOFm1UJj3NnWfZJLEuwMiCz3zQVp
        iS+t/ZSU+DX1cdPtLB2ZbqAnergroRMXA6//1AqzAH9qki0MuobmApf2rOMpc9Kz7j9euh7NncnUI
        PZy/KEbdOeW90aCrkwGl/nnt0fORL9AOpe8moBrixx80s1m36DOdaAGwuQeDqsDc7tUDosDBJiVsG
        mEgLoGEA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVzns-0000ON-QN; Tue, 05 May 2020 15:48:17 +0000
Date:   Tue, 5 May 2020 08:48:16 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: Fix some typo errors in ras.rst
Message-ID: <20200505154816.GH16070@bombadil.infradead.org>
References: <20200505151049.11134-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505151049.11134-1-longman@redhat.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 05, 2020 at 11:10:49AM -0400, Waiman Long wrote:
> Fix typo errors.

By reformatting it, you've successfully obscured what typos you've fixed.
As a result I read the whole paragraph, and ...

>  ECC memory
>  ----------
>  
> -As mentioned on the previous section, ECC memory has extra bits to be
> -used for error correction. So, on 64 bit systems, a memory module
> -has 64 bits of *data width*, and 74 bits of *total width*. So, there are
> -8 bits extra bits to be used for the error detection and correction
> +As mentioned on the previous section, ECC memory has extra bits to

s/on/in/

> +be used for error correction. So, on 64 bit systems, a memory module
> +has 64 bits of *data width*, and 72 bits of *total width*.

Usually a 64-bit system refers to the width of a pointer.  Here, it's
referring to the width of the memory system, which is rather confusing.
How about "In the above example" instead of "So, on 64 bit systems".

> So, there
> +are 8 extra bits to be used for the error detection and correction
>  mechanisms. Those extra bits are called *syndrome*\ [#f1]_\ [#f2]_.

This would read better as:

The extra 8 bits which are used for error detection and correction
are referred to as the *syndrome*\ [#f1]_\ [#f2]_.

