Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90B3206781
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jun 2020 00:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbgFWWr4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Jun 2020 18:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388221AbgFWWrW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Jun 2020 18:47:22 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BA2C0611E9
        for <linux-edac@vger.kernel.org>; Tue, 23 Jun 2020 15:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=inf6ESzzuqFyz/AxMuegiW33kVntEASRl+Rj/szf9mM=; b=KZfiNnU89q2RuwBIHdmTN3d7Vu
        3Odlb+G0HmmRGQr/HlFfPmKh7bmntcZ8rxXL28eD9QfUiiXj2zxzdKhk4nn/ORxDzA8TSIZtX2wn8
        CTmbxadffG1MeJEbmsAUd99ROjuIh0IzSiuICh+TNaX7kPqBgUIojIDJQdSVM3QJugSWoyagWHSCW
        YY6jS8tiZltLBsjSf6ZxkwejKZkuz7+0oc4v2gQAh87fySkxJZ7yuWz7gVARXo/lK9QH9oZx0tZXY
        1+iyla0naGvnDN8971quQ0klpacW64Mb30+y4OQ8bb8NOrrdPU/uAWdIdsi2X3HiUw+FTzHerjz3B
        9b03vJ9g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnrad-00013W-Gl; Tue, 23 Jun 2020 22:40:27 +0000
Date:   Tue, 23 Jun 2020 23:40:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [RFC] Make the memory failure blast radius more precise
Message-ID: <20200623224027.GI21350@casper.infradead.org>
References: <20200623201745.GG21350@casper.infradead.org>
 <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <20200623221741.GH21350@casper.infradead.org>
 <20200623222658.GA21817@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623222658.GA21817@agluck-desk2.amr.corp.intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 23, 2020 at 03:26:58PM -0700, Luck, Tony wrote:
> On Tue, Jun 23, 2020 at 11:17:41PM +0100, Matthew Wilcox wrote:
> > It might also be nice to have an madvise() MADV_ZERO option so the
> > application doesn't have to look up the fd associated with that memory
> > range, but we haven't floated that idea with the customer yet; I just
> > thought of it now.
> 
> So the conversation between OS and kernel goes like this?
> 
> 1) machine check
> 2) Kernel unmaps the 4K page surroundinng the poison and sends
>    SIGBUS to the application to say that one cache line is gone
> 3) App says madvise(MADV_ZERO, that cache line)
> 4) Kernel says ... "oh, you know how to deal with this" and allocates
>    a new page, copying the 63 good cache lines from the old page and
>    zeroing the missing one. New page is mapped to user.

That could be one way of implementing it.  My understanding is that
pmem devices will reallocate bad cachelines on writes, so a better
implementation would be:

1) Kernel receives machine check
2) Kernel sends SIGBUS to the application
3) App send madvise(MADV_ZERO, addr, 1 << granularity)
4) Kernel does special writes to ensure the cacheline is zeroed
5) App does whatever it needs to recover (reconstructs the data or marks
it as gone)

> Do you have folks lined up to use that?  I don't know that many
> folks are even catching the SIGBUS :-(

Had a 75 minute meeting with some people who want to use pmem this
afternoon ...
