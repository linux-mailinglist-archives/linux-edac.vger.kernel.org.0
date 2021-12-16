Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859AC4780C9
	for <lists+linux-edac@lfdr.de>; Fri, 17 Dec 2021 00:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhLPXmU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Dec 2021 18:42:20 -0500
Received: from foss.arm.com ([217.140.110.172]:49936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229511AbhLPXmT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Dec 2021 18:42:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 479E012FC;
        Thu, 16 Dec 2021 15:42:19 -0800 (PST)
Received: from bogus (unknown [10.57.33.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62073F73B;
        Thu, 16 Dec 2021 15:42:11 -0800 (PST)
Date:   Thu, 16 Dec 2021 23:42:08 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Tyler Baicar <baicar@amperemail.onmicrosoft.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Darren Hart <darren@os.amperecomputing.com>,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        Tyler Baicar <baicar@os.amperecomputing.com>,
        patches@amperecomputing.com, abdulhamid@os.amperecomputing.com,
        catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        rafael@kernel.org, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, mark.rutland@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, tabba@google.com, marcan@marcan.st,
        keescook@chromium.org, masahiroy@kernel.org,
        samitolvanen@google.com, john.garry@huawei.com,
        daniel.lezcano@linaro.org, gor@linux.ibm.com,
        zhangshaokun@hisilicon.com, tmricht@linux.ibm.com,
        dchinner@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, ishii.shuuichir@fujitsu.com,
        Vineeth.Pillai@microsoft.com
Subject: Re: [PATCH 1/2] ACPI/AEST: Initial AEST driver
Message-ID: <20211216234208.hszjx5lpurdjmftj@bogus>
References: <20211124170708.3874-1-baicar@os.amperecomputing.com>
 <20211124170708.3874-2-baicar@os.amperecomputing.com>
 <87czmpcto5.wl-maz@kernel.org>
 <YaU6eyGM+bX/bEhG@fedora>
 <87h7bum0xh.wl-maz@kernel.org>
 <YaZUL+cftvNYgx1j@fedora>
 <addaf134-d5c0-65de-62ca-76950d6460ab@amperemail.onmicrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <addaf134-d5c0-65de-62ca-76950d6460ab@amperemail.onmicrosoft.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 16, 2021 at 05:05:15PM -0500, Tyler Baicar wrote:
> -Moved ACPI for ARM64 maintainers to "to:"
> 
> Hi Marc, Darren,
> 
> On 11/30/2021 11:41 AM, Darren Hart wrote:
> > On Tue, Nov 30, 2021 at 09:45:46AM +0000, Marc Zyngier wrote:
> > > Hi Darren,
> > > 
> > > On Mon, 29 Nov 2021 20:39:23 +0000,
> > > Darren Hart <darren@os.amperecomputing.com> wrote:
> > > > On Wed, Nov 24, 2021 at 06:09:14PM +0000, Marc Zyngier wrote:
> > > > > On Wed, 24 Nov 2021 17:07:07 +0000,
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > index 5250298d2817..aa0483726606 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -382,6 +382,7 @@ ACPI FOR ARM64 (ACPI/arm64)
> > > > > >   M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > > >   M:	Hanjun Guo <guohanjun@huawei.com>
> > > > > >   M:	Sudeep Holla <sudeep.holla@arm.com>
> > > > > > +R:	Tyler Baicar <baicar@os.amperecomputing.com>
> > > > > >   L:	linux-acpi@vger.kernel.org
> > > > > >   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > > > >   S:	Maintained
> > > > > Isn't this a bit premature? This isn't even mentioned in the commit
> > > > > message, only in passing in the cover letter.
> > > > > 
> > > > Hi Marc,
> > > > 
> > > > This was something I encouraged Tyler to add during internal review,
> > > > both in response to the checkpatch.pl warning about adding new drivers
> > > > as well as our interest in reviewing any future changes to the aest
> > > > driver. Since refactoring is common, this level made sense to me - but
> > > > would it be preferable to add a new entry for just the new driver Tyler
> > > > added?
> > > Adding someone as the co-maintainer/co-reviewer of a whole subsystem
> > > (ACPI/arm64 in this case) comes, IMO, with a number of pre-requisites:
> > > has the proposed co-{maintainer,reviewer} contributed and/or reviewed
> > > a significant number of patches to that subsystem and/or actively
> > > participated in the public discussions on the design and the
> > > maintenance of the subsystem, so that their reviewing is authoritative
> > > enough? I won't be judge of this, but it is definitely something to
> > > consider.
> > Hi Marc,
> > 
> > Agreed. I applied similar criteria when considering sub maintainers for
> > the platform/x86 subsystem while I maintained it.
> > 
> > > I don't think preemptively adding someone to the MAINTAINERS entry to
> > > indicate an interest in a whole subsystem is the right way to do it.
> > > One could argue that this is what a mailing list is for! ;-) On the
> > > other hand, an active participation to the review process is the
> > > perfect way to engage with fellow developers and to grow a profile. It
> > > is at this stage that adding oneself as an upstream reviewer makes a
> > > lot of sense.
> > Also generally agree. In this specific case, our interest was in the
> > driver itself, and we had to decide between the whole subsystem or
> > adding another F: entry in MAINTAINERS for the specific driver. Since
> > drivers/acpi/arm64 only has 3 .c files in it, adding another entry
> > seemed premature and overly granular. Certainly a subjective thing and
> > we have no objection to adding the extra line if that's preferred. This
> > should have been noted in the commit message.
> 
> Thank you for the feedback here, I will make sure to add this to the commit
> message and cover letter in the next version.

Hi Marc,

Thanks for responding and providing all the necessary details.

> 
> Hi Lorenzo, Hanjun, Sudeep,
> 
> As for adding myself as a reviewer under ACPI for ARM64 or adding another F:
> entry, do you have a preference or guidance on what I should do here?
>

I prefer to start with an entry specific to the $subject driver for all
the reasons Marc has already stated. It may also add confusion and provide
misleading reference to others who want to maintain specific drivers like
this in the future. Further it will result in this list to grow even though
not all in that will be interested in reviewing or maintaining ARM64
ACPI subsystem if we take the approach in this patch and more confusion
to the developers.

Ofcourse if you are interested and get engaged in the review of ARM64
ACPI in the future we can always revisit and update accordingly.

Hope this helps and provides clarification you are looking for.

-- 
Regards,
Sudeep
