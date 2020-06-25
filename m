Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133DD20982B
	for <lists+linux-edac@lfdr.de>; Thu, 25 Jun 2020 03:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbgFYBSu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 Jun 2020 21:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389070AbgFYBSt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 24 Jun 2020 21:18:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0D4C061573
        for <linux-edac@vger.kernel.org>; Wed, 24 Jun 2020 18:18:49 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i14so4285137ejr.9
        for <linux-edac@vger.kernel.org>; Wed, 24 Jun 2020 18:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4SbnhufIhFwUeLYjq//w5IgB7McV3UjnK5Yim7wGXg=;
        b=GkfLZv27NlldN1p9efCfUh68aBGua1m/E0IDMwrhVAM9qK/647Os4nH8dIxNjhsOqc
         XxXafBFCNEkni9yD2TP5XvE7ucQKFj85hXPPaFpWvrggTcyjYUsSfbGpavynYgHF20QB
         hlFeF9e4YSjb7iIqqLLJdqKTR7iA1vLFyxN5P0AhRNsKwk04VsYSks82tS6V5D9AwRtH
         TTFpvgZ4coc54Wd695cp3TMTuco50/QjYEDuPPrRMLFWG/hFOFyc9yLCJ0QSotZtdDmw
         vHKJJ1zF4X3LlKWDr1wEbbDtZgeHTDmyDQjwexpJ0aq1yufduCIYKTQdqhxyI3m2N3Se
         ISrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4SbnhufIhFwUeLYjq//w5IgB7McV3UjnK5Yim7wGXg=;
        b=F76hOXOS+hNIOAz3FrAYSfekcnumncpbY3w2+nsfg04o+/a4dDk2MVQ2JZW46UAQv3
         IhSZZzJSVqamWE4l9H+j+T2zk+e7EwjsHMjwLREuTHjZ8Fkc+MojBzFrOhyCs0SAtwpJ
         wKWTe5H1ePjOpu3iqesX4cTUXJT0ItqT4Oe5nsNesg7KKBtkp3RI+bnbIk5e7m+5DkKr
         OlRNlhJoTXZvufqiABMkh2OWVuO+/rny/d27IIV4/aJEwV4DFSAMFRjEgHWxrdFshPHI
         an/FBX3Iy8RE5pacifQTnP+UvRmF2LGzPFi3kN1aj//JxeA7aH8J+P2LAicREvK7dErk
         fi7w==
X-Gm-Message-State: AOAM531OCHgIGqVYcLVk61VGC+rEznHV6qZ6ralPvym7Do1xvPYeYCPE
        b7OHcCLtHReLN2qrzBPzr0j0raWhkhxyvEcICdNV+g==
X-Google-Smtp-Source: ABdhPJx7BojfkBEjdHBDZ426CyZlfaUL38+iK1GwoaIHiJf9eIxvBXchz95mC8yWN+jGnPuungCJl88pJiT/qc8CsXo=
X-Received: by 2002:a17:906:f98e:: with SMTP id li14mr21127580ejb.174.1593047928170;
 Wed, 24 Jun 2020 18:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200623201745.GG21350@casper.infradead.org> <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <20200623221741.GH21350@casper.infradead.org> <20200623222658.GA21817@agluck-desk2.amr.corp.intel.com>
 <20200623224027.GI21350@casper.infradead.org> <20200624000124.GH7625@magnolia>
 <20200624121000.GM21350@casper.infradead.org> <CAPcyv4joCu00OXV9da3eoQVqM_FTwELQa6=YdwXjZCtyxy13bg@mail.gmail.com>
 <20200625001740.GX21350@casper.infradead.org>
In-Reply-To: <20200625001740.GX21350@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Jun 2020 18:18:37 -0700
Message-ID: <CAPcyv4i0Myp+wjwOk8Gofo-PUmxmoD7GyzwJ_kEzGdcCbe73qA@mail.gmail.com>
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

On Wed, Jun 24, 2020 at 5:17 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jun 24, 2020 at 04:21:24PM -0700, Dan Williams wrote:
> > On Wed, Jun 24, 2020 at 5:10 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Tue, Jun 23, 2020 at 05:01:24PM -0700, Darrick J. Wong wrote:
> > > > Frankly, I've wondered why the filesystem shouldn't just be in charge of
> > > > all this--
> > > >
> > > > 1. kernel receives machine check
> > > > 2. kernel tattles to xfs
> > > > 3. xfs looks up which file(s) own the pmem range
> > > > 4. xfs zeroes the region, clears the poison, and sets AS_EIO on the
> > > >    files
> > >
> > > ... machine reboots, app restarts, gets no notification anything is wrong,
> > > treats zeroed region as good data, launches nuclear missiles.
> >
> > Isn't AS_EIO stored persistently in the file block allocation map?
>
> No.  AS_EIO is in mapping->flags.  Unless Darrick was using "sets AS_EIO"
> as shorthand for something else.
>
> > Even if it isn't today that is included in the proposal that the
> > filesystem maintains a list of poison that is coordinated with the
> > pmem driver.
>
> I'd like to see a concrete proposal here.

There's still details to work through with respect to reflink. The
latest discussion was that thread I linked about how to solve the
page->index collision [1] for reverse mapping pages to files.

[1]: https://lore.kernel.org/linux-ext4/20200311063942.GE10776@dread.disaster.area/

>
> > > > Apps shouldn't have to do this punch-and-reallocate dance, seeing as
> > > > they don't currently do that for SCSI disks and the like.
> > >
> > > The SCSI disk retains the error until the sector is rewritten.
> > > I'm not entirely sure whether you're trying to draw an analogy with
> > > error-in-page-cache or error-on-storage-medium.
> > >
> > > error-on-medium needs to persist until the app takes an affirmative step
> > > to clear it.  I presume XFS does not write zeroes to sectors with
> > > errors on SCSI disks ...
> >
> > SCSI does not have an async mechanism to retrieve a list of poisoned
> > blocks from the hardware (that I know of), pmem does. I really think
> > we should not glom on pmem error handling semantics on top of the same
> > infrastructure that it has handling volatile / replaceable pages. When
>
> Erm ... commit 6100e34b2526 has your name on it.

Yes, and we're having this conversation because it turns out
mm/memory-failure.c enabling for DAX is insufficient.

>
> > the filesystem is enabled to get involved it should impose a different
> > model than generic memory error handling especially because generic
> > memory-error handling has no chance to solve the reflink problem.
> >
> > If an application wants to survive poison consumption, signals seem
> > only sufficient for interrupting an application that needs to take
> > immediate action because one of its instructions was prevented from
> > making forward progress. The interface for enumerating the extent of
> > errors for DAX goes beyond what signinfo can reasonably convey, that
> > piece is where the filesystem can be called to discover which file
> > extents are impacted by poison.
> >
> > I like Darrick's idea that the kernel stabilizes the storage by
> > default, and that the repair mechanism is just a write(2). I assume
> > "stabilize" means make sure that the file offset is permanently
> > recorded as poisoned until the next write(2), but read(2) and mmap(2)
> > return errors so no more machine checks are triggered.
>
> That seems like something we'd want to work into the iomap infrastructure,
> perhaps.  Add an IOMAP_POISONED to indicate this range needs to be
> written before it can be read?

Yes, an explicit error state for an extent range is needed for the fs
to offload the raw hardware poison list into software tracking.
