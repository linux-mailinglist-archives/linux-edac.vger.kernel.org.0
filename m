Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E3A209718
	for <lists+linux-edac@lfdr.de>; Thu, 25 Jun 2020 01:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbgFXXVk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 Jun 2020 19:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388257AbgFXXVh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 24 Jun 2020 19:21:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4021CC061573
        for <linux-edac@vger.kernel.org>; Wed, 24 Jun 2020 16:21:37 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ga4so4080528ejb.11
        for <linux-edac@vger.kernel.org>; Wed, 24 Jun 2020 16:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4WmOEtLzMdFuXw4rYIj/E7NU8dacf1RcNP8WlgBHeM=;
        b=Zf0RjYCME3yc1o039zXRU1fdt9IyFIhlxTlvTPEsrQAsXk8308tTPi6yefar3Vp177
         KK5yo7ToPxuY+WBjMFXeArTWyeFjoiS2ZYrPeEglfXMj3gHKeCDnZ2N+t5jYrcGI8u9r
         UHqPOOCYHAp5WZxHgY9DRpabx8FDz66HDp9yTb9NiFkbgkjuc0LrElRmGsBOKvhxVamg
         +0jBLoXL7xruIAGswA6/08nqMsipY1W0zLnQGSVct5s4Dt4NNwqYSiqwCf1wRGUpgC66
         czUnjsBCU3O89hiCtG061qadlSDVYCbynoBbGSX2sQZYw1Xn8yPVgLDEc9Iy8vDmzM/E
         mSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4WmOEtLzMdFuXw4rYIj/E7NU8dacf1RcNP8WlgBHeM=;
        b=ZczHF7OiNTD0dtY+ipG+1KrVEB6hd/drF78w+GTD+tc/cDgWISKXAlO2zMOB1qC7tl
         msVT5I7YB4d0TU6o6tRX1h7DF3BqmZzgqDkVi7AxKSnxONXPnaXsnzwbD4LuUQ5lz5lQ
         ++nvheb1dKS7FB2msiPVyGQugdy6pjxenOa7aPND7x3nSGKQbyYx65hL37CZ/75ubOP6
         wFMwsY2cz9vQIVPk5V9WnLd098prAWpmFaMGP0OPgwVcvI12qwvQRPa0SYFkMsxJPVO9
         hJwvAzQhnToPKlOEqjabr+5I2jg5X0oACf3DklN3OnBrmm28WiEfnGW7KaZPKwhaPqwa
         mrrw==
X-Gm-Message-State: AOAM533idulSRLTdOdBUnvYYNKFzosq61J4AK2ShhMuJLOk+nVa83ayB
        NXN6pOvnluqAxxgwj8LORv61Qzp15w1Jl7MIS/uBuxzz
X-Google-Smtp-Source: ABdhPJx7YRxVbC24Pjqb6OgwXTPTIjnJ1TegmuuA5gsPccgVzsZlRcaQ3AyYyB/TMf6WDhGlYOs1/bu+XTzhS8BKq3g=
X-Received: by 2002:a17:906:6d56:: with SMTP id a22mr21897232ejt.440.1593040895907;
 Wed, 24 Jun 2020 16:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200623201745.GG21350@casper.infradead.org> <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <20200623221741.GH21350@casper.infradead.org> <20200623222658.GA21817@agluck-desk2.amr.corp.intel.com>
 <20200623224027.GI21350@casper.infradead.org> <20200624000124.GH7625@magnolia>
 <20200624121000.GM21350@casper.infradead.org>
In-Reply-To: <20200624121000.GM21350@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Jun 2020 16:21:24 -0700
Message-ID: <CAPcyv4joCu00OXV9da3eoQVqM_FTwELQa6=YdwXjZCtyxy13bg@mail.gmail.com>
Subject: Re: [RFC] Make the memory failure blast radius more precise
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-edac@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 24, 2020 at 5:10 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jun 23, 2020 at 05:01:24PM -0700, Darrick J. Wong wrote:
> > On Tue, Jun 23, 2020 at 11:40:27PM +0100, Matthew Wilcox wrote:
> > > On Tue, Jun 23, 2020 at 03:26:58PM -0700, Luck, Tony wrote:
> > > > On Tue, Jun 23, 2020 at 11:17:41PM +0100, Matthew Wilcox wrote:
> > > > > It might also be nice to have an madvise() MADV_ZERO option so the
> > > > > application doesn't have to look up the fd associated with that memory
> > > > > range, but we haven't floated that idea with the customer yet; I just
> > > > > thought of it now.
> > > >
> > > > So the conversation between OS and kernel goes like this?
> > > >
> > > > 1) machine check
> > > > 2) Kernel unmaps the 4K page surroundinng the poison and sends
> > > >    SIGBUS to the application to say that one cache line is gone
> > > > 3) App says madvise(MADV_ZERO, that cache line)
> > > > 4) Kernel says ... "oh, you know how to deal with this" and allocates
> > > >    a new page, copying the 63 good cache lines from the old page and
> > > >    zeroing the missing one. New page is mapped to user.
> > >
> > > That could be one way of implementing it.  My understanding is that
> > > pmem devices will reallocate bad cachelines on writes, so a better
> > > implementation would be:
> > >
> > > 1) Kernel receives machine check
> > > 2) Kernel sends SIGBUS to the application
> > > 3) App send madvise(MADV_ZERO, addr, 1 << granularity)
> > > 4) Kernel does special writes to ensure the cacheline is zeroed
> > > 5) App does whatever it needs to recover (reconstructs the data or marks
> > > it as gone)
> >
> > Frankly, I've wondered why the filesystem shouldn't just be in charge of
> > all this--
> >
> > 1. kernel receives machine check
> > 2. kernel tattles to xfs
> > 3. xfs looks up which file(s) own the pmem range
> > 4. xfs zeroes the region, clears the poison, and sets AS_EIO on the
> >    files
>
> ... machine reboots, app restarts, gets no notification anything is wrong,
> treats zeroed region as good data, launches nuclear missiles.

Isn't AS_EIO stored persistently in the file block allocation map?
Even if it isn't today that is included in the proposal that the
filesystem maintains a list of poison that is coordinated with the
pmem driver.

>
> > 5. xfs sends SIGBUS to any programs that had those files mapped to tell
> >    them "Your data is gone, we've stabilized the storage you had
> >    mapped."
> > 6. app does whatever it needs to recover
> >
> > Apps shouldn't have to do this punch-and-reallocate dance, seeing as
> > they don't currently do that for SCSI disks and the like.
>
> The SCSI disk retains the error until the sector is rewritten.
> I'm not entirely sure whether you're trying to draw an analogy with
> error-in-page-cache or error-on-storage-medium.
>
> error-on-medium needs to persist until the app takes an affirmative step
> to clear it.  I presume XFS does not write zeroes to sectors with
> errors on SCSI disks ...

SCSI does not have an async mechanism to retrieve a list of poisoned
blocks from the hardware (that I know of), pmem does. I really think
we should not glom on pmem error handling semantics on top of the same
infrastructure that it has handling volatile / replaceable pages. When
the filesystem is enabled to get involved it should impose a different
model than generic memory error handling especially because generic
memory-error handling has no chance to solve the reflink problem.

If an application wants to survive poison consumption, signals seem
only sufficient for interrupting an application that needs to take
immediate action because one of its instructions was prevented from
making forward progress. The interface for enumerating the extent of
errors for DAX goes beyond what signinfo can reasonably convey, that
piece is where the filesystem can be called to discover which file
extents are impacted by poison.

I like Darrick's idea that the kernel stabilizes the storage by
default, and that the repair mechanism is just a write(2). I assume
"stabilize" means make sure that the file offset is permanently
recorded as poisoned until the next write(2), but read(2) and mmap(2)
return errors so no more machine checks are triggered.
