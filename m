Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6687F209795
	for <lists+linux-edac@lfdr.de>; Thu, 25 Jun 2020 02:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbgFYASP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 Jun 2020 20:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387843AbgFYASO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 24 Jun 2020 20:18:14 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62A3C061573
        for <linux-edac@vger.kernel.org>; Wed, 24 Jun 2020 17:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pVQO+jthJIZM4PcEiCcZiEtK/0K2n4k/Za7XwNKPOyo=; b=oEfvC+ynaZZzuAJf14RWJXxiLY
        N3S1798NJ+RS2avn1Ilqet5vdnAu4LV1ozmFxBqJEoSMLw3QHzcshxP6P5b4VMhZhz1Pp31j9b5uK
        L7Q1swSFSbdjz6RI4iDPgTi/duiWxpEEpfdFaLB/qvQJrwgHZjfYLoH5ScqApRuQKl8ZHEjAZDhM5
        lSpzh9BdQZah7JyDbkMjZ5+3ULDVl3l4VgQv381j1UXkJYp6U3HbmqkLfoFEkrWnGOb/lq950Yi4B
        DmG5aP5QVi2yC8CdP4hBxlqiWMydQkI3t/ITBpL0W1stbdTG/QoIupvUi9uPyHtyYU8yccWVSALP5
        pRL//60g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joFaG-0004W3-EX; Thu, 25 Jun 2020 00:17:40 +0000
Date:   Thu, 25 Jun 2020 01:17:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-edac@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [RFC] Make the memory failure blast radius more precise
Message-ID: <20200625001740.GX21350@casper.infradead.org>
References: <20200623201745.GG21350@casper.infradead.org>
 <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <20200623221741.GH21350@casper.infradead.org>
 <20200623222658.GA21817@agluck-desk2.amr.corp.intel.com>
 <20200623224027.GI21350@casper.infradead.org>
 <20200624000124.GH7625@magnolia>
 <20200624121000.GM21350@casper.infradead.org>
 <CAPcyv4joCu00OXV9da3eoQVqM_FTwELQa6=YdwXjZCtyxy13bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4joCu00OXV9da3eoQVqM_FTwELQa6=YdwXjZCtyxy13bg@mail.gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 24, 2020 at 04:21:24PM -0700, Dan Williams wrote:
> On Wed, Jun 24, 2020 at 5:10 AM Matthew Wilcox <willy@infradead.org> wrote:
> > On Tue, Jun 23, 2020 at 05:01:24PM -0700, Darrick J. Wong wrote:
> > > Frankly, I've wondered why the filesystem shouldn't just be in charge of
> > > all this--
> > >
> > > 1. kernel receives machine check
> > > 2. kernel tattles to xfs
> > > 3. xfs looks up which file(s) own the pmem range
> > > 4. xfs zeroes the region, clears the poison, and sets AS_EIO on the
> > >    files
> >
> > ... machine reboots, app restarts, gets no notification anything is wrong,
> > treats zeroed region as good data, launches nuclear missiles.
> 
> Isn't AS_EIO stored persistently in the file block allocation map?

No.  AS_EIO is in mapping->flags.  Unless Darrick was using "sets AS_EIO"
as shorthand for something else.

> Even if it isn't today that is included in the proposal that the
> filesystem maintains a list of poison that is coordinated with the
> pmem driver.

I'd like to see a concrete proposal here.

> > > Apps shouldn't have to do this punch-and-reallocate dance, seeing as
> > > they don't currently do that for SCSI disks and the like.
> >
> > The SCSI disk retains the error until the sector is rewritten.
> > I'm not entirely sure whether you're trying to draw an analogy with
> > error-in-page-cache or error-on-storage-medium.
> >
> > error-on-medium needs to persist until the app takes an affirmative step
> > to clear it.  I presume XFS does not write zeroes to sectors with
> > errors on SCSI disks ...
> 
> SCSI does not have an async mechanism to retrieve a list of poisoned
> blocks from the hardware (that I know of), pmem does. I really think
> we should not glom on pmem error handling semantics on top of the same
> infrastructure that it has handling volatile / replaceable pages. When

Erm ... commit 6100e34b2526 has your name on it.

> the filesystem is enabled to get involved it should impose a different
> model than generic memory error handling especially because generic
> memory-error handling has no chance to solve the reflink problem.
> 
> If an application wants to survive poison consumption, signals seem
> only sufficient for interrupting an application that needs to take
> immediate action because one of its instructions was prevented from
> making forward progress. The interface for enumerating the extent of
> errors for DAX goes beyond what signinfo can reasonably convey, that
> piece is where the filesystem can be called to discover which file
> extents are impacted by poison.
> 
> I like Darrick's idea that the kernel stabilizes the storage by
> default, and that the repair mechanism is just a write(2). I assume
> "stabilize" means make sure that the file offset is permanently
> recorded as poisoned until the next write(2), but read(2) and mmap(2)
> return errors so no more machine checks are triggered.

That seems like something we'd want to work into the iomap infrastructure,
perhaps.  Add an IOMAP_POISONED to indicate this range needs to be
written before it can be read?

