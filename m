Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB67475541
	for <lists+linux-edac@lfdr.de>; Thu, 25 Jul 2019 19:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfGYRTV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Jul 2019 13:19:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:11488 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbfGYRTU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 25 Jul 2019 13:19:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 10:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="160972719"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2019 10:19:20 -0700
Date:   Thu, 25 Jul 2019 10:19:19 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: update EDAC entry to reflect current tree
 and maintainers
Message-ID: <20190725171919.GA27542@agluck-desk2.amr.corp.intel.com>
References: <1eb2d09e58500bef18428e2b3f52b54d3cd707d5.1564071419.git.mchehab+samsung@kernel.org>
 <20190725170050.GA27348@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725170050.GA27348@nazgul.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 25, 2019 at 07:00:50PM +0200, Borislav Petkov wrote:
> On Thu, Jul 25, 2019 at 12:17:35PM -0400, Mauro Carvalho Chehab wrote:
> > Tony will start to officially maintain EDAC trees. Also, we'll
> > be using a single tree for the EDAC development.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  MAINTAINERS | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 783569e3c4b4..7c22905b5aba 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5781,10 +5781,10 @@ F:	drivers/edac/thunderx_edac*
> >  EDAC-CORE
> >  M:	Borislav Petkov <bp@alien8.de>
> >  M:	Mauro Carvalho Chehab <mchehab@kernel.org>
> > +M:	Tony Luck <tony.luck@intel.com>
> >  R:	James Morse <james.morse@arm.com>
> >  L:	linux-edac@vger.kernel.org
> > -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git for-next
> > -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-edac.git linux_next
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
> >  S:	Supported
> >  F:	Documentation/admin-guide/ras.rst
> >  F:	Documentation/driver-api/edac.rst
> > -- 
> 
> Acked-by: Borislav Petkov <bp@suse.de>
> 

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
