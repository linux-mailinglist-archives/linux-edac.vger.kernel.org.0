Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD2B2066DD
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jun 2020 00:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbgFWWEP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Jun 2020 18:04:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:46537 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387729AbgFWWEO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 23 Jun 2020 18:04:14 -0400
IronPort-SDR: Py0YsR7+aU1B+l8NY7sdPI/fDcc0m/UgIddYanhYJfwrvRqJA4j3X8aEgLAehPgYNnOZR8k7GB
 IKqP/LR+X++Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="123914850"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="123914850"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 15:04:13 -0700
IronPort-SDR: U6/VHjLAHIDc7wJRSFOh4hSGDw0bnpwNPm+jz2L51Xa0Aqu/d+FkkroMJB2muFI0l5naqfsMkJ
 WAGdzb25lOxA==
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="478904509"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 15:04:13 -0700
Date:   Tue, 23 Jun 2020 15:04:12 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [RFC] Make the memory failure blast radius more precise
Message-ID: <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
References: <20200623201745.GG21350@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623201745.GG21350@casper.infradead.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 23, 2020 at 09:17:45PM +0100, Matthew Wilcox wrote:
> 
> Hardware actually tells us the blast radius of the error, but we ignore
> it and take out the entire page.  We've had a customer request to know
> exactly how much of the page is damaged so they can avoid reconstructing
> an entire 2MB page if only a single cacheline is damaged.
> 
> This is only a strawman that I did in an hour or two; I'd appreciate
> architectural-level feedback.  Should I just convert memory_failure() to
> always take an address & granularity?  Should I create a struct to pass
> around (page, phys, granularity) instead of reconstructing the missing
> pieces in half a dozen functions?  Is this functionality welcome at all,
> or is the risk of upsetting applications which expect at least a page
> of granularity too high?

What is the interface to these applications that want finer granularity?

Current code does very poorly with hugetlbfs pages ... user loses the
whole 2 MB or 1GB. That's just silly (though I've been told that it is
hard to fix because allowing a hugetlbfs page to be broken up at an arbitrary
time as the result of a mahcine check means that the kernel needs locking
around a bunch of fas paths that currently assume that a huge page will
stay being a huge page).

For sub-4K page usage, there are different problems. We can't leave the
original page with the poisoned cache line mapped to the user as they may
just access the poison data and trigger another machine check. But if we
map in some different page with all the good bits copied, the user needs
to be aware which parts of the page no longer have their data.

-Tony
