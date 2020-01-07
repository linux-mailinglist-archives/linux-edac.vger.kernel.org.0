Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2D0F13351D
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2020 22:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgAGVnN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Jan 2020 16:43:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:11754 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgAGVnM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 7 Jan 2020 16:43:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 13:43:12 -0800
X-IronPort-AV: E=Sophos;i="5.69,407,1571727600"; 
   d="scan'208";a="215734490"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 13:43:11 -0800
Date:   Tue, 7 Jan 2020 13:43:10 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     'Aristeu Rozanski' <aris@redhat.com>,
        "'linux-edac@vger.kernel.org'" <linux-edac@vger.kernel.org>,
        'Mauro Carvalho Chehab' <mchehab@kernel.org>
Subject: Re: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Message-ID: <20200107214310.GA31851@agluck-desk2.amr.corp.intel.com>
References: <20191204212325.c4k47p5hrnn3vpb5@redhat.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F13AB@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F19BD@ORSMSX115.amr.corp.intel.com>
 <20191210090013.GA9395@zn.tnic>
 <20200106151242.vkdiiwhubmkx5osh@redhat.com>
 <20200106161732.GF12238@zn.tnic>
 <20200106162013.cbbeo4ezdp2h7p62@redhat.com>
 <20200106162306.GG12238@zn.tnic>
 <20200107155109.6gphrtqb2a7q4unn@redhat.com>
 <20200107164528.GD29542@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107164528.GD29542@zn.tnic>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 07, 2020 at 05:45:28PM +0100, Borislav Petkov wrote:
> On Tue, Jan 07, 2020 at 10:51:09AM -0500, 'Aristeu Rozanski' wrote:
> > On Mon, Jan 06, 2020 at 05:23:06PM +0100, Borislav Petkov wrote:
> > > I'm not saying you should blindly remove them. They might be useful for
> > > debugging purposes so you should consider that usage angle first. In the
> > > AMD case, the message was really useless.
> > 
> > Ah, I thought you had an objection to this patch :)
> > Do you mind considering it for inclusion?
> 
> That's Tony's call as he's maintaining the Intel side of EDAC.

Already applied to git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
in edac-for-next branch.  Sorry, should have sent you an "Applied" message.

-Tony
