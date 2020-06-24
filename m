Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074672072F0
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jun 2020 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403835AbgFXMKf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 Jun 2020 08:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403782AbgFXMKe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 24 Jun 2020 08:10:34 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D549EC061573
        for <linux-edac@vger.kernel.org>; Wed, 24 Jun 2020 05:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BTvxV1cC2GZuxzSIAIRaohPI9eSS76hbv1NBGOdD3Fo=; b=IVTa1jbe6CtoLrHamjBhhfE/Ri
        YD8EtB+YUyaVbNogLBT+YQjQjqjayuVnKuEZA/4lwm+r4XmGtKGOaK96num3NYMMeZPBLAoL2e/or
        Xqwiq4MxW0TeUOxUAUOrEsDYwhDat2jdTjaBBSTJf3ZvK6I5LBIJU7F853Biip6ARkZWi7UrmEwAF
        eQ15GMnf2TbBXk1PRfW149sDFNIveQfQUhUEp7FZXUzUIpisCrx2lctyC4lpctHpdrQd3UFtQlN0w
        DBr84ubvRhiH3nXPlEtFL2hoVeCkK8+4pWoCvFqtN3PMXDGklf+iLe4OEMgt1epnyYKrAWVNWwk0W
        H+g/uFDw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo4E4-0002ei-74; Wed, 24 Jun 2020 12:10:00 +0000
Date:   Wed, 24 Jun 2020 13:10:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, Jane Chu <jane.chu@oracle.com>
Subject: Re: [RFC] Make the memory failure blast radius more precise
Message-ID: <20200624121000.GM21350@casper.infradead.org>
References: <20200623201745.GG21350@casper.infradead.org>
 <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <20200623221741.GH21350@casper.infradead.org>
 <20200623222658.GA21817@agluck-desk2.amr.corp.intel.com>
 <20200623224027.GI21350@casper.infradead.org>
 <20200624000124.GH7625@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624000124.GH7625@magnolia>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 23, 2020 at 05:01:24PM -0700, Darrick J. Wong wrote:
> On Tue, Jun 23, 2020 at 11:40:27PM +0100, Matthew Wilcox wrote:
> > On Tue, Jun 23, 2020 at 03:26:58PM -0700, Luck, Tony wrote:
> > > On Tue, Jun 23, 2020 at 11:17:41PM +0100, Matthew Wilcox wrote:
> > > > It might also be nice to have an madvise() MADV_ZERO option so the
> > > > application doesn't have to look up the fd associated with that memory
> > > > range, but we haven't floated that idea with the customer yet; I just
> > > > thought of it now.
> > > 
> > > So the conversation between OS and kernel goes like this?
> > > 
> > > 1) machine check
> > > 2) Kernel unmaps the 4K page surroundinng the poison and sends
> > >    SIGBUS to the application to say that one cache line is gone
> > > 3) App says madvise(MADV_ZERO, that cache line)
> > > 4) Kernel says ... "oh, you know how to deal with this" and allocates
> > >    a new page, copying the 63 good cache lines from the old page and
> > >    zeroing the missing one. New page is mapped to user.
> > 
> > That could be one way of implementing it.  My understanding is that
> > pmem devices will reallocate bad cachelines on writes, so a better
> > implementation would be:
> > 
> > 1) Kernel receives machine check
> > 2) Kernel sends SIGBUS to the application
> > 3) App send madvise(MADV_ZERO, addr, 1 << granularity)
> > 4) Kernel does special writes to ensure the cacheline is zeroed
> > 5) App does whatever it needs to recover (reconstructs the data or marks
> > it as gone)
> 
> Frankly, I've wondered why the filesystem shouldn't just be in charge of
> all this--
> 
> 1. kernel receives machine check
> 2. kernel tattles to xfs
> 3. xfs looks up which file(s) own the pmem range
> 4. xfs zeroes the region, clears the poison, and sets AS_EIO on the
>    files

... machine reboots, app restarts, gets no notification anything is wrong,
treats zeroed region as good data, launches nuclear missiles.

> 5. xfs sends SIGBUS to any programs that had those files mapped to tell
>    them "Your data is gone, we've stabilized the storage you had
>    mapped."
> 6. app does whatever it needs to recover
> 
> Apps shouldn't have to do this punch-and-reallocate dance, seeing as
> they don't currently do that for SCSI disks and the like.

The SCSI disk retains the error until the sector is rewritten.
I'm not entirely sure whether you're trying to draw an analogy with
error-in-page-cache or error-on-storage-medium.

error-on-medium needs to persist until the app takes an affirmative step
to clear it.  I presume XFS does not write zeroes to sectors with
errors on SCSI disks ...
