Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A70A245219
	for <lists+linux-edac@lfdr.de>; Sat, 15 Aug 2020 23:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgHOVmd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 15 Aug 2020 17:42:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:22594 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgHOVmc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 15 Aug 2020 17:42:32 -0400
IronPort-SDR: Vr93dfiLe4V4gQgGI0Ykv/q1TQ6lITZQEjuiusAICBvxGnJNAIDwXKyvHfVwGRU10iK/3c6wOM
 siEJLWDxROUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9714"; a="155641019"
X-IronPort-AV: E=Sophos;i="5.76,317,1592895600"; 
   d="scan'208";a="155641019"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2020 10:21:05 -0700
IronPort-SDR: Qce1Qa4j4E+CYhjuQPflNd6xCkbPt4BehQ3FdjzFRWIXKCA3zfigcFUvRtHQ3XV7LyyHkQqDhO
 xToqNL+1+1RQ==
X-IronPort-AV: E=Sophos;i="5.76,317,1592895600"; 
   d="scan'208";a="440428673"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2020 10:21:05 -0700
Date:   Sat, 15 Aug 2020 10:21:03 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [GIT PULL] edac for v5.9 (part 2)
Message-ID: <20200815172103.GA1628@agluck-desk2.amr.corp.intel.com>
References: <20200815003645.GA22594@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgFg+RNU3Aa7paCPCLpUiTHGN1PuC2AGZoRSOxD=trKnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgFg+RNU3Aa7paCPCLpUiTHGN1PuC2AGZoRSOxD=trKnQ@mail.gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Aug 15, 2020 at 08:21:13AM -0700, Linus Torvalds wrote:
> On Fri, Aug 14, 2020 at 5:36 PM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > Here's one more pull for EDAC with a driver that I let slip
> > through the cracks.
> 
> Shortlog? Diffstat? Just what am I getting?

Ah. Looking at bash history I fumbled arguments to git pleasepull. Second try:

The following changes since commit 0f959e19fadf00638b686fdeb70e24dfcc7bbcac:

  Merge branch 'edac-ghes' into edac-for-next (2020-06-22 15:28:01 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_5.9_pt2

for you to fetch changes up to 709ed1bcef12398ac1a35c149f3e582db04456c2:

  EDAC/ie31200: Fallback if host bridge device is already initialized (2020-08-10 11:13:06 -0700)

----------------------------------------------------------------
Fixes for ie31200 driver that missed the first pull

----------------------------------------------------------------
Jason Baron (1):
      EDAC/ie31200: Fallback if host bridge device is already initialized

 drivers/edac/ie31200_edac.c | 50 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

-Tony
